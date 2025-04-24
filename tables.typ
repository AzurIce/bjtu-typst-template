
#let tri_table= table.with(stroke: (x, y) => if y == 0 {
  (bottom: 0.7pt + black)
})

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