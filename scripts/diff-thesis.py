#!/usr/bin/env python3
"""Render and compare the thesis template against a Git baseline."""

from __future__ import annotations

import argparse
import os
import shutil
import struct
import subprocess
import tarfile
import tempfile
import zlib
from pathlib import Path


PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"


def run(command: list[str], cwd: Path, env: dict[str, str] | None = None) -> None:
    print("$ " + " ".join(command))
    subprocess.run(command, cwd=cwd, env=env, check=True)


def git_output(args: list[str], cwd: Path) -> str:
    return subprocess.check_output(["git", *args], cwd=cwd, text=True).strip()


def repo_root() -> Path:
    return Path(git_output(["rev-parse", "--show-toplevel"], Path.cwd()))


def read_png(path: Path) -> tuple[int, int, bytes]:
    data = path.read_bytes()
    if not data.startswith(PNG_SIGNATURE):
        raise ValueError(f"{path} is not a PNG file")

    pos = len(PNG_SIGNATURE)
    width = height = None
    color_type = None
    bit_depth = None
    idat = bytearray()

    while pos < len(data):
        length = struct.unpack(">I", data[pos:pos + 4])[0]
        chunk_type = data[pos + 4:pos + 8]
        chunk_data = data[pos + 8:pos + 8 + length]
        pos += 12 + length

        if chunk_type == b"IHDR":
            width, height, bit_depth, color_type = struct.unpack(">IIBB", chunk_data[:10])
            if bit_depth != 8 or color_type not in (2, 6):
                raise ValueError(f"{path} uses unsupported PNG format")
        elif chunk_type == b"IDAT":
            idat.extend(chunk_data)
        elif chunk_type == b"IEND":
            break

    if width is None or height is None or color_type is None:
        raise ValueError(f"{path} is missing PNG image metadata")

    channels = 3 if color_type == 2 else 4
    raw = zlib.decompress(bytes(idat))
    stride = width * channels
    rows: list[bytes] = []
    prev = [0] * stride
    offset = 0

    for _ in range(height):
        filter_type = raw[offset]
        offset += 1
        row = list(raw[offset:offset + stride])
        offset += stride

        for i, value in enumerate(row):
            left = row[i - channels] if i >= channels else 0
            up = prev[i]
            up_left = prev[i - channels] if i >= channels else 0
            if filter_type == 0:
                predictor = 0
            elif filter_type == 1:
                predictor = left
            elif filter_type == 2:
                predictor = up
            elif filter_type == 3:
                predictor = (left + up) // 2
            elif filter_type == 4:
                predictor = paeth(left, up, up_left)
            else:
                raise ValueError(f"{path} uses unsupported PNG filter {filter_type}")
            row[i] = (value + predictor) & 0xFF

        prev = row
        if channels == 3:
            rows.append(bytes(row))
        else:
            rgb = bytearray()
            for i in range(0, len(row), 4):
                alpha = row[i + 3]
                rgb.extend(blend_on_white(row[i], row[i + 1], row[i + 2], alpha))
            rows.append(bytes(rgb))

    return width, height, b"".join(rows)


def paeth(left: int, up: int, up_left: int) -> int:
    p = left + up - up_left
    pa = abs(p - left)
    pb = abs(p - up)
    pc = abs(p - up_left)
    if pa <= pb and pa <= pc:
        return left
    if pb <= pc:
        return up
    return up_left


def blend_on_white(red: int, green: int, blue: int, alpha: int) -> tuple[int, int, int]:
    return (
        (red * alpha + 255 * (255 - alpha)) // 255,
        (green * alpha + 255 * (255 - alpha)) // 255,
        (blue * alpha + 255 * (255 - alpha)) // 255,
    )


