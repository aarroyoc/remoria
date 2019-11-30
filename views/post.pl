:- module(view_post,[view_post/6]).

:- use_module(library(http/html_write)).

view_post(Title, Name, Date, Body) -->
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
        	article(\[Body])]),
	footer(['Copyright 2019 by Adrián Arroyo Calle. Proudly running using ', a(href='https://github.com/aarroyoc/remoria','Remoria'), ' a blog engine for SWI Prolog'])
    ]).
