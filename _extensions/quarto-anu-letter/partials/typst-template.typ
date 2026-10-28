// ANU letter template for Typst, matching the layout of the LaTeX version

#let anu-gold = rgb("#BE830E")
#let anu-grey = rgb("#5F6368")

// file paths arrive from pandoc as escaped markup, so turn them back into
// plain strings before passing them to image()
#let to-string(it) = {
  if it == none or type(it) == str { it }
  else if it.has("text") { it.text }
  else if it.has("children") { it.children.map(to-string).join() }
  else if it.has("body") { to-string(it.body) }
  else if it == [ ] { " " }
}

// label with items listed beside it, used for enclosures and cc
#let hanging-list(label, items) = grid(
  columns: 2,
  column-gutter: 0.3em,
  label, items.join(linebreak()),
)

#let letter(
  title: none,
  author: (),
  address: (),
  date: none,
  subject: none,
  subject-title: [Subject],
  subject-suffix: [:],
  opening: none,
  closing: none,
  encl: (),
  cc: (),
  ps: none,
  font: ("Roboto",),
  fontsize: 11pt,
  title-bg-image: none,
  bg-image: none,
  doc,
) = {
  let title-bg-image = to-string(title-bg-image)
  let bg-image = to-string(bg-image)

  set document(title: title)
  set text(font: font, size: fontsize)
  set par(justify: true, spacing: 1.26em)
  set page(
    // crest and gold rule on the first page, lighter background afterwards
    background: context {
      let bg = if here().page() == 1 { title-bg-image } else { bg-image }
      if bg != none { image(bg, width: 100%, height: 100%, fit: "stretch") }
    },
    footer: context {
      if here().page() > 1 {
        set align(right)
        set text(size: 0.82em, fill: anu-grey)
        [Page #here().page() of #counter(page).final().first()]
      }
    },
  )
  show link: set text(fill: anu-gold)
  show quote.where(block: true): it => block(spacing: 1.26em, pad(x: 2.5em, it.body))

  // sender address block, aligned to the right of the crest
  if author.len() > 0 {
    set align(right)
    set par(justify: false, leading: 0.6em, spacing: 0.6em)
    set text(size: 0.91em, fill: anu-grey)
    // start the first line where LaTeX puts it (\topskip below the margin)
    v(3.8pt)
    for a in author {
      let aff = a.at("affiliation", default: (:))
      let city-line = (aff.at("city", default: none), aff.at("postal-code", default: none))
        .filter(x => x != none)
        .join(" ")
      let lines = (
        if "name" in aff { text(fill: black, weight: "bold", aff.name) },
        aff.at("department", default: none),
        aff.at("address", default: none),
        city-line,
        aff.at("country", default: none),
      ).filter(x => x != none)
      par(lines.join(linebreak()))
    }
  }

  if date != none {
    block(above: 3.87em, below: 2.61em, text(size: 0.91em, fill: anu-grey, date))
  }
  if address.len() > 0 {
    block(below: 2.61em, address.join(linebreak()))
  }
  if subject != none {
    block(below: 2.61em, strong[#text(fill: anu-gold)[#subject-title#subject-suffix] #subject])
  }
  if opening != none {
    opening
    parbreak()
  }

  doc

  // closing and signatures, kept together on one page
  block(above: 1.57em, breakable: false, {
    set par(justify: false)
    closing
    v(3.55em)
    for (i, a) in author.enumerate() {
      if i > 0 { v(20mm) }
      block({
        // signature image sits in the space above the name
        if a.at("signature", default: none) != none {
          place(top + left, dy: -1.3cm - 0.45em, image(to-string(a.signature), height: 1.3cm))
        }
        strong(a.name)
        if a.at("position", default: none) != none {
          linebreak()
          text(size: 0.91em, fill: anu-grey, a.position)
        }
      })
    }
  })

  v(1fr)
  if encl.len() > 0 or cc.len() > 0 {
    set text(size: 0.91em, fill: anu-grey)
    set par(justify: false, leading: 0.6em)
    set block(spacing: 1.18em)
    if encl.len() > 0 { hanging-list([Enclosures:], encl) }
    if cc.len() > 0 { hanging-list([cc:], cc) }
  }
  if ps != none { block(above: 1.1em, ps) }
}
