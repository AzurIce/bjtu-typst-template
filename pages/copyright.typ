// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title

#let copyright(anoymous: false) = {
  show: show-cn-fakebold

  set page(
    header: {
      set text(font: 字体.中宋, size: 字号.四号)
      [#h(1em)北京交通大学毕业论文（设计）]
      h(1fr)
      [版权使用授权书#h(1em)]
      place(dy: 5pt)[#line(stroke: 2pt, length: 100%)]
      place(dy: 8pt)[#line(stroke: 1pt, length: 100%)]
    }
  )

  page_title("学士论文版权使用授权书")
  
  text[
    #set par(justify: false, leading: 1.24em, first-line-indent: 2em)
    #h(2em)本学士论文作者完全了解北京交通大学有关保留、使用学士论文的规定。特授权北京交通大学可以将学士论文的全部或部分内容编入有关数据库进行检索，提供阅览服务，并采用影印、缩印或扫描等复制手段保存、汇编以供查阅和借阅。
  ]
  
  linebreak()

  align(center)[（保密的学位论文在解密后适用本授权说明）]

  linebreak()
  linebreak()
  linebreak()
  linebreak()
  linebreak()

  
  columns(2)[
    #text[
      #h(2em)学位论文作者签名：
    ]
    #colbreak()
    #text[
      指导教师签名：
    ]
  ]

  linebreak()

  columns(2)[
    #text[
      #h(2em)签字日期：#h(2.5em)年#h(1.5em)月#h(1.5em)日
    ]
    #colbreak()
    #text[
      签字日期：#h(2.5em)年#h(1.5em)月#h(1.5em)日
    ]
  ]

  pagebreak()
}

