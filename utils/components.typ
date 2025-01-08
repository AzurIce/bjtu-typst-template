// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "variables.typ": *

// 用于 “学士论文版权使用授权书”、“学士论文诚信声明”等页标题
#let page_title(content) = {
  show: show-cn-fakebold
  set text(size: 字号.小二, font: 字体.黑体)

  align(center)[
    #block(inset: 24pt)[
      #content
    ]
  ]
}