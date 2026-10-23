#import "@preview/touying:0.6.1": *
#import "theme/university.typ": *
#import "housekeeping.typ": *
// #import themes.university: *

#import "@preview/numbly:0.1.0": numbly


#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Presentation],
    short-title: [TAC '25],
    subtitle: [2025],
    author: [Purusharth Saxena],
    author-short: [Saxena, Purusharth],
    department:[#smallcaps[Interdisciplinary Center for Scientific Computing]],
    institution: [#smallcaps[Universität Heidelberg]],
    small_institute: [Uni-HD],

    // date: datetime.today(),
    footer: self => self.info.institution,
    navigation: none,
  ),
  // fonts, colors and sizes: see theme/settings.typ
  config-page(
           header-ascent: 10mm,   // <— adds a top band
           margin: (x:2.0em, y: 5pt),
  ),
  config-common(frozen-counters: (theorem-counter, algorithm-counter)),
  
)

// #set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()
// #title-slide(authors: ([Jakob Zech], [Britta Velten], [Anna Marchiniak Chorzera]))

= The Section

#slide(title: "Introduction")[
  // #v(0.5em)
  // #line(length: 100%)
  // #v(2em)

#lorem(40)
$integral integral$
]


#subslide(title: "Image Example")[
#grid(
  columns: (1fr, 1fr),
  rows: (auto),
  gutter: 1em,
  image("figures/image2.jpg"),
  image("figures/image1.svg"),

)

]






// #focus-slide[
//   Another variant with primary color in background...
// ]

// #matrix-slide(columns:3, title:"efef")[left][middle][right]

// #matrix-slide(columns: 1)[
//   top][
//   bottom
// ]



= Slide Layouts

#slide(title: "Photo and Text")[
  #image-text(image("figures/image2.jpg"))[
    *Photo on the left*, text on the right.

    - point one
    - point two
  ]
]

#subslide(title: "Text and Photo")[
  #image-text(image("figures/image1.svg"), side: right, width: 40%)[
    Same helper with `side: right` and a narrower photo (`width: 40%`).
  ]
]

#slide(title: "Photo Grid")[
  #photo-grid(
    columns: 2,
    height: 4.4cm,
    caption: [Four photos with (a)–(d) labels. Caption size: `settings.size.caption`.],
    image("figures/image2.jpg"),
    image("figures/image1.svg"),
    image("figures/image1.svg"),
    image("figures/image2.jpg"),
  )
]

#subslide(title: "Row")[
  #photo-grid(
    columns: 4,
    height: 3.9cm,
    caption: [The same four photos in one row (`columns: 4`).],
    image("figures/image2.jpg"),
    image("figures/image1.svg"),
    image("figures/image2.jpg"),
    image("figures/image1.svg"),
  )
]

#slide(title: "Two Columns")[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.5em,
    [*Left column.* #lorem(18)],
    [*Right column.* #lorem(18)],
  )
]

#slide(title: "Table")[
  #align(center, table(
    columns: 4,
    align: (left, center, center, center),
    [Method], [Error], [Time (s)], [Memory],
    [Baseline], [$1.2 times 10^(-2)$], [12.4], [1.1 GB],
    [Ours], [*$3.4 times 10^(-4)$*], [*3.1*], [0.8 GB],
    [Reference], [$5.0 times 10^(-4)$], [25.7], [2.3 GB],
    [Other], [$8.9 times 10^(-3)$], [9.8], [1.6 GB],
  ))
]

#subslide(title: "With Caption and Text")[
  #image-text(width: 55%,
    figure(
      table(
        columns: 3,
        [$n$], [$h$], [Rate],
        [16], [$1 slash 16$], [--],
        [32], [$1 slash 32$], [1.98],
        [64], [$1 slash 64$], [2.01],
      ),
      caption: [Convergence study.],
    ),
  )[
    Tables work inside the other layouts too.

    Style: `color.table-*` and `size.table` in `theme/settings.typ`.
  ]
]

#slide(title: "Algorithm")[
  #algo(title: "Binary Search", {
    import algorithmic: *
    Procedure("Binary-Search", ("A", "n", "v"), {
      Assign[$l$][$1$]
      Assign[$r$][$n$]
      While($l <= r$, {
        Assign([mid], FnInline[floor][$(l + r) / 2$])
        IfElseChain(
          $A["mid"] < v$, { Assign[$l$][$"mid" + 1$] },
          [$A["mid"] > v$], { Assign[$r$][$"mid" - 1$] },
          Return[mid],
        )
      })
      Return[*null*]
    })
  }) <alg-bs>
]

#subslide(title: "With Text")[
  #image-text(width: 58%,
    algo(title: "Newton's Method", {
      import algorithmic: *
      Assign[$x_0$][initial guess]
      For($k = 0, 1, dots$, {
        Assign[$x_(k+1)$][$x_k - f(x_k) slash f'(x_k)$]
        If($|x_(k+1) - x_k| < epsilon$, { Return[$x_(k+1)$] })
      })
    }),
  )[
    Algorithms are numbered like figures: this is the second one after @alg-bs.
  ]
]

#slide(title: "Single Figure")[
  #figure(
    image("figures/image2.jpg", height: 65%),
    caption: [A single figure with a numbered caption.],
  )
]

#show: appendix

= Appendix
// #matrix-slide(columns: (1fr, 2fr, 1fr), ..(lorem(8),) * 9)
