// ======= biblio.typ =======

$if(csl)$   
#set bibliography(style: "$csl$") 
$elseif(bibliographystyle)$ 
#set bibliography(style: "$bibliographystyle$") 
$endif$

// $if(biblio-title)$
// #set bibliography(title: "$bibliography-title$")
// $endif$


$if(bibliography)$
#bibliography($for(bibliography)$"$bibliography$"$sep$,$endfor$)
$endif$

// ======= biblio.typ =======