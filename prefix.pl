:- module(prefix, []).

:- use_module(library(semweb/rdf_db)).

:- rdf_register_prefix(foaf, 'http://xmlns.com/foaf/0.1/').
:- rdf_register_prefix(rdf, 'http://www.w3.org/1999/02/22-rdf-syntax-ns#').
:- rdf_register_prefix(schema, 'https://schema.org/').
