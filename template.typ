// Package for writing pseudocode, see: https://typst.app/universe/package/lovelace/
#import "@preview/lovelace:0.3.0"
// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

// #show: show-cn-fakebold
#let heiti = ("Times New Roman", "SimHei")
#let songti = ("Times New Roman", "SimSun")
#let zhongsong = ("Times New Roman", "SimSun")

#let project(
  anonymous: false,
  title_zh: "论文（设计）题目",
  title_en: "论文（设计）英文题目",
  school: "软件学院",
  major: "软件工程",
  author: "姓名",
  id: "2147483647",
  mentor: "指导教师",
  doc
) = {
  show: show-cn-fakebold
  // show text.where(weight: "bold").or(strong): it => {
  //   show regex("\p{script=Han}"): set text(stroke: 0.02857em)
  //   it
  // }
  set page(paper: "a4", margin: (
    top: 3cm,
    bottom: 2.5cm,
    left: 2.5cm,
    right: 2.5cm
  ))

  align(center)[
    // bjtu logo
    #v(10.5pt)
    #v(10.5pt)

    #v(18pt) // 这个数值用于与 word 模板里的 logo对齐...

    #let logo_path = if not anonymous {
      "assets/bjtu-black-from-pdf.png"
    } else {
      "assets/bjtu-anonymous.png"
    }
    #image(logo_path, alt: "BJTU Logo", width: 10.71cm, height: 2.76cm, fit: "stretch")

    // #v(18pt)
    #v(14pt)

    #text(
      size: 21.96pt,
      font: songti,
      weight: "bold"
    )[本科毕业论文（设计）]

    #v(22pt)
    #v(22pt)

    #v(9pt) // 用于与 word 模板对齐...

    #text(
      size: 18pt,
      font: heiti,
      weight: "bold"
    )[#title_zh]

    #v(18pt)
    #v(10pt) // 用于与 word 模板对齐...

    #text(
      size: 18pt,
      font: songti,
      weight: "bold"
    )[#title_en]

    #v(18pt)
    #v(18pt)
    #v(22pt) // 用于与 word 模板对齐...

    #let info_value(body) = {
      rect(
        width: 100%,
        inset: 2pt,
        stroke: (
          bottom: 1pt + black
        ),
        text(
          font: zhongsong,
          size: 16pt,
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
        font: zhongsong,
        size: 16pt,
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
    #v(8pt) // 用于与 word 模板对齐...

    #text(
      size: 15pt,
      font: songti,
      weight: "bold"
    )[北京交通大学]

    #v(3pt) // 用于与 word 模板对齐...

    #text(
      size: 14pt,
      font: songti,
    )[2024 年 11 月]
  ]
  pagebreak()

  doc
}