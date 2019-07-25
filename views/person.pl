:- module(view_person,[view_person/2]).

:- use_module(library(http/html_write)).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdf11),[rdf_canonical_literal/2]).


view_person(Title) -->
    html([
        head([
            title(Title)    
        ]),
        body([
            h1(Title)
        ])
    ]).

view_person -->
    {
        rdf(Blog,'http://www.w3.org/1999/02/22-rdf-syntax-ns#type','https://schema.org/Blog'),
        rdf(Blog,'https://schema.org/name',XTitle),
        rdf_literal_value(XTitle,Title)        
    },
    view_person(Title).