// Package for writing pseudocode, see: https://typst.app/universe/package/lovelace/
#import "@preview/lovelace:0.3.0"
// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "variables.typ": *

// 参考自 https://github.com/werifu/HUST-typst-template/blob/5261d9202bdd0eefae0f8922b32770f02cf15e4f/utilities/set-heading.typ
#let show_heading(body) = {
  show: show-cn-fakebold

  set heading(numbering: "1.1.1.1")

  // 参考自 https://github.com/nju-lug/modern-nju-thesis/blob/main/utils/custom-heading.typ
  show heading: it =>{
    if it != none {
      set par(first-line-indent: 0em)
      if it.has("numbering") and it.numbering != none {
      numbering(it.numbering, ..counter(heading).at(it.location()))
      [ ]
      }
      it.body
    } else {
        ""
    }
  }
  // 第一层次（章）题序和标题用三号黑体字；
  show heading.where(level: 1): it => {
    set align(center)
    set text(weight: "bold", font: 字体.黑体, size: 字号.三号)
    set block(spacing: 1.5em)
    it
  }
  // 第二层次（节）题序和标题用小三号黑体字；
  show heading.where(level: 2): it => {
    set text(weight: "bold", font: 字体.黑体, size: 字号.小三)
    set block(above: 1.5em, below: 1.5em)
    it
  }
  // 第三层次（条）题序和标题用四号黑体字；
  show heading.where(level: 3): it => {
    set text(weight: "bold", font: 字体.黑体, size: 字号.四号)
    set block(above: 1.5em, below: 1.5em)
    it
  }
  // 第四及以下层次（款）题序和标题用小四号黑体字；
  show heading.where(level: 4): it => {
    set text(weight: "bold", font: 字体.黑体, size: 字号.小四)
    set block(above: 1.5em, below: 1.5em)
    it
  }

  body
}

#let show_body(body) = {
  // 正文用小四号宋体或楷体字。正文行间距为固定值 20 磅。
  set text(font: 字体.宋体, size: 字号.小四)
  set par(justify: false, leading: 20pt, first-line-indent: 2em)

  body
}