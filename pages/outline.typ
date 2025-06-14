#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title, header

#let outline_page(anonymous: false) = {
  show outline.entry.where(level: 1): set outline.entry(fill: [
    #set text(font: "Calibri", top-edge: "cap-height", bottom-edge: "baseline")
    #repeat([.])
  ])
  set outline.entry(fill: [
    #set text(top-edge: "cap-height", bottom-edge: "baseline")
    #set text(font: "SimSun", top-edge: "cap-height", bottom-edge: "baseline")
    #repeat([.])
  ])
  show outline.entry: set text(font: 字体.宋体, size: 字号.小四)
  // show outline.entry.where(level: 1): set text(font: 字体.黑体)
  show outline.entry.where(level: 1): set text(font: "SimHei")

  let gap = 4pt
  show outline.entry: set block(above: gap)
  show outline.entry.where(level: 1): set block(above: gap + 6pt, below: gap + 6pt)

  set page(header: header("目录", anonymous: anonymous))

  page_title([目#h(2em)录], use_heading: true)

  outline(
    title: none,
    target: (heading),
    indent: 1em,
  )

  pagebreak(weak: true, to: "odd")
}

