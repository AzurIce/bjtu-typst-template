// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "../utils/variables.typ": *

#let cover(
  anonymous: false,
  title_zh: "论文（设计）题目",
  title_en: "论文（设计）英文题目",
  school: "软件学院",
  major: "软件工程",
  author: "姓名",
  id: "2147483647",
  mentor: "指导教师",
  year: "2025",
  month: "4",
) = {
  show: show-cn-fakebold
  // show text.where(weight: "bold").or(strong): it => {
  //   show regex("\p{script=Han}"): set text(stroke: 0.02857em)
  //   it
  // }

  align(center)[
    // bjtu logo
    #v(10.5pt)
    #v(10.5pt)

    #v(18pt) // 这个数值用于与 word 模板里的 logo对齐...

    #let logo_path = if not anonymous {
      "../assets/bjtu-black-from-pdf.png"
    } else {
      "../assets/bjtu-anonymous.png"
    }
    #image(logo_path, alt: "BJTU Logo", width: 10.71cm, height: 2.76cm, fit: "stretch")

    #v(18pt)
    #v(14pt)

    #text(
      size: 字号.二号,
      font: 字体.宋体,
      weight: "bold"
    )[本科毕业论文（设计）]

    #v(1fr)

    #text(
      size: 字号.小二,
      font: 字体.黑体,
      weight: "bold"
    )[#title_zh]

    #v(18pt)
    #v(10pt) // 用于与 word 模板对齐...

    #text(
      size: 字号.小二,
      font: 字体.宋体,
      weight: "bold"
    )[#title_en]

    #v(1fr)

    #let info_value(body) = {
      rect(
        width: 100%,
        inset: 2pt,
        stroke: (
          bottom: 1pt + black
        ),
        text(
          font: 字体.宋体,
          size: 字号.三号,
          bottom-edge: "descender"
        )[
          #body
        ]
      ) 
    }
    
    #let info_key(body) = {
      rect(width: 100%, inset: 2pt, 
       stroke: none,
       text(
        font: 字体.宋体,
        size: 字号.三号,
        [ #body： ]
      ))
    }


    #grid(
      columns: (80pt, 180pt),
      rows: (28pt, 28pt),
      gutter: 3pt,
      info_key("学　　院"),
      info_value(if not anonymous { school } else { "██████████" }),
      info_key("专　　业"),
      info_value(if not anonymous { major } else { "██████████" }),
      info_key("学生姓名"),
      info_value(if not anonymous { author } else { "██████████" }),
      info_key("学　　号"),
      info_value(if not anonymous { id } else { "██████████" }),
      info_key("指导教师"),
      info_value(if not anonymous { mentor } else { "██████████" }),
    )

    #v(10.5pt)
    // #v(10.5pt)
    #v(18pt) // 用于与 word 模板对齐...

    #text(
      size: 字号.小三,
      font: 字体.宋体,
      weight: "bold"
    )[北京交通大学]

    #v(12pt) // 用于与 word 模板对齐...

    #text(
      size: 字号.四号,
      font: 字体.宋体,
    )[#year 年 #month 月]

    #v(1fr)
  ]
  pagebreak()
}