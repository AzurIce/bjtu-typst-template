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
#import "pages/abstract_en.typ": abstract_en
#import "pages/table_of_contents.typ": table_of_contents
#import "utils/components.typ": header

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
  year: "2025",
  month: "4",
  abstract_zh_str: "中文摘要应将论文的内容要点简短明了地表达出来，约400字左右，字体为宋体小四号。内容应包括工作目的、研究方法、成果和结论。要突出本论文的创新点，语言力求精炼。为了便于文献检索，应在本页下方另起一行注明论文的关键词（3-5个），如有可能，尽量采用《汉语主题词表》等词表提供的规范词。图X幅，表X个，参考文献X篇。",
  keywords_zh_arr: ("3-5个", "关键词", "以分号分隔"),
  abstract_en_str: "Corresponding to the content of the Chinese abstract. Corresponding to the content of the Chinese abstract. Corresponding to the content of the Chinese abstract. Corresponding to the content of the Chinese abstract.",
  keywords_en_arr: ("Maintain consistency with Chinese keywords", "Maintain consistency with Chinese keywords", "separated by semicolons"),
  doc
) = {
  set page(paper: "a4", margin: (
    top: 3cm,
    bottom: 2.5cm,
    left: 2.5cm,
    right: 2.5cm
  ))

  show: show_body

  // 封面
  cover(
    anonymous: anonymous,
    title_zh: title_zh,
    title_en: title_en,
    school: school,
    major: major,
    author: author,
    id: id,
    mentor: mentor,
    year: year,
    month: month
  )
  
  // 双面打印封面空白
  pagebreak()

  // 版权声明
  copyright(anoymous: anonymous)

  // 诚信声明
  integrity(anoymous: anonymous)

  set page(numbering: "i")
  counter(page).update(1)
  // 摘要
  abstract_zh(abstract: abstract_zh_str, keywords: keywords_zh_arr)
  abstract_en(abstract: abstract_en_str, keywords: keywords_en_arr)

  // 目录
  table_of_contents()

  set page(header: header("正文"))
  show: show_heading
  show: show_figure
  show: show_table
  show: show_math
  set page(numbering: "1")
  counter(page).update(1)

  doc
}