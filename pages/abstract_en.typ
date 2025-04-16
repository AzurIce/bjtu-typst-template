// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title, header

#let abstract_en(
  abstract: "Corresponding to the content of the Chinese abstract. Corresponding to the content of the Chinese abstract. Corresponding to the content of the Chinese abstract. Corresponding to the content of the Chinese abstract.",
  keywords: ("Maintain consistency with Chinese keywords", "Maintain consistency with Chinese keywords", "separated by semicolons"),
) = {
  show: show-cn-fakebold

  set page(header: header("英文摘要"))

  page_title("ABSTRACT", use_heading: true)
  
  text(weight: "bold")[ABSTRACT: ]
  text[#abstract]
  
  linebreak()
  linebreak()
  linebreak()

  let keywords = keywords.join("; ")

  text(weight: "bold")[KEYWORDS: ]
  text[#keywords]
  text[;]

  pagebreak()
}

