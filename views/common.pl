:- module(common, [title/2, charset/2, meta/2]).

:- use_module(library(http/html_write)).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdf11),[rdf_canonical_literal/2]).

title --> 
    {
        rdf(Blog,'http://www.w3.org/1999/02/22-rdf-syntax-ns#type','https://schema.org/Blog'),
        rdf(Blog,'https://schema.org/name',XTitle),
        rdf_literal_value(XTitle,Title)        
    },
    html([title(Title)]).

charset -->
    html([meta(charset="utf-8")]).

meta -->
    {
        rdf(Blog,'http://www.w3.org/1999/02/22-rdf-syntax-ns#type','https://schema.org/Blog'),
        rdf(Blog,'https://schema.org/keywords',XKeywords),
        rdf_literal_value(XKeywords, Keywords),
        rdf(Blog,'https://schema.org/description',XDescription),
        rdf_literal_value(XDescription, Description)
    },
    html([
        meta([name=description,content=Description]),
        meta([name=keywords,content=Keywords])
    ]).