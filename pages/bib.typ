#import "../utils/components.typ": header, page_title

#let bib_page(
  bibfunc: none,
  full: false,
  style: "gb-7714-2015-numeric",
) = {
  pagebreak(weak: true, to: "odd")

  set page(header: header("参考文献"))

  page_title("参考文献")

  bibfunc(
    title: none,
    full: full,
    style: style,
  )
  pagebreak(weak: true, to: "odd")
}