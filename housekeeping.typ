// Theorem-style boxes: #theorem, #lemma, #prop (shared numbering) and #note (unnumbered)
//
// Usage:
//   #theorem(title: "Pythagoras")[$a^2 + b^2 = c^2$] <thm-pyth>
//   #lemma[...]   #prop[...]   #note[...]
//   ... as shown in @thm-pyth

#import "theme/settings.typ": settings
#import "@preview/algorithmic:1.0.7"

// counter shared by theorem / lemma / prop; register it in
// config-common(frozen-counters: (theorem-counter,)) so #pause doesn't double count
#let theorem-counter = counter(figure.where(kind: "theorem"))

#let _box(name, color, number: none, title: none, body) = block(
  width: 100%,
  inset: (x: .8em, y: .6em),
  radius: (right: 4pt),
  fill: color.lighten(92%),
  stroke: (left: 3pt + color),
  {
    set align(left)
    text(fill: color, weight: "bold", {
      name
      if number != none [ #number]
      if title != none [ (#title)]
      [.]
    })
    h(.4em)
    body
  },
)

#let _numbered(name, color) = (title: none, body) => figure(
  kind: "theorem",
  supplement: name,
  outlined: false,
  _box(name, color, number: context theorem-counter.display(), title: title, body),
)

#let theorem = _numbered([Theorem], settings.box.theorem)
#let lemma = _numbered([Lemma], settings.box.lemma)
#let prop = _numbered([Proposition], settings.box.prop)

#let note(title: none, body) = _box([Note], settings.box.note, title: title, body)


// ---- slide layouts ----

// photo next to text
//   #image-text(image("figures/a.jpg"))[text]               photo on the left
//   #image-text(image("figures/a.jpg"), side: right)[text]  photo on the right
#let image-text(img, body, side: left, width: 45%, gutter: 1.2em) = {
  set image(width: 100%)
  let cells = if side == left { (img, body) } else { (body, img) }
  grid(
    columns: if side == left { (width, 1fr) } else { (1fr, width) },
    column-gutter: gutter,
    align: horizon,
    ..cells,
  )
}

// grid of photos labelled (a), (b), (c), ... with an optional caption
//   #photo-grid(columns: 2, caption: [...], image("a.jpg"), image("b.jpg"), ...)
// caption / label sizes: settings.size.caption, settings.size.sublabel
#let photo-grid(columns: 2, height: 4.2cm, gutter: .6em, labels: true, caption: none, ..images) = {
  let cells = images.pos().enumerate().map(((i, img)) => {
    set image(height: height)
    stack(
      dir: ttb,
      spacing: .3em,
      img,
      if labels {
        text(size: settings.size.sublabel, fill: settings.color.caption, [(#numbering("a", i + 1))])
      },
    )
  })
  let body = grid(columns: columns, gutter: gutter, align: center, ..cells)
  if caption == none { align(center, body) } else { figure(body, caption: caption) }
}

// numbered pseudocode box (uses the algorithmic package)
//   #algo(title: "Binary Search", {
//     import algorithmic: *
//     Assign[$l$][$1$]
//     ...
//   }) <alg-bs>
// register algorithm-counter in frozen-counters like theorem-counter
#let algorithm-counter = counter(figure.where(kind: "algorithm"))

#let algo(title: none, line-numbers: true, ..bits) = {
  let color = settings.color.algorithm
  figure(
    kind: "algorithm",
    supplement: [Algorithm],
    outlined: false,
    block(
      width: 100%,
      stroke: (top: 1.5pt + color, bottom: 1.5pt + color),
      inset: (x: .4em, y: .4em),
      {
        set align(left)
        set text(size: settings.size.algorithm, font: settings.font.algorithm)
        set par(leading: .45em)
        stack(
          dir: ttb,
          spacing: .4em,
          {
            text(fill: color, weight: "bold")[Algorithm #context algorithm-counter.display()]
            if title != none [: #title]
          },
          line(length: 100%, stroke: .6pt + color),
          algorithmic.algorithm(inset: .25em, horizontal-offset: 2.4em, line-numbers: line-numbers, vstroke: .5pt + luma(200), ..bits),
        )
      },
    ),
  )
}
