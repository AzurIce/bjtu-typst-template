// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title, header

#let outline_page() = {
  show: show-cn-fakebold

  show outline.entry.where(level: 1): set text(font: 字体.黑体, size: 字号.小四)

  set page(header: header("目录"))

  page_title([目#h(2em)录], use_heading: true)
  
  outline(
    title: none,
    target: (heading),
    indent: 1em
  )

  pagebreak(weak: true)
}

