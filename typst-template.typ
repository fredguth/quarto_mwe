#import "@preview/marginalia:0.1.3" as marginalia: note, note-numbering
#let deleted(content) = {
  highlight(strike(extent: 2pt, stroke: 2pt, content), fill: rgb("#f29090"))
}

#let added(content) = {
  highlight(
    fill: rgb("#90f290"),
    overline(
      stroke: (paint: green.darken(40%), thickness: 2pt, dash: "dashed"),
      offset: 3pt,
      [#content],
    ),
  )
}

// #let comment = note.with(
//   reverse: true,
//   block-style: (fill: oklch(90%, 0.06, 140deg), inset: (x: 4pt), outset: (y: 4pt), width: 100%, radius: 4pt),
// )
#let comment = note.with(
  reverse: true,
)

#set figure.caption(position: top)


#let make-venue() = {
  v(-1cm)
  box(image("glogo.gif", height: 3cm))
  h(1fr)
  box[#text(font: "Open Sans", 24pt)[Revista Sociedade e Estado]]
  v(.5cm)
}

#let author-block(author) = {
  text(8pt)[
    *#{author.name}*\
    #{ author.degrees }\
    // #{author.organization}\
    \
    
    email: #author.email\
    orcid: #link("https://orcid.org/" + author.orcid)[#author.orcid] \
    #v(.25cm)
  ]
}
#let config = (
  inner: (far: 5mm, width: 50mm, sep: 5mm),
  // outer: ( far: 5mm, width: 16mm, sep: 5mm ),
  top: 2cm,
  bottom: 2cm,
  // book: false,
  // clearance: 8pt,
  flush-numbers: true,
  numbering: (..i) => super(numbering("a) ", ..i)),
)
#marginalia.configure(..config)


#let article(
  title: none,
  subtitle: none,
  authors: none,
  citation: none,
  copyright: none,
  license: none,
  abstract: none,
  keywords: none,
  lang: "pt",
  region: "BR",
  cols: 1,
  toc: false,
  resumo: none,
  palavras-chave: none,
  revista-link: none,
  article: (),
  journal: (),
  details: [],
  biblio-title: "Referências bibliográficas",
  body,
) = {
  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2cm, x: 1.6cm),
  )

  set list(indent: 8pt)
  show heading: set block(below: 12pt)
  set rect(
    inset: 8pt,
    stroke: none,
    width: 100%,
  )
  set text(10pt, font: "Open Sans", lang: lang, region: region)
  show quote: set pad(left: 2cm)

  make-venue()
  line(length: 100%, stroke: 0.5pt)

  grid(
    columns: (1fr, 3fr),
    gutter: 3pt,
    rect[
      Volume #article.volume\
      Número #article.issue\
      Ano #article.year\
      Id #article.elocation-id\
    ],
    rect[
      #align(
        right,
        [
          #article.heading\
          #v(.7cm)
          #text(8pt)[DOI: #link("https://doi.org/" + article.doi)[#article.doi]]
        ],
      )
    ],
  )

  line(length: 100%, stroke: 0.5pt)
  v(1cm)
  text(16pt)[*#title*]
  v(.5cm)

  grid(
    columns: (1fr, 1fr),
    gutter: 2pt,
    rect[
      #for (i, author) in authors.enumerate() [
        #if (calc.rem(i, 2) == 0) {
          // super[#{i+1}]
          author-block(author)
        }
      ]
    ],
    rect[
      #for (i, author) in authors.enumerate() [
        #if (calc.rem(i, 2) == 1) {
          // super[#{i+1}]
          author-block(author)
        }
      ]
    ],
  )


  place(
    bottom,
    [
      #line(length: 100%, stroke: 0.5pt)
      #set text(8pt, fill: luma(40%))
      #grid(
        columns: (2fr, 1fr),
        gutter: 10pt,
        // *Copyright© #data_aprovacao.ano Os autores.*\
        rect[
          Este é um artigo em acesso aberto distribuído nos termos da Licença
          Creative Commons Atribuição que permite o uso irrestrito, a distribuição e reprodução em qualquer meio
          desde que o artigo original seja devidamente citado.
          #image("cc_by.svg", height: 1cm)
        ],
        align(
          right,
          rect[
            *Recebido em:* #article.received-date.display("[day]/[month]/[year]")\
            *Aprovado em:* #article.accepted-date.display("[day]/[month]/[year]")\
            #v(.75cm)
            Editor responsável: #{journal.editor}\

          ],
        )
      )
    ],
  )

  pagebreak()

  set page(
    margin: (left: 5.8cm, right: 1.6cm),
    header: context [
      #place(
        dx: -4.2cm,
        dy: 1cm,
        block(
          width: 100% + 4.2cm,
          grid(
            columns: (1fr, 2fr),
            gutter: 10pt,
            [\[ #article.heading \]],
            align(
              right,
              text(
                fill: luma(40%),
                size: 8pt,
                [
                  #journal.title
                  Vol. *#article.volume*,
                  No. *#article.issue*,
                  Ano *#article.year*,
                  #article.elocation-id],
              ),
            ),
          ),
        ),
      )
    ],

    footer: context [
      #set text(8pt)
      #block(
        width: 100% + 4.2cm,
        place(
          dx: -4.2cm,
          grid(
            columns: (3fr, 1fr),
            gutter: 3pt,
            link("https://doi.org/" + article.doi)[#text(luma(60%), [DOI: #article.doi])],
            place(right, counter(page).display("1 de 1", both: true)),
          ),
        ),
      )
    ],
  )

  set footnote.entry(indent: 0em)
  set footnote.entry(gap: 0.8em)
  show footnote.entry: it => {
    set text(size: 7pt)
    set par(justify: true)
    let loc = it.note.location()
    numbering(
      "1: ",
      ..counter(footnote).at(loc),
    )
    it.note.body
  }
  v(.1cm)
  place(
    dx: -4.2cm,
    block(
      width: 100% + 4.2cm,
      [
        #text(font: "TeX Gyre Pagella", size: 18pt, weight: "bold", title)
        #v(.3cm)
        #text(size: 10pt, authors.enumerate().map(((i, author)) => author.name).join(", "))
      ],
    ),
  )

  set text(weight: "regular")
  set par(justify: true)

  show figure: align.with(center)
  show figure: set text(8pt)
  show figure.caption: pad.with(x: 10%)

  show table.cell.where(y: 0): strong
  set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 1pt + black)
    } else {(bottom: .25pt + gray)},
    align: (x, y) => (
      if x > 0 { center }
      else { left }
    )
  )

  text(8.5pt)[
    #v(4cm)
    *Resumo:* #resumo
   
    *Palavras-chave:* #{palavras-chave.join("; ")}.
    #v(8pt)
    *Abstract:* #abstract

    *Keywords:* #{keywords.join("; ")}.
  ]

  v(5pt)
  line(length: 100%, stroke: 0.5pt)
  v(0pt)
  set text(font: "Tex Gyre Pagella")
  body
}
