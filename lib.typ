#import "utils/styles.typ": show_doc, show_main
#import "pages/cover.typ": cover_page
#import "pages/copyright.typ": copyright_page
#import "pages/integrity.typ": integrity_page
#import "pages/abstract_zh.typ": abstract_page_zh
#import "pages/abstract_en.typ": abstract_page_en
#import "pages/outline.typ": outline_page
#import "pages/bib.typ": bib_page
#import "pages/aknowledgement.typ": aknowledgement_page

#import "tables.typ"

#let document(
  anonymous: false,
  info: (:),
) = {
  info = (
    (
      date: datetime.today(),
      title: "论文（设计）题目",
      title_en: "论文（设计）英文题目",
      school: "软件学院",
      major: "软件工程",
      author: "姓名",
      id: "114514",
      mentor: "指导教师",
    ) + info
  )

  (
    show_doc: (..args) => {
      show_doc(
        ..args,
        info: info + args.named().at("info", default: (:))
      )
    },
    show_main: (..args) => {
      show_main(
        ..args,
      )
    },
    cover_page: (..args) => {
      cover_page(
        ..args,
        anonymous: anonymous,
        info: info + args.named().at("info", default: (:))
      )
    },
    copyright_page: (..args) => {
      copyright_page(
        ..args,
        anonymous: anonymous,
      )
    },
    integrity_page: (..args) => {
      integrity_page(
        ..args,
        anonymous: anonymous,
      )
    },
    abstract_page_zh: (..args) => {
      abstract_page_zh(..args)
    },
    abstract_page_en: (..args) => {
      abstract_page_en(..args)
    },
    outline_page: (..args) => {
      outline_page(..args)
    },
    bib_page: (..args) => {
      bib_page(..args)
    },
    aknowledgement_page: (..args) => {
      aknowledgement_page(..args)
    }
  )
}