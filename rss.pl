:- module(rss, [rss/1]).

:- use_module(library(sgml_write)).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdf11),[rdf_canonical_literal/2]).
:- use_module('prefix.pl').

lrdf(S, P, O) :-
	rdf(S, P, XO),
	rdf_literal_value(XO, O).

rss(_Request) :-
	rss_file(Out),
	with_output_to(string(X),xml_write(Out, [header(true)])),
	format('Content-Type: text/xml~n~n'),
	writeln(X).

gen_item(Item) :-
	rdf(URI, rdf:type, schema:'BlogPosting'),
	lrdf(URI, schema:name, Title),
	lrdf(URI, schema:articleBody, Article),
	xml_quote_cdata(Article, ArticleCData, utf8),
	Item = element(item, [], [
		element(title, [], [Title]),
		element(link, [], [URI]),
		element(description, [], [ArticleCData]),
		element(guid, [], [URI])
	]).

rss_file(R) :-
	rdf(Blog, rdf:type, schema:'Blog'),
	lrdf(Blog, schema:name, Title),
	lrdf(Blog, schema:description, Description),
	lrdf(Blog, schema:inLanguage, Language),
	findall(Item, gen_item(Item), Items),
	Meta = [
		element(title, [], [Title]),
		element(link, [], [Blog]),
		element(description, [], [Description]),
		element(language, [], [Language])
	],
	append(Meta, Items, Channel),
	R = [element(rss, [version="2.0"], [
		element(channel, [], Channel)
	])].