def write_png(path: Path, width: int, height: int, pixels: bytes) -> None:
    stride = width * 3
    raw = bytearray()
    for y in range(height):
        raw.append(0)
        raw.extend(pixels[y * stride:(y + 1) * stride])

    def chunk(kind: bytes, payload: bytes) -> bytes:
        checksum = zlib.crc32(kind)
        checksum = zlib.crc32(payload, checksum)
        return struct.pack(">I", len(payload)) + kind + payload + struct.pack(">I", checksum & 0xFFFFFFFF)

    png = bytearray(PNG_SIGNATURE)
    png.extend(chunk(b"IHDR", struct.pack(">IIBBBBB", width, height, 8, 2, 0, 0, 0)))
    png.extend(chunk(b"IDAT", zlib.compress(bytes(raw), level=9)))
    png.extend(chunk(b"IEND", b""))
    path.write_bytes(bytes(png))


def combine_pages(
    base_path: Path,
    current_path: Path,
    output_path: Path,
    threshold: int,
) -> tuple[int, float, tuple[int, int, int, int] | None]:
    width, height, base = read_png(base_path)
    current_width, current_height, current = read_png(current_path)
    if (width, height) != (current_width, current_height):
        raise ValueError(f"page size differs: {base_path.name}")

    total_pixels = width * height
    changed_pixels = 0
    bbox: list[int] | None = None
    diff = bytearray(len(base))

    for i in range(0, len(base), 3):
        b = base[i:i + 3]
        c = current[i:i + 3]
        delta = max(abs(c[j] - b[j]) for j in range(3))
        pixel = i // 3
        x = pixel % width
        y = pixel // width

        if delta > threshold:
            changed_pixels += 1
            if bbox is None:
                bbox = [x, y, x, y]
            else:
                bbox[0] = min(bbox[0], x)
                bbox[1] = min(bbox[1], y)
                bbox[2] = max(bbox[2], x)
                bbox[3] = max(bbox[3], y)

            base_dark = sum(b) < 720
            current_dark = sum(c) < 720
            if current_dark and not base_dark:
                diff[i:i + 3] = b"\xd8\x1b\x60"  # red: added/darker in current
            elif base_dark and not current_dark:
                diff[i:i + 3] = b"\x1f\x77\xb4"  # blue: removed/lighter in current
            else:
                diff[i:i + 3] = b"\x7a\x3e\x9d"  # purple: changed in both
        else:
            diff[i:i + 3] = b"\xff\xff\xff"

    label_height = 42
    gap = 8
    sheet_width = width * 3 + gap * 2
    sheet_height = height + label_height
    sheet = bytearray(b"\xff" * sheet_width * sheet_height * 3)

    paste(sheet, sheet_width, base, width, height, 0, label_height)
    paste(sheet, sheet_width, current, width, height, width + gap, label_height)
    paste(sheet, sheet_width, bytes(diff), width, height, width * 2 + gap * 2, label_height)
    draw_labels(sheet, sheet_width, sheet_height, width, gap)
    write_png(output_path, sheet_width, sheet_height, bytes(sheet))

    normalized_bbox = None if bbox is None else (bbox[0], bbox[1], bbox[2], bbox[3])
    return changed_pixels, changed_pixels / total_pixels * 100, normalized_bbox


def paste(
    target: bytearray,
    target_width: int,
    source: bytes,
    source_width: int,
    source_height: int,
    x_offset: int,
    y_offset: int,
) -> None:
    row_bytes = source_width * 3
    for y in range(source_height):
        target_start = ((y + y_offset) * target_width + x_offset) * 3
        source_start = y * row_bytes
        target[target_start:target_start + row_bytes] = source[source_start:source_start + row_bytes]


def draw_labels(sheet: bytearray, width: int, height: int, page_width: int, gap: int) -> None:
    # Minimal label band without requiring a font renderer.
    for y in range(34):
        for x in range(width):
            i = (y * width + x) * 3
            sheet[i:i + 3] = b"\xf5\xf5\xf5"
    for x in (page_width, page_width + gap - 1, page_width * 2 + gap, page_width * 2 + gap * 2 - 1):
        if 0 <= x < width:
            for y in range(height):
                i = (y * width + x) * 3
                sheet[i:i + 3] = b"\xdd\xdd\xdd"


def render_pages(root: Path, output_pattern: Path, ppi: int, timestamp: str) -> None:
    env = os.environ.copy()
    env["SOURCE_DATE_EPOCH"] = timestamp
    run(
        [
            "typst",
            "compile",
            "--root",
            str(root),
            "--format",
            "png",
            "--ppi",
            str(ppi),
            "template/thesis.typ",
            str(output_pattern),
        ],
        cwd=root,
        env=env,
    )


