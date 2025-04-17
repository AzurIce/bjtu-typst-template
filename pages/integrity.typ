// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title, header

#let integrity_page(anonymous: false) = {
  show: show-cn-fakebold

  set page(header: header("论文诚信声明"))

  page_title("学士论文诚信声明")
  
  text[
    #h(2em)本人声明所呈交的毕业论文（设计），题目
    #box(width: 14em)[#line(length: 100%)]
    是本人在指导教师的指导下，独立进行研究工作所取得的成果。尽我所知，除了文中特别加以标注和致谢中所罗列的内容以外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得北京交通大学或其他教育机构的学位或证书而使用过的材料。
    
    申请学位论文与资料若有不实之处，本人承担一切相关责任。

    #linebreak()
  ]

  columns(2)[
    #text[
      #h(2em)本人签名：
      #box(width: 9em)[#line(length: 100%)]
    ]
    #colbreak()
    #text[
      日期：
      #box(width: 9em)[#line(length: 100%)]
    ]
  ]

  pagebreak()
}

