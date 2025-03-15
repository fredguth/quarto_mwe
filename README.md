Run with: `quarto render index.qmd`

# MWE of scielo template for Quarto

I am trying to build a scielo template to be used with Quarto.
I am facing 2 problems:

1. The footnotes are being generated as:
```
<fn id="fn1">This is a footnote</fn>
```
instead of:
```
<fn fn-type="other' id="fn1">This is a footnote</fn>
```
For some reason, the scielo format checker complaints if there is no fn-type.

I tried to solve with the `footnote-type.lua` filter, but it is not working. It seems like the `<fn>` tag is being generated after the filter is applied.

2. The bigger problem I have is that I have no control of what is being generated with `$back$` and I don't know how to access this information to change it. 

It is being generated without the `<mixed citation>` tag as:
```
 <ref id="ref-sinhoretto2014a">
        <element-citation publication-type="article-journal">
          <person-group person-group-type="author">
            <name>
              <surname>SINHORETTO</surname>
              <given-names>Jacqueline</given-names>
            </name>
            <name>
              <surname>SENASP</surname>
              <given-names>MINISTÉRIO DA JUSTIÇA;</given-names>
            </name>
          </person-group>
          <article-title>A filtragem racial na seleção policial de suspeitos: segurança pública e relações raciais no Brasil</article-title>
          <source>MINISTÉRIO DA JUSTIÇA; SENASP. Pensando a segurança pública: relatório de pesquisa. Brası́lia: Ministério da Justiça</source>
          <year iso-8601-date="2014">2014</year>
        </element-citation>
      </ref>
```

while Scielo expects with the `<mixed-citation>` tag as in :

```
<ref id="B38">
				<mixed-citation>CENTRO DE PESQUISA E DESENVOLVIMENTO EM TELECOMUNICAÇÕES (CPQD). Modelo de referência - Sistema Brasileiro de Televisão Digital Terrestre, 2006. Disponível em: &lt;<ext-link ext-link-type="uri" xlink:href="http://sbtvd.cpqd.org.br">http://sbtvd.cpqd.org.br</ext-link>&gt;. Acesso em: 05 Mar. 2009.</mixed-citation>
				<element-citation publication-type="book">
					<person-group person-group-type="author">
						<collab>CENTRO DE PESQUISA E DESENVOLVIMENTO EM TELECOMUNICAÇÕES (CPQD)</collab>
					</person-group>
					<source>Modelo de referência - Sistema Brasileiro de Televisão Digital Terrestre</source>
					<year>2006</year>
					<ext-link ext-link-type="uri" xlink:href="http://sbtvd.cpqd.org.br">http://sbtvd.cpqd.org.br</ext-link>
				</element-citation>
			</ref>
```
