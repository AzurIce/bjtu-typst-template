// Package for writing pseudocode, see: https://typst.app/universe/package/lovelace/
#import "@preview/lovelace:0.3.0"
// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold
// Package for Configurable figure and equation numbering per section, see: https://typst.app/universe/package/i-figured
#import "@preview/i-figured:0.2.4"

#import "components.typ": header
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
  show heading: it => block(it)
  show heading: set block(inset: (top: 24pt, bottom: 18pt), spacing: 20pt-1em)
  // 第一层次（章）题序和标题用三号黑体字；
  show heading.where(level: 1): set text(weight: "regular", font: 字体.黑体, size: 字号.三号)
  // 第二层次（节）题序和标题用小三号黑体字；
  show heading.where(level: 2): set text(weight: "regular", font: 字体.黑体, size: 字号.小三)
  // 第三层次（条）题序和标题用四号黑体字；
  show heading.where(level: 3): set text(weight: "regular", font: 字体.黑体, size: 字号.四号)
  // 第四及以下层次（款）题序和标题用小四号黑体字；
  show heading.where(level: 4): set text(weight: "regular", font: 字体.黑体, size: 字号.小四)
  show heading: i-figured.reset-counters.with(extra-kinds: ("image",))

  body
}

// #let show_body(body) = {
//   // 正文用小四号宋体或楷体字。正文行间距为固定值 20 磅。
//   set text(font: 字体.宋体, size: 字号.小四)

//   // 用于模仿 word 排版方式
//   // See: https://github.com/typst/typst/issues/106#issuecomment-2041051807
//   set text(top-edge: 0.7em, bottom-edge: -0.3em)
//   set par(spacing: 20pt-1em, leading: 20pt-1em, first-line-indent: 2em)

//   body
// }

#let show_figure(body) = {
  show figure.where(kind: "image"): i-figured.show-figure.with(
    extra-prefixes: (image: "img:"),
    numbering: "1-1"
  )
  show figure.where(kind: table): i-figured.show-figure.with(numbering: "1-1")

  show figure.where(kind: "image"): (it) => {
    counter(figure.where(kind: "subimage")).update(0)
    it
  }
  show figure.where(kind: "subimage"): set figure(numbering: "(a)", supplement: "")
  show figure.where(
    kind: "subimage"
  ): set figure.caption(separator: "")

  show figure: set text(size: 字号.五号)

  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  show figure.where(
    kind: table
  ): set figure(supplement: "表")
  show figure.where(
    kind: "image"
  ): set figure(supplement: "图")
  show figure: set align(center)
  show figure: (it) => {
    block(it, above: 1.5em, below: 1.5em)
    // v(0.5em)
    // it
    // v(0.5em)
  }

  body
}

#let show_table(body) = {
  show table: set align(center)
  show table: block.with(stroke: (y: 1pt))
  show table: set par(leading: 0.5em)
  body
}

#let show_math(body) = {
  set math.equation(supplement: [公式])
  show math.equation: i-figured.show-equation.with(
    numbering: "(1-1)"
  )
  body
}

// 整个文档的样式设置
#let show_doc(info: (:), it) = {
  show par: (it) => {
    if info.debug {
      set block(fill: blue)
      block(it)
    } else {
      it
    }
  }
  show block: set block(stroke: red) if info.debug
  // show text.where(weight: "bold").or(strong): it => {
  //   show regex("\p{script=Han}"): set text(stroke: 0.02857em)
  //   it
  // }
  show: show-cn-fakebold

  set page(paper: "a4", margin: (
    top: 3cm,
    bottom: 2.5cm,
    left: 2.5cm,
    right: 2.5cm
  ))
  // 正文用小四号宋体或楷体字。正文行间距为固定值 20 磅。
  set text(font: 字体.宋体, size: 字号.小四)

  // 用于模仿 word 排版方式
  // See: https://github.com/typst/typst/issues/106#issuecomment-2041051807
  set text(top-edge: 0.7em, bottom-edge: -0.3em)
  set par(spacing: 20pt-1em, leading: 20pt-1em, first-line-indent: 2em, justify: true)

  show: show_figure
  show: show_table
  show: show_math

  show bibliography: set text(font: 字体.宋体, size: 字号.五号)

  set document(
    title: info.title,
    author: info.author,
    date: info.date,
  )

  it
}

#let show_main(it) = {
  show: show_heading
  set page(header: header("正文"))

  set page(numbering: "1")
  counter(page).update(1)

  it
}