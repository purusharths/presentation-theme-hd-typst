#import "@preview/touying:0.6.1": *
#import "theme/university.typ": *
// #import themes.university: *

#import "@preview/numbly:0.1.0": numbly


#show: university-theme.with(
  aspect-ratio: "16-9",
  primary: rgb(140, 5, 23), // Heidelberg Red
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
  config-colors(
    primary: rgb(140, 5, 23),
    secondary: rgb(245,226,213),
    tertiary: rgb(255,255,255),
    neutral-lightest: rgb(247, 235, 235),
    neutral-darkest: rgb(13, 38, 89),
  ),
  config-page(
           header-ascent: 10mm,   // <— adds a top band
           margin: (x:2.0em, y: 5pt),
  ),
  
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

#slide(title: "Tables")[
  #lorem(10)
]

#subslide(title: "Multicol Tables")[
]




// #focus-slide[
//   Another variant with primary color in background...
// ]

#slide(title: "Title")[wf]

// #matrix-slide(columns:3, title:"efef")[left][middle][right]

// #matrix-slide(columns: 1)[
//   top][
//   bottom
// ]



#show: appendix

= Appendix
// #matrix-slide(columns: (1fr, 2fr, 1fr), ..(lorem(8),) * 9)
