// Package for writing pseudocode, see: https://typst.app/universe/package/lovelace/
#import "@preview/lovelace:0.3.0"
// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold
#show: show-cn-fakebold

#let heiti = ("Times New Roman", "SimHei")
#let songti = ("Times New Roman", "SimSun")
#let zhongsong = ("Times New Roman", "SimSun")

#let project(
  anonymous: false,
  title_zh: "论文（设计）题目",
  title_en: "English Title",
  school: "软件学院",
  major: "软件工程",
  author: "姓名",
  id: "2147483647",
  mentor: "指导教师",
  doc
) = {
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

    #v(17pt) // 这个数值用于与 word 模板里的 logo对齐...

    #let logo_path = if not anonymous {
      "assets/bjtu-black.png"
    } else {
      "assets/bjtu-anonymous.png"
    }
    #image(logo_path)

    #v(18pt)

    #text(
      size: 22pt,
      font: zhongsong,
      weight: "bold"
    )[本科毕业论文（设计）]

    #v(22pt)
    #v(22pt)

    #text(
      size: 18pt,
      font: heiti,
    )[#title_zh]

    #v(18pt)

    #text(
      size: 18pt,
      font: heiti,
    )[#title_en]

    #v(18pt)
    #v(18pt)

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
      rows: (30pt, 30pt),
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
    #v(10.5pt)

    #text(
      size: 15pt,
      font: heiti,
    )[北京交通大学]

    #text(
      size: 14pt,
      font: heiti,
    )[2024 年 11 月]
  ]

  doc
}