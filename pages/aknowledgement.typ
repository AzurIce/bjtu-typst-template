#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title, header

#let aknowledgement_page(anonymous: false, it) = {
  set page(header: header("致谢", anonymous: anonymous))

  set heading(numbering: none)
  page_title(use_heading: true)[致#h(2em)谢]
  
  it

  pagebreak(weak: true, to: "odd")
}

