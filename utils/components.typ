// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "variables.typ": *

#let anonymous_header(title) = {
  set text(font: 字体.中宋, size: 字号.四号)
  h(1fr)
  [#title#h(1em)]
  place(dy: 2.5pt)[#line(stroke: 2.5pt, length: 100%)]
  place(dy: 5pt)[#line(stroke: 1pt, length: 100%)]
}

#let header(title, anonymous: false) = {
  set text(font: 字体.中宋, size: 字号.四号)
  let school = if anonymous {
    "██████████"
  } else {
    "北京交通大学"
  }

  [#h(1em)#text(school)毕业设计（论文）]
  h(1fr)
  [#title#h(1em)]
  place(dy: 2.5pt)[#line(stroke: 2.5pt, length: 100%)]
  place(dy: 5pt)[#line(stroke: 1pt, length: 100%)]
}

// 用于 “学士论文版权使用授权书”、“学士论文诚信声明”等页标题
#let page_title(content, use_heading: false) = {
  show: show-cn-fakebold
  set text(size: 字号.小二, font: 字体.黑体)

  if use_heading {
    show heading: it => {
      set align(center)
      set text(size: 字号.小二, font: 字体.黑体, weight: "regular")
      align(center)[
        #block(inset: 24pt)[
          #it
        ]
      ]
    }
    heading(level: 1)[#content]
  } else {
    align(center)[
      #block(inset: (y: 24pt))[
        #content
      ]
    ]
  }
}
