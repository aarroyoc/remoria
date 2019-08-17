:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_multipart_plugin)).
:- use_module(library(http/http_authenticate)).
:- use_module(library(http/http_unix_daemon)).
:- use_module(library(http/http_files)).

:- use_module('storage.pl').
:- use_module('views/author.pl').

:- http_handler(root(author/Author),author(Author),[method(get)]).


%index(Request) :-
%	format('Content-Type: text/html~n~n'),
%	format('Hello World').

author(Author,_Request) :-
	phrase(
        view_author(Author),
        HTML,
        []    
    ),
    format('Content-Type: text/html~n~n'),
	print_html(HTML).

start :-
	load_data,
	html_set_options([dialect(html5)]),
	http_daemon([port(2345),fork(false)]).

:- start.
