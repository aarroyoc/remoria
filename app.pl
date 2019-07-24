:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_header)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_multipart_plugin)).
:- use_module(library(http/http_authenticate)).
:- use_module(library(http/http_unix_daemon)).
:- use_module(library(http/http_files)).

:- http_handler(/,index,[method(get)]).


index(Request) :-
	format('Content-Type: text/html~n~n'),
	format('Hello World').

start :-
	http_daemon([port(2345),fork(false)]).

:- start.
