// University theme Originally contributed by Pol Dellaiera - https://github.com/drupol

#import "@preview/touying:0.6.1": *


// titles of the current slide / subslide / subsubslide, used to build the header trail
#let slide-titles = state("university-slide-titles", ())

#let subheading-text(it) = text(
  font: "Noto Serif Khmer",
  size: 25pt,
  fill: rgb(190, 190, 190),
  [ \/ #it],
)

#let slide(
  title: auto,
  level: 1, // 1 = slide, 2 = subslide, 3 = subsubslide
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  align: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  // explicit title overrides the heading-based header: "Slide / Sub / SubSub"
  if title != auto {
    self.store.header = text(baseline: 10pt, context {
      let parents = slide-titles.get()
      let trail = parents.slice(0, calc.min(level - 1, parents.len())) + (title,)
      trail.first()
      for t in trail.slice(1) { subheading-text(t) }
    })
  }
  let header(self) = {
    set std.align(top)
    grid(
      rows: (auto, auto),
      row-gutter: 3mm,
      if self.store.progress-bar {
        components.progress-bar(height: 2pt, self.colors.primary, self.colors.tertiary)
      },
      block(
        inset: (x: 1.0em),
        components.left-and-right(
          text(fill: self.colors.primary, weight: "bold", size: 1.5em, utils.call-or-display(self, self.store.header)),
          text(fill: self.colors.primary.lighten(65%), utils.call-or-display(self, self.store.header-right)),
        ),
      ),
    )
  }
  let footer(self) = {
    set std.align(center + bottom)
    set text(size: .4em)
    {
      let cell(..args, it) = components.cell(
        ..args,
        inset: 1mm,
        std.align(horizon, text(fill: white, it)),
      )
      show: block.with(width: 100%, height: auto)
      grid(
        columns: self.store.footer-columns,
        rows: 1.5em,
        // cell(fill: self.colors.primary, utils.call-or-display(self, self.store.footer-a)),
        // cell(fill: self.colors.secondary, utils.call-or-display(self, self.store.footer-b)),
        // cell(fill: self.colors.tertiary, utils.call-or-display(self, self.store.footer-c)),

        cell(utils.call-or-display(self, self.store.footer-a)),
        cell(utils.call-or-display(self, self.store.footer-b)),
        cell(utils.call-or-display(self, self.store.footer-c)),
      )
    }
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  let new-setting = body => {
    if title != auto {
      slide-titles.update(t => t.slice(0, calc.min(level - 1, t.len())) + (title,))
    }
    show: std.align.with(self.store.align)
    show: setting
    body
  }
  touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
})

// slide under the last #slide(title: ..): header shows "Slide / title"
#let subslide(title: none, ..args) = slide(title: title, level: 2, ..args)

// slide under the last #subslide(title: ..): header shows "Slide / Sub / title"
#let subsubslide(title: none, ..args) = slide(title: title, level: 3, ..args)


#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
  )
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  let body = {
    if info.logo != none {
      place(right, text(fill: self.colors.primary, info.logo))
    }
    std.align(
      center + horizon,
      {
        block(
          inset: 0em,
          breakable: false,
          {
            text(size: 2em, fill: self.colors.primary, strong(info.title))
            if info.subtitle != none {
              parbreak()
              text(size: 1.2em, fill: self.colors.primary, info.subtitle)
            }
          },
        )
        set text(size: .8em)
        grid(
          columns: (1fr,) * calc.min(info.authors.len(), 3),
          column-gutter: 1em,
          row-gutter: 1em,
          ..info.authors.map(author => text(fill: self.colors.neutral-darkest,
                                            size: 0.82em,
                                            font: "Cascadia Code",
                                            author))
        )
        v(1em)
        if info.department != none {
          parbreak()
          text(
            size: .8em,
            // font: "Cascadia Code",
            info.department
          )
        }
        if info.institution != none {
          parbreak()
          text(
            size: .8em, 
            // font: "Cascadia Code",
            info.institution)
        }
        if info.date != none {
          parbreak()
          text(size: .8em, utils.display-info-date(self))
        }
      },
    )
  }
  touying-slide(self: self, body)
})


