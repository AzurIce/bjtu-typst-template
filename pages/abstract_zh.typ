// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title, header

#let abstract_page_zh(
  keywords: (),
  body
) = {
  show: show-cn-fakebold

  set page(header: header("中文摘要"))

  page_title("中文摘要", use_heading: true)
  
  text(weight: "bold")[摘要：]
  text[#body]
  
  linebreak()
  linebreak()
  linebreak()

  let keywords = keywords.join("；")

  text(weight: "bold")[关键词：]
  text[#keywords；]

  pagebreak(weak: true)
}

