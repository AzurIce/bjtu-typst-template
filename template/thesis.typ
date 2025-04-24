#import "../lib.typ": document, tables

#let (
  show_doc,
  show_main,
  cover_page,
  copyright_page,
  integrity_page,
  abstract_page_zh,
  abstract_page_en,
  outline_page,
  bib_page,
  aknowledgement_page,
) = document(

)

#show: show_doc

#cover_page()

#copyright_page()

#integrity_page()

#set page(numbering: "i")
#counter(page).update(1)

#abstract_page_zh(keywords: ("3-5个", "关键词", "以分号分隔"))[
  中文摘要应将论文的内容要点简短明了地表达出来，约400字左右，字体为宋体小四号。内容应包括工作目的、研究方法、成果和结论。要突出本论文的创新点，语言力求精炼。为了便于文献检索，应在本页下方另起一行注明论文的关键词（3-5个），如有可能，尽量采用《汉语主题词表》等词表提供的规范词。图X幅，表X个，参考文献X篇。
]

#abstract_page_en(
  keywords: ("Maintain consistency with Chinese keywords", "Maintain consistency with Chinese keywords", "separated by semicolons"),
)[
  Corresponding to the content of the Chinese abstract. Corresponding to the content of the Chinese abstract. Corresponding to the content of the Chinese abstract. Corresponding to the content of the Chinese abstract.
]

#outline_page()

#show: show_main

= 引言【1级标题，三号黑体字】
#h(2em)引言（或绪论）简要说明研究工作的目的、范围、相关领域的前人工作和知识空白、理论基础和分析、研究设想、研究方法和实验设计、预期结果和意义等。应言简意赅，不要与摘要雷同，不要成为摘要的注释。一般教科书中有的知识，在引言中不必赘述。

#pagebreak()

= 【1级标题，三号黑体字】
#h(2em)学位论文为了需要反映出作者确已掌握了坚实的基础理论和系统的专门知识，具有开阔的科学视野，对研究方案作了充分论证，因此，有关历史回顾和前人工作的综合评述，以及理论分析等，可以单独成章，用足够的文字叙述。正文是学位论文的核心部分，占主要篇幅，可以包括：调查对象、实验和观测方法、仪器设备、材料原料、实验和观测结果、计算方法和编程原理、数据资料、经过加工整理的图表、形成的论点和导出的结论等。

由于研究工作涉及的学科、选题、研究方法、工作进程、结果表达方式等有很大的差异，对正文内容不能作统一的规定。但是，必须实事求是，客观真切，准确完备，合乎逻辑，层次分明，简练可读。

图：

图包括曲线图、构造图、示意图、框图、流程图、记录图、地图、照片等。

图应具有“自明性”。

图应有编号。图的编号由“图”和从“1”开始的阿拉伯数字组成，图较多时，可分章编号。

图宜有图题，图题即图的名称，置于图的编号之后。图的编号和图题应置于图下方。

照片图要求主题和主要显示部分的轮廓鲜明，便于制版。如用放大缩小的复制品，必须清晰，反差适中。照片上应有表示目的物尺寸的标度。

图片示例1：

#figure(
  image("../assets/bjtu-black-from-pdf.png"),
  kind: "image",
  caption: [北京交通大学]
)<bjtu>

#figure(
  image("../assets/bjtu-black-from-pdf.png"),
  kind: "image",
  caption: [还是北京交通大学]
)<bjbjtu>

如 @img:bjtu, @img:bjbjtu 所示，......。

#h(2em)表：

表应具有“自明性”。

表应有编号。表的编号由“表”和从“1”开始的阿拉伯数字组成，表较多时，可分章编号。

表宜有表题，表题即表的名称，置于表的编号之后。表的编号和表题应置于表上方。

表的编排，一般是内容和测试项目由左至右横读，数据依序竖读。

表的编排建议采用国际通行的三线表。

如某个表需要转页接排，在随后的各页上应重复表的编号。编号后跟表题（可省略）和“（续）”，置于表上方。

续表均应重复表头。

表格示例1：

#figure(
  table(
    columns: 3,
    table.header(
      [量的名称], [单位名称], [单位符号]
    ),
    [长度], [米], [m],
    [质量], [千克(公斤)], [kg],
    [时间], [秒], [s],
    [电流], [安[培]], [A],
    [热力学温度], [开[尔文]], [K],
    [物质的量], [摩[尔]], [mol],
    [发光强度], [坎[德拉]], [cd]
  ),
  caption: "国际单位制的基本单位",
)<units>

#figure(
  tables.tri_table(
    columns: 3,
    table.header(
      [量的名称], [单位名称], [单位符号]
    ),
    [长度], [米], [m],
    [质量], [千克(公斤)], [kg],
    [时间], [秒], [s],
    [电流], [安[培]], [A],
    [热力学温度], [开[尔文]], [K],
    [物质的量], [摩[尔]], [mol],
    [发光强度], [坎[德拉]], [cd]
  ),
  caption: "国际单位制的基本单位三线表",
)<units-tri>

