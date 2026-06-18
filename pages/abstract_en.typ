#import "../utils/variables.typ": *
#import "../utils/components.typ": anonymous_header, header, page_title

#let abstract_page_en(
  keywords: (),
  body,
  anonymous: false,
) = {
  set page(header: header("英文摘要", anonymous: anonymous))

  page_title("ABSTRACT", use_heading: true)

  set par(first-line-indent: 0em)
  text(weight: "bold")[ABSTRACT:]
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
