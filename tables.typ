
#let toprule = table.hline(stroke: 0.08em)
#let bottomrule = toprule
#let midrule = table.hline(stroke: 0.05em)
#let tri_table(..args) = {
  let named = args.named()
  let header = args.pos().first()
  let contents = args.pos().slice(1)
  show table: set par(spacing: 0.5em)
  table(
    stroke: none,
    ..named,
    toprule,
    header,
    midrule,
    ..contents,
    bottomrule
  )
}

#let use_case_table= table.with(
  align: (center, left, center, left),
  fill: (x, y) => if y == 0 {
    blue.lighten(70%)
  },
  stroke: (x, y) => {
    (
      top: 0.7pt + black,
      left: if (x!= 0) {
        0.7pt + black
      }
    )
  },
)