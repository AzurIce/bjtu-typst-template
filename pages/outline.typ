#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title, header

#let outline_page(anonymous: false) = {
  show outline.entry.where(level: 1): set text(font: 字体.黑体, size: 字号.小四)

  set page(header: header("目录", anonymous: anonymous))

  page_title([目#h(2em)录], use_heading: true)

  outline(
    title: none,
    target: (heading),
    indent: 1em,
  )

  pagebreak(weak: true, to: "odd")
}

