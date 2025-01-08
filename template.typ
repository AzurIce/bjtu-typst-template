// Package for writing pseudocode, see: https://typst.app/universe/package/lovelace/
#import "@preview/lovelace:0.3.0"
// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "utils/variables.typ": *
#import "utils/styles.typ": *
#import "pages/cover.typ": cover
#import "pages/copyright.typ": copyright
#import "pages/integrity.typ": integrity
#import "pages/abstract_zh.typ": abstract_zh

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
  set page(paper: "a4", margin: (
    top: 3cm,
    bottom: 2.5cm,
    left: 2.5cm,
    right: 2.5cm
  ))

  show: show_body
  show: show_heading

  cover(
    anonymous: anonymous,
    title_zh: title_zh,
    title_en: title_en,
    school: school,
    major: major,
    author: author,
    id: id,
    mentor: mentor
  )
  
  pagebreak()

  copyright(anoymous: anonymous)

  integrity(anoymous: anonymous)

  abstract_zh()

  doc
}