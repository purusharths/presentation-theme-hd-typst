// Presentation settings: fonts, colors and sizes used by theme/university.typ and housekeeping.typ.
// Edit the values below; everything that references font-all / main-color / accent-color follows them.

// ---- base values ----
#let font-all = "Libertinus Serif"       // default font for everything
#let font-mono = "DejaVu Sans Mono"      // monospace font (footer, authors)
#let main-color = rgb(140, 5, 23)        // main theme color (Heidelberg Red): titles, progress bar, section slides
#let accent-color = rgb(150, 85, 92)     // softer red used inside the slide body (bold, boxes, tables, algorithms)

#let settings = (
  font: (
    body: font-all,
    header: font-all,                    // slide title
    subheader: "Noto Serif Khmer",       // grey " / Sub / SubSub" part of the title
    footer: font-mono,
    author: font-mono,                   // authors on the title slide
    algorithm: font-mono,                // text inside #algo boxes (math keeps the math font)
  ),

  color: (
    main: main-color,                    // progress bar, section and title slides, alerts
    secondary: rgb(245, 226, 213),
    header: main-color,                  // slide title
    subheader: rgb(190, 190, 190),       // " / Sub" titles and inactive sections
    body: black,
    bold: accent-color,                  // *bold* text and #alert[...]
    footer: rgb(100, 100, 100),          // footer text
    footer-bg: rgb(247, 235, 235),       // shaded footer bar
    author: rgb(13, 38, 89),             // authors on the title slide
    caption: rgb(80, 80, 80),            // figure captions and (a) (b) labels
    table-header: accent-color.lighten(78%), // header row background
    table-header-text: accent-color.darken(25%), // header row text
    table-stripe: rgb(249, 245, 245),    // every second body row
    algorithm: accent-color,             // frame and title of #algo boxes
  ),

  box: (
    theorem: accent-color,
    lemma: rgb(13, 38, 89),
    prop: rgb(23, 107, 135),
    note: rgb(110, 110, 110),
  ),

  size: (
    body: 25pt,
    header: 37.5pt,                      // slide title
    subheader: 25pt,
    footer: 10pt,
    section: 37.5pt,                     // title on section slides
    title: 50pt,                         // presentation title on the title slide
    caption: 16pt,                       // figure captions ("Figure 1: ...")
    sublabel: 14pt,                      // (a) (b) (c) labels under photos in #photo-grid
    table: 20pt,                         // text inside tables
    algorithm: 16pt,                     // text inside #algo boxes
  ),
)
