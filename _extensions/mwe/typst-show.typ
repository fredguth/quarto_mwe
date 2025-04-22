#show: doc => article(
$if(title)$
  title: [$title$],
$endif$





$if(by-author)$
   authors: (
  $for(by-author)$
  (
    name: "$it.name.literal$",
    given-names: "$it.given-names$",
    surname: "$it.surname$",
    email: [$it.email$],
    note: "$it.note$",
    orcid: "$it.orcid$",
    degrees: "$for(it.degrees)$$it$$sep$\n$endfor$",
    
    
    $for(it.affiliations/first)$
      organization: [$it.name$],
      department: "$it.department$",
      city: "$it.city$",
      state: "$it.state$",
      country: "$it.country$",
      url: "$it.url$",
    $endfor$
  )$sep$,
  $endfor$,
  ),
$endif$

$if(palavras-chave)$
  palavras-chave: ($for(palavras-chave)$"$it$"$sep$, $endfor$),
$endif$

$if(keywords)$
  keywords: ($for(keywords)$"$it$"$sep$, $endfor$),
$endif$

$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(resumo)$
  resumo: [$resumo$],
$endif$

$if(abstract)$
  abstract: [$abstract$],
$endif$

$if(copyright)$
  copyright: (
    holder: "$copyright.holder$",
    year: "$copyright.year$"
  ),
$endif$

$if(citation)$
  citation: (
    container-title: "$citation.container-title$",
    volume: "$citation.volume$",
    issue: "$citation.issue$",
    elocation-id: "$citation.elocation-id$",
    doi: "$citation.doi$",
  ),
$endif$

$if(journal)$
  journal: (
    id: "$journal.id$",
    title: "$journal.title$",
    abbrev-title: "$journal.abbrev-title$",
    publisher-id: "$journal.publisher-id$",
    pissn: "$journal.pissn$",
    eissn: "$journal.eissn$",
    publisher-name: "$journal.publisher-name$",
    publisher-loc: "$journal.publisher-loc$",
    editor: "$journal.editor$",
  ),
$endif$

$if(article)$
  article: (
    heading: "$article.heading$",
    volume: "$article.volume$",
    issue: "$article.issue$",
    year: "$article.year$",
    doi: "$article.doi$",
    elocation-id: "$article.elocation-id$",
    received-date: datetime(
      year: $article.received-date.year$,
      month: $article.received-date.month$,
      day: $article.received-date.day$
    ),
    accepted-date: datetime(
      year: $article.accepted-date.year$,
      month: $article.accepted-date.month$,
      day: $article.accepted-date.day$
    ),
  ),
$endif$


$if(biblio-title)$
    biblio-title: "$biblio-title$",
$endif$

cols: 1,

doc)