def export_baseline(ref: str, destination: Path, cwd: Path) -> None:
    archive = subprocess.Popen(
        ["git", "archive", "--format=tar", ref],
        cwd=cwd,
        stdout=subprocess.PIPE,
    )
    assert archive.stdout is not None
    with tarfile.open(fileobj=archive.stdout, mode="r|") as tar:
        tar.extractall(destination, filter="data")
    if archive.wait() != 0:
        raise subprocess.CalledProcessError(archive.returncode, ["git", "archive", "--format=tar", ref])


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--base", default="origin/main", help="Git ref used as the baseline")
    parser.add_argument("--out", default="tmp/thesis-diff", help="Output directory")
    parser.add_argument("--ppi", type=int, default=96, help="PNG render resolution")
    parser.add_argument("--threshold", type=int, default=12, help="Per-channel pixel threshold")
    parser.add_argument("--keep-pages", action="store_true", help="Keep rendered baseline/current page PNGs")
    parser.add_argument(
        "--timestamp",
        default="1717200000",
        help="SOURCE_DATE_EPOCH used for reproducible renders; use an empty string to inherit the environment",
    )
    args = parser.parse_args()

    root = repo_root()
    output_dir = (root / args.out).resolve()
    baseline_dir = output_dir / "baseline-pages"
    current_dir = output_dir / "current-pages"
    diff_dir = output_dir / "diff-pages"

    if output_dir.exists():
        shutil.rmtree(output_dir)
    baseline_dir.mkdir(parents=True)
    current_dir.mkdir(parents=True)
    diff_dir.mkdir(parents=True)

    timestamp = args.timestamp if args.timestamp else os.environ.get("SOURCE_DATE_EPOCH", "1717200000")
    with tempfile.TemporaryDirectory(prefix="thesis-baseline-") as tmp:
        baseline_root = Path(tmp)
        export_baseline(args.base, baseline_root, root)
        render_pages(baseline_root, baseline_dir / "page-{0p}.png", args.ppi, timestamp)

    render_pages(root, current_dir / "page-{0p}.png", args.ppi, timestamp)

    baseline_pages = sorted(baseline_dir.glob("page-*.png"))
    current_pages = sorted(current_dir.glob("page-*.png"))
    if len(baseline_pages) != len(current_pages):
        raise RuntimeError(f"page count differs: baseline={len(baseline_pages)} current={len(current_pages)}")

    summary = [
        f"base: {args.base}",
        f"pages: {len(current_pages)}",
        f"ppi: {args.ppi}",
        f"threshold: {args.threshold}",
        "",
        "page changed_px changed_% bbox",
    ]
    changed = []
    for page_no, (base_page, current_page) in enumerate(zip(baseline_pages, current_pages), 1):
        diff_path = diff_dir / f"page-{page_no:02d}-comparison.png"
        changed_pixels, changed_percent, bbox = combine_pages(base_page, current_page, diff_path, args.threshold)
        if changed_pixels:
            changed.append(page_no)
            summary.append(f"{page_no:>2} {changed_pixels:>8} {changed_percent:6.3f}% {bbox}")
        else:
            diff_path.unlink()

    summary.append("")
    summary.append("legend:")
    summary.append("- red: pixels added or darkened in the current working tree")
    summary.append("- blue: pixels removed or lightened from the baseline")
    summary.append("- purple: pixels changed in both directions")
    summary.append("")
    summary.append("diff images:")
    if changed:
        for page_no in changed:
            summary.append(str((diff_dir / f"page-{page_no:02d}-comparison.png").resolve()))
    else:
        summary.append("none")

    summary_path = output_dir / "summary.txt"
    summary_path.write_text("\n".join(summary) + "\n", encoding="utf-8")
    if not args.keep_pages:
        shutil.rmtree(baseline_dir)
        shutil.rmtree(current_dir)
    print(summary_path)
    return 1 if changed else 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as error:
        raise SystemExit(error.returncode)