#let new-section-slide(config: (:), level: 1, numbered: true, body) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(left: 10%, right: 3%)
    // list of all sections on the right, current one highlighted, others in grey
    let section-list = context {
      let current = utils.current-heading(level: level)
      set text(size: .7em, weight: "regular")
      set par(leading: .5em)
      stack(
        dir: ttb,
        spacing: .8em,
        ..query(heading.where(level: level)).map(h => {
          if current != none and h.location() == current.location() {
            text(fill: self.colors.primary, weight: "bold", h.body)
          } else {
            text(fill: rgb(190, 190, 190), h.body)
          }
        }),
      )
    }
    grid(
      columns: (1fr, auto, auto),
      column-gutter: 3em,
      align: (left + horizon, center + horizon, left + horizon),
      {
        set text(size: 1.5em, fill: self.colors.primary, weight: "bold")
        stack(
          dir: ttb,
          spacing: .65em,
          utils.display-current-heading(level: level, numbered: numbered),
          block(
            height: 2pt,
            width: 100%,
            spacing: 0pt,
            components.progress-bar(height: 2pt, self.colors.primary, self.colors.primary-light),
          ),
        )
      },
      line(angle: 90deg, length: 40%, stroke: 1pt + rgb(190, 190, 190)),
      section-list,
    )
    body
  }
  touying-slide(self: self, config: config, slide-body)
})


#let focus-slide(config: (:), background-color: none, background-img: none, body) = touying-slide-wrapper(self => {
  let background-color = if background-img == none and background-color == none {
    rgb(self.colors.primary)
  } else {
    background-color
  }
  let args = (:)
  if background-color != none {
    args.fill = background-color
  }
  if background-img != none {
    args.background = {
      set image(fit: "stretch", width: 100%, height: 100%)
      background-img
    }
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 1em, ..args),
  )
  set text(fill: self.colors.neutral-lightest, weight: "bold", size: 2em)
  touying-slide(self: self, std.align(horizon, body))
})



#let matrix-slide(config: (:), columns: none, rows: none, ..bodies) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(margin: 0em),
  )
  touying-slide(self: self, config: config, composer: components.checkerboard.with(columns: columns, rows: rows), ..bodies)
})

#let subheading = context if utils.current-heading(level: 3) != none {
  " / " + utils.display-current-heading(level: 3)
}
 
// #let h3 = " / " + utils.display-current-heading(level:3)
// #let h3len = len(h3)
#let university-theme(
  aspect-ratio: "16-9",
  align: top,
  progress-bar: true,
header: text(
    utils.display-current-heading(level: 2) +
    // display-current-heading always returns content, so query the heading itself
    context if utils.current-heading(level: 3) != none {
        subheading-text(utils.display-current-heading(level:3))
    },
    baseline: 10pt,
),
  header-right: self => box(utils.display-current-heading(level: 1)) + h(.3em) + self.info.logo,
  footer-columns: (60%, 30%, 10%),
  footer-a: self => if self.info.short-title == auto {
    self.info.title + "fe"
  } else {
    set align(left)
      text( 
        fill:rgb(100,100,100),
        weight: "extrabold",
        font: "Cascadia Code",
        // 
        context h(5%) +self.info.short-title + " -> " + utils.display-current-heading(level:1) //+ " / " + utils.display-current-heading(level:2) + " / " + utils.display-current-heading(level:3) 
    )
  
  },
  footer-b: self => text(
    // fill: rgb(17,40,57),
    fill:rgb(100,100,100),
    font: "Cascadia Code",
    weight: "semibold",
    
    self.info.author + "  [ "+ self.info.small_institute +" ]"),
  footer-c: self => {
    
    h(1fr)
    utils.display-info-date(self)
    h(1fr)
  text(
    fill:rgb(100,100,100),
    font: "Cascadia Code",
    weight: "extrabold",
    // appendix slides (after #show: appendix) are not part of the total
    if self.at("appendix", default: false) {
      context "{ " + utils.slide-counter.display() + " }"
    } else {
      context "{ " + utils.slide-counter.display() + " / " + utils.last-slide-number + " }"
    }
  )
    h(1fr)
  },
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (top: 3.5em, bottom: 1.25em, x: 2em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: 25pt)
        // show heading.where(level: 3): set text(fill: self.colors.primary, baseline: 10pt)
        // show heading.where(level: 4): set text(fill: self.colors.primary)
        // line(length: 100%)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: rgb("#04364A"),
      secondary: rgb("#176B87"),
      tertiary: rgb("#448C95"),
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000"),
    ),
    // save the variables for later use
    config-store(
      align: align,
      progress-bar: progress-bar,
      header: header,
      header-right: none,
      footer-columns: footer-columns,
      footer-a: footer-a,
      footer-b: footer-b,
      footer-c: footer-c,
    ),
    ..args,
  )

  body
}