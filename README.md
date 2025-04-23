# BJTU-typst-template

> [!CAUTION]
>
> 本模板仍未经过实践检验（正在进行检验），使用时请自行承担相关后果。

本模板计划在经过检验后（待本人使用此模板毕业后），发布于 typst universe。

目前的使用方式就是 Clone 下来本仓库，然后修改 `template/` 中的内容。

## 规范

参考 [附件1-北京交通大学本科毕业设计（论文）规范与质量抽检办法](./files/附件1-北京交通大学本科毕业设计（论文）规范与质量抽检办法) 中的 *第八章 毕业设计（论文）格式规范*。

## 已知问题和注意事项

- [ ] 一些场景下段首缩进失效（是 typst 的 bug），需手动 `#h(2em)`
- [ ] 中英文摘要 `#abstract_page_zh(...)[` 后第一段不要换行，直接写在 `[` 后面，否则在 `摘要：` 后面会多一个空格
- [ ] 为确保 `#figure` 中图片编号正确，要记得使用 `kind: "image"`

## 参考及致谢

- https://github.com/werifu/HUST-typst-template
- https://github.com/pku-typst/pkuthss-typst
- https://github.com/tzhTaylor/modern-sjtu-thesis
- https://github.com/nju-lug/modern-nju-thesis
