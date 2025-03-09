#show: ams-article.with(
$if(title)$
  title: [$title$],
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(by-author)$
   authors: (
  $for(by-author)$
  (
    name: "$it.name.literal$",
    email: "$it.email$",
    url: "$it.url$",
    $for(it.affiliations/first)$department: [$it.department$],
    organization: [$it.name$],
    location: [$it.city$, $it.region$ $it.postal-code$],
    $endfor$
  )$sep$,
  $endfor$,
  ),
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(bibliography)$
  bibliography-file: "$bibliography$",
$endif$


$if(journal)$
  journal: (
    publisher-id: "$journal.publisher-id$",
    id: "$journal.id$",
    title: "$journal.title$",
    abbrev-title: "$journal.abbrev-title$",
    pissn: "$journal.pissn$",
    eissn: "$journal.eissn$",
    publisher-name: "$journal.publisher-name$",
    publisher-loc: "$journal.publisher-loca$",
  ),
$endif$

$if(article)$
  article: (
    heading: "$article.heading$",
    volume: "$article.volume$",
    issue: "$article.issue$",
    doi: "$article.doi$",
    elocation-id: "$article.elocation-id$",
    scielo-id: "$article.scielo-id$",
    published_date: datetime(
      year: $article.published_date.year$,
      month: $article.published_date.month$,
      day: $article.published_date.day$,
    ),
    received_date: datetime(
      year: $article.received_date.year$,
      month: $article.received_date.month$,
      day: $article.received_date.day$,
    ),
    accepted_date: datetime(
      year: $article.accepted_date.year$,
      month: $article.accepted_date.month$,
      day: $article.accepted_date.day$,
    ),
  ),
$endif$
)
