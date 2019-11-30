:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_multipart_plugin)).
:- use_module(library(http/http_authenticate)).
:- use_module(library(http/http_unix_daemon)).
:- use_module(library(http/http_files)).

:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdf11),[rdf_canonical_literal/2]).

:- use_module('storage.pl').
:- use_module('prefix.pl').
:- use_module('rss.pl').
:- use_module('views/common.pl').
:- use_module('views/author.pl').
:- use_module('views/post.pl').
:- use_module('views/index.pl').

:- http_handler(root(static/Path), static_css(Path), [method(get)]).
:- http_handler(root(page/Page), page(Page), [method(get)]).
:- http_handler(root(about), about, [method(get)]).
:- http_handler(root('rss.xml'), rss, [method(get)]).
:- http_handler(root(_), content(_), [method(get)]).
:- http_handler(root(.), index, [method(get)]).

static_css(Path, Request) :-
	string_concat('static/', Path, RealPath),
	atom_string(AtomPath, RealPath),
	http_reply_file(AtomPath,[],Request).

page(_Number, _Request) :-
	format('Content-Type: text/html~n~n'),
	format('Hello Page').

% Person
content(_Path, Request) :-
    content_uri(Request, URI),
	rdf(URI, rdf:type, schema:'Person'),
	lrdf(URI, schema:name, Name),
	reply_html_page([\head],[\view_author(Name)]).

% Blog Post
content(_Path, Request) :-
	content_uri(Request, URI),
	rdf(BlogURI, rdf:type, schema:'Blog'),
	lrdf(BlogURI, schema:name, Title),
	rdf(URI, rdf:type, schema:'BlogPosting'),
	lrdf(URI, schema:name, Name),
	lrdf(URI, schema:articleBody, Body),
	lrdf(URI, schema:dateCreated, Date),
	reply_html_page([\head],[\view_post(Title, Name, Date, Body)]).

content(_, Request) :- http_404([],Request).

% About

about(_Request) :-
	rdf(URI, rdf:type, schema:'Blog'),
	lrdf(URI, schema:name, Title),
	lrdf(URI, schema:abstract, Body),
	lrdf(URI, schema:dateCreated, Date),
	reply_html_page([\head],[\view_post(Title, 'About', Date, Body)]).

post_link(Post) :-
	rdf(URI, rdf:type, schema:'BlogPosting'),
	lrdf(URI, schema:name, Title),
	lrdf(URI, schema:dateCreated, Date),
	Post = post(Title, URI, Date).

index(_Request) :-
	findall(Post, post_link(Post), Posts),
	sort(3, @>=, Posts, SortedPosts),
	rdf(URI, rdf:type, schema:'Blog'),
	lrdf(URI, schema:name, Title),
	reply_html_page([\head], [\view_index(Title, SortedPosts)]).

content_uri(Request, URI) :-
	member(request_uri(Path), Request),
	rdf(Blog, rdf:type, schema:'Blog'),
	atom_concat(Blog, Path, URI).

lrdf(S, P, O) :-
	rdf(S, P, XO),
	rdf_literal_value(XO, O).



start :-
	load_data,
	html_set_options([dialect(html5)]),
	http_daemon([port(2345),fork(false)]).

:- start.
