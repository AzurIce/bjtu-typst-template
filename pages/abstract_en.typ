#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title, header

#let abstract_page_en(
  keywords: (),
  body,
) = {
  set page(header: header("英文摘要"))

  page_title("ABSTRACT", use_heading: true)
  
  text(weight: "bold")[ABSTRACT: ]
  text[#body]
  
  linebreak()
  linebreak()
  linebreak()

  let keywords = keywords.join("; ")

  text(weight: "bold")[KEYWORDS: ]
  text[#keywords]
  text[;]

  pagebreak(weak: true)
}

