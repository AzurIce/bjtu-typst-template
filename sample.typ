#import "template.typ": *
// #import "cuti.typ": show-cn-fakebold

#show: project.with()

???


#text(font: songti, size: 16pt, [你好])
#text(font: songti, size: 16pt, weight: "bold", [你好])
*你好* 你好

// #show: show-cn-fakebold.with(reg-exp: "\p{script=Han}")
// - Regular: 我正在使用 Typst 排版。
// - Strong: *我正在使用 Typst 排版。*

#text(font: songti, size: 16pt, weight: "bold", [你好])
#text(font: songti, size: 16pt, stroke: 10pt, [你好])
