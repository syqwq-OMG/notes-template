#import "@preview/hydra:0.6.2": hydra, selectors
#import "@preview/ctheorems:1.1.3": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/zebraw:0.5.5": zebraw

#let colors = (
  rgb("93B7BE"),
  rgb("FBACBE"),
  rgb("FFBA49"),
  rgb("2B4162"),
  rgb("7B0828"),
  rgb("255C99"),
  rgb("FFD166"),
)

#let cn_font = "Source Han Serif SC"
#let en_font = "New Computer Modern"

#let note(course: "", author: "syqwq", watermark: "", body) = {
  set text(
    font: (
      en_font,
      cn_font,
    ),
    weight: "light",
  )

  set par(first-line-indent: 2em)

  show "。": ". "
  show: thmrules
  show: zebraw

  set page(
    numbering: "1",
    header: context {
      let current-page = here().page()

      if current-page <= 1 { return }

      let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == current-page)

      if current-page != 2 and has-heading { return }

      box(
        grid(
          columns: (1fr,) * 3,
          align: (horizon + left, horizon + center, horizon + right),
          box(height: 50%, image("src/ecnu-logo.svg")),
          box()[#context hydra(2, skip-starting: false)],
          box(text()[\- #here().page() -]),
        ),
        inset: 4pt,
        stroke: (bottom: 0.5pt),
      )
    },
    footer: context {
      let current-page = here().page()

      let has-heading = query(heading.where(level: 1)).any(it => it.location().page() == current-page)

      if not has-heading { return }
      if current-page <= 1 { return }

      align(center)[\- #current-page -]
    },
    background: rotate(-60deg, text(100pt, fill: rgb("#faf2f1"))[
      #strong()[#watermark]
    ]),
  )

  set heading(numbering: "1.")

  show heading.where(level: 1): t => context {
    if here().page() == 2 { return t }

    let chp = context counter(heading).get().at(0)

    set text(size: 30pt, font: (en_font, cn_font))
    [Chapter #chp \ #t.body \ ]
  }

  show heading.where(level: 2): t => context {
    set par(first-line-indent: 0em)
    set text(size: 18pt, font: ("New Computer Modern", "Source Han Serif SC"))

    [#counter(heading).display("1.1") #t.body]
  }

  show heading.where(level: 3): t => context {
    set par(first-line-indent: 0em)
    set text(size: 14pt, font: ("New Computer Modern", "Source Han Serif SC"))

    [#counter(heading).display("1.1.1") #t.body]
  }

  let cover = {
    let fill-color = rgb("#D8CFC6")

    set page(footer: none, background: image("src/bg-2.svg", width: 101%, fit: "cover"))

    set text(fill: white)
    set par(first-line-indent: 0pt)


    place(
      image("src/ecnu-logo-white.svg", height: 30%),
      dy: -80pt,
    )

    v(5fr)
    [
      #align(left)[#underline(
        (underline(text(size: 45pt, weight: 800)[#course], offset: 7pt, stroke: red)),
        stroke: red,
        offset: 11pt,
      )]
      #align(left)[
        #text(size: 45pt, weight: 800)[笔记]
      ]
    ]
    v(1em)
    text(
      font: "New Computer Modern Sans",
      size: 16pt,
      weight: 800,
    )[#math.copyright #author \ East China Normal University]
    v(10fr)
  }

  cover

  pagebreak()

  outline(depth: 2)

  pagebreak()

  body
}

#let thmtitle(t, color: rgb("#000000")) = {
  text(font: "New Computer Modern Sans", weight: "semibold", fill: color)[#t]
}
#let thmname(t, color: rgb("#000000")) = {
  text(font: ("New Computer Modern Sans", "Heiti SC"), fill: color)[#t]
}

#let thmtext(t, color: rgb("#000000")) = {
  let a = t.children
  if (a.at(0) == [ ]) {
    a.remove(0)
  }
  t = a.join()

  text(font: (en_font, cn_font), fill: color)[#t]
}


#let thmbase(
  identifier,
  head,
  ..blockargs,
  supplement: auto,
  padding: (top: 0em, bottom: 0em),
  namefmt: x => [(#x)],
  titlefmt: strong,
  bodyfmt: x => x,
  separator: [#h(0.1em).#h(0.2em) \ ],
  base: "heading",
  base-level: none,
) = {
  if supplement == auto {
    supplement = head
  }
  let boxfmt(name, number, body, title: auto, ..blockargs_individual) = {
    if not name == none {
      name = [ #namefmt(name)]
    } else {
      name = []
    }
    if title == auto {
      title = head
    }
    if not number == none {
      title += " " + number
    }
    title = titlefmt(title)
    body = bodyfmt(body)
    pad(
      ..padding,
      showybox(
        width: 100%,
        radius: 0.3em,
        breakable: true,
        padding: (top: 0em, bottom: 0em),
        ..blockargs.named(),
        ..blockargs_individual.named(),
        [#title#name#titlefmt(separator)#body],
      ),
    )
  }

  let auxthmenv = thmenv(
    identifier,
    base,
    base-level,
    boxfmt,
  ).with(supplement: supplement)

  return auxthmenv.with(numbering: "1.1")
}

#let styled-thmbase = thmbase.with(titlefmt: thmtitle, namefmt: thmname, bodyfmt: thmtext)

#let builder-thmline(color: rgb("#000000"), ..builderargs) = styled-thmbase.with(
  titlefmt: thmtitle.with(color: color.darken(30%)),
  bodyfmt: thmtext.with(color: color.darken(70%)),
  namefmt: thmname.with(color: color.darken(30%)),
  frame: (
    body-color: color.lighten(96%).transparentize(50%),
    border-color: color.darken(10%),
    thickness: (left: 2pt),
    inset: 1.2em,
    radius: 0em,
  ),
  ..builderargs,
)


#let definition-style = builder-thmline(color: colors.at(3))
#let definition = definition-style("definition", "Definition")
#let proposition = definition-style("proposition", "Proposition")
#let remark = definition-style("remark", "Remark")
#let observation = definition-style("observation", "Observation")

#let theorem-style = builder-thmline(color: colors.at(5))
#let theorem = theorem-style("theorem", "Theorem")
#let lemma = theorem-style("lemma", "Lemma")
#let corollary = theorem-style("corollary", "Corollary")

#let problem-style = builder-thmline(color: colors.at(4))
#let problem = problem-style("problem", "Problem")

#let example-style = builder-thmline(color: colors.at(6))
#let example = example-style("example", "Example").with(numbering: none)
// #let example=example-style("example", "Example")

#let proof(body, name: none) = {
  thmtitle[Proof]
  if name != none {
    [ #thmname[#name]]
  }
  thmtitle[.]
  body
  h(1fr)
  $square.filled$
}

#let solution(body, name: none) = {
  thmtitle[Solution]
  if name != none {
    [ #thmname[#name]]
  }
  thmtitle[.]
  body
}