#figure(
  tables.use_case_table(
    columns: 4,
    table.header(
      [*用例编号*], [UC1], [*用例名称*], [动画渲染],
    ),
    fill: (x, y) => if y == 0 {
      blue.lighten(70%)
    },
    stroke: (x, y) => {
      (
        top: 0.7pt + black,
        left: if (x != 0) {
          0.7pt + black
        }
      )
    },
    [*活动者*], [引擎用户], [*优先级*], [高],
    [*描述*], table.cell(colspan:3)[用户通过引擎提供的 API 接口调用渲染模块，请求渲染动画],
    [*前置条件*], table.cell(colspan:3)[无],
    [*后置条件*], table.cell(colspan:3)[引擎成功渲染出动画],
    [*主事件流*], table.cell(colspan:3)[
      #set align(left)
      1. 引擎用户调用引擎提供的接口渲染动画时间线；
      2. 引擎对时间线进行求值，通过实例资源池准备渲染实例；
      3. 引擎将渲染实例编码为 GPU 指令并提交；
      4. 引擎得到渲染结果；
      5. 将渲染结果编码入输出视频文件
      6. 重复 2-5 步直至完成整个动画时间线渲染。
    ],
    [*备选事件流*], table.cell(colspan:3)[无],
    [*异常事件流*], table.cell(colspan:3)[无],
    [*其他说明*], table.cell(colspan:3)[无],
  ),
  caption: "渲染动画用例说明",
)<use-case>

如表 @tbl:units @tbl:units-tri @tbl:use-case 所示，......。

#h(2em)公式：

论文中的公式应另行起，并缩格书写，与周围文字留足够的空间区分开。

如有两个以上的公式，应用从“1”开始的阿拉伯数字进行编号，并将编号置于括号内。公式的编号右端对齐，公式与编号之间可用“…”连接。公式较多时，可分章编号。

公式示例1：

$ phi.alt = D^2_p / 150 psi^3 / (1-psi)^2 $<eq-a>

$ C_2 = 3.5 / D_p ((1-psi)) / psi^3 $<eq-b>

#h(2em) 引用两个公式，@eqt:eq-a @eqt:eq-b，......。

式中 $D_p$ —— 多孔质材料的平均粒子直径($m$)；

$psi$ —— 孔隙度（孔隙体积占总体积的百分比）；

$phi.alt$ —— 特征渗透性或固有渗透性，与材料的结构性质有关($m^2$)。

较长的公式需要转行时，应尽可能在“$＝$”处回行，或者在“$+$”、“$-$”、“$times$”、“$\/$”等记号处回行。

公式中分数线的横线，其长度应等于或略大于分子和分母中较长的一方。

如正文中书写分数，应尽量将其高度降低为一行。如将分数线书写为“$\/$”，将根号改为负指数。

公式示例 2：

将 $1/sqrt(2)$ 写成 $1 \/ sqrt(2)$ 或 $2^(-1 \/ 2)$

引文标注

论文中引用的文献的标注方法遵照GB/T 7714－2005，可采用顺序编码制，也可采用著者－出版年制，但全文必须统一。

注释

当论文中的字、词或短语，需要进一步加以说明，而又没有具体的文献来源时，用注释。注释一般在社会科学中用得较多。

应控制论文中的注释数量，不宜过多。

由于论文篇幅较长，建议采用文中编号加“脚注”的方式。最好不用采用文中编号加“尾注”。

== 【2级标题，小三号黑体字】
#h(2em)阿巴阿巴阿巴

=== 【3级标题，四号黑体字】
#h(2em)阿巴阿巴阿巴

#pagebreak(weak: true)

= 【1级标题，三号黑体字】
#h(2em)阿巴阿巴阿巴

== 【2级标题，小三号黑体字】
#h(2em)阿巴阿巴阿巴

=== 【3级标题，四号黑体字】
#h(2em)阿巴阿巴阿巴

#pagebreak(weak: true)

= 【1级标题，三号黑体字】
#h(2em)阿巴阿巴阿巴

== 【2级标题，小三号黑体字】
#h(2em)阿巴阿巴阿巴

=== 【3级标题，四号黑体字】
#h(2em)阿巴阿巴阿巴

#pagebreak(weak: true)

= 结论【1级标题，三号黑体字】
#h(2em)论文的结论是最终的、总体的结论，不是正文中各段的小结的简单重复。结论应该准确、完整、明确、精练。如果不可能导出应有的结论，也可以没有结论而进行必要的讨论。可以在结论或讨论中提出建议、研究设想、仪器设备改进意见以及尚待解决的问题等。

引用文献 @sanderson_3b1bmanim_2025，引用文献一堆
@park_shader-based_2021 @sanderson_3b1bmanim_2025 @gustavson_anti-aliased_2011 @li_efficient_2016，没了。

#pagebreak(weak: true)

#bib_page(bibfunc: bibliography.with("bibliography.bib"))

#aknowledgement_page[
  #h(2em)放置在参考文献页后，对象包括：1）国家科学基金，资助研究工作的奖学金基金，合同单位，资助或支持的企业、组织或个人。2）协助完成研究工作和提供便利条件的组织或个人。3）在研究工作中提出建议和提供帮助的人。4）给予转载和引用权的资料、图片、文献、研究思想和设想的所有者。5）其他应感谢的组织和个人。
]