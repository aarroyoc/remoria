:- module(common, [head/2, title/2, charset/2, css/2, meta/2]).

:- use_module(library(http/html_write)).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdf11),[rdf_canonical_literal/2]).

title --> 
    {
        rdf(Blog, rdf:type, schema:'Blog'),
        rdf(Blog, schema:name, XTitle),
        rdf_literal_value(XTitle, Title)        
    },
    html([title(Title)]).

charset -->
    html([meta(charset="utf-8")]).

css -->
    html([link([rel="stylesheet", href="/static/style.css"])]).


meta -->
    {
        rdf(Blog, rdf:type, schema:'Blog'),
        rdf(Blog, schema:keywords, XKeywords),
        rdf_literal_value(XKeywords, Keywords),
        rdf(Blog, schema:description, XDescription),
        rdf_literal_value(XDescription, Description)
    },
    html([
        meta([name=description,content=Description]),
        meta([name=keywords,content=Keywords])
    ]).

head --> 
	html([
		\title,
		\charset,
		\css,
		\meta
	]).
