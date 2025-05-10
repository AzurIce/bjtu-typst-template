#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title, header

#let appendix_page(anonymous: false, it) = {
  counter(heading).update(0)
  set page(header: header("附录"))

  page_title[附#h(2em)录]

  
  it

  // pagebreak(weak: true)
}

