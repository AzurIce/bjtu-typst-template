// Package for showing Chinese fake bold, see: https://typst.app/universe/package/cuti/
#import "@preview/cuti:0.3.0": show-cn-fakebold

#import "../utils/variables.typ": *
#import "../utils/components.typ": page_title

#let abstract_zh() = {
  show: show-cn-fakebold

  set page(
    header: {
      set text(font: 字体.中宋, size: 字号.四号)
      [#h(1em)北京交通大学毕业论文（设计）]
      h(1fr)
      [中文摘要#h(1em)]
      place(dy: 5pt)[#line(stroke: 2pt, length: 100%)]
      place(dy: 8pt)[#line(stroke: 1pt, length: 100%)]
    }
  )

  page_title("中文摘要")
  
  text(weight: "bold")[摘要：]
  text[中文摘要应将论文的内容要点简短明了地表达出来，约400字左右，字体为宋体小四号。内容应包括工作目的、研究方法、成果和结论。要突出本论文的创新点，语言力求精炼。为了便于文献检索，应在本页下方另起一行注明论文的关键词（3-5个），如有可能，尽量采用《汉语主题词表》等词表提供的规范词。图X幅，表X个，参考文献X篇。]
  
  linebreak()
  linebreak()
  linebreak()

  text(weight: "bold")[关键词：]
  text[3-5个关键词，以分号分隔。]

  pagebreak()
}

