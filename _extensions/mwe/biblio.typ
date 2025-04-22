// ======= biblio.typ =======
$if(citations)$
$if(csl)$   
#set bibliography(style: "$csl$") 
$elseif(bibliographystyle)$ 

$endif$

// $if(biblio-title)$
// #set bibliography(title: "$bibliography-title$")
// $endif$


$if(bibliography)$
#bibliography($for(bibliography)$"$bibliography$"$sep$,$endfor$)
$endif$
$endif$

// ======= biblio.typ =======