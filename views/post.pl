:- module(view_post,[view_post/7]).

:- use_module(library(http/html_write)).
:- use_module('prefix.pl').

gen_comment(Comment, CommentHTML) :-
	rdf(Comment, schema:author, Author),
	lrdf(Comment, schema:text, CommentText),
	lrdf(Author, schema:name, AuthorName),
	lrdf(Author, schema:url, AuthorURL),
	CommentHTML = div([
		div(AuthorName),
		div(AuthorURL),
		div(CommentText)
	]).


view_post(Title, Name, Date, Body, Comments) -->
	{
		maplist(gen_comment, Comments, HTMLComments)
	},
    html([
        header([
		h1([a(href='/',Title)]),
		nav([
			ul(class='nav navbar-nav',[
				li(a(href='/about','About'))
			])
		])
	]),
	div(class=page,[
		h2(Name),
		p(Date),
		article([
			main(\[Body]),
			div(HTMLComments)
			])
	]),
	footer(['Copyright 2019-2020 by Adrián Arroyo Calle. Proudly running using ', a(href='https://github.com/aarroyoc/remoria','Remoria'), ' a blog engine for SWI Prolog'])
    ]).
