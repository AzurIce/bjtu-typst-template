// Package for writing pseudocode, see: https://typst.app/universe/package/lovelace/
#import "@preview/lovelace:0.3.0"
// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold
// Package for Configurable figure and equation numbering per section, see: https://typst.app/universe/package/i-figured
#import "@preview/i-figured:0.2.4"

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
    // set align(center)
    set text(weight: "regular", font: 字体.黑体, size: 字号.三号)
    block(inset: (top: 24pt, bottom: 18pt))[
      #it
    ]
  }
  // 第二层次（节）题序和标题用小三号黑体字；
  show heading.where(level: 2): it => {
    set text(weight: "regular", font: 字体.黑体, size: 字号.小三)
    block(inset: (top: 24pt, bottom: 18pt))[
      #it
    ]
  }
  // 第三层次（条）题序和标题用四号黑体字；
  show heading.where(level: 3): it => {
    set text(weight: "regular", font: 字体.黑体, size: 字号.四号)
    block(inset: (top: 24pt, bottom: 18pt))[
      #it
    ]
  }
  // 第四及以下层次（款）题序和标题用小四号黑体字；
  show heading.where(level: 4): it => {
    set text(weight: "regular", font: 字体.黑体, size: 字号.小四)
    block(inset: (top: 24pt, bottom: 18pt))[
      #it
    ]
  }

  body
}

#let show_body(body) = {
  // 正文用小四号宋体或楷体字。正文行间距为固定值 20 磅。
  set text(font: 字体.宋体, size: 字号.小四)

  // 用于模仿 word 排版方式
  // See: https://github.com/typst/typst/issues/106#issuecomment-2041051807
  set text(top-edge: 0.7em, bottom-edge: -0.3em)
  set par(spacing: 20pt-1em, leading: 20pt-1em, first-line-indent: 2em)

  body
}

#let show_figure(body) = {
  show heading: i-figured.reset-counters
  show figure: i-figured.show-figure.with(
    numbering: "1-1"
  )
  show figure: set text(size: 字号.五号)

  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  show figure: set align(center)

  body
}

#let show_table(body) = {
  show table: set align(center)
  show table: block.with(stroke: (y: 1pt))
  set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 0.7pt + black)
    }
  )
  body
}

#let show_math(body) = {
  show math.equation: i-figured.show-equation.with(
    numbering: "(1-1)"
  )
  body
}