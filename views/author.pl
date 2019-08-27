:- module(view_author,[view_author/3]).

:- use_module(library(http/html_write)).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdf11),[rdf_canonical_literal/2]).

:- use_module('common.pl').

view_author(Author) -->
    {
        atom_string(XAuthor,Author),
        atom_concat('/author/', XAuthor, AuthorURI),
        rdf(Blog, rdf:type, schema:'Blog'),
        atom_concat(Blog, AuthorURI, URI),
	rdf(URI, schema:name, LName),
	rdf_literal_value(LName, Name)
	%Name = URI
    },
    html([
        html([
            head([
                \title,
                \charset,
                \meta
            ]),
            body([
                h1(Name)
            ])
        ])
    ]).
