:- module(view_post,[view_post/4]).

:- use_module(library(http/html_write)).

view_post(Name, Body) -->
    html([
        header([
		h1([a(href='/','Remoria')]),
		nav([
			ul(class='nav navbar-nav',[
				li(a(href='/about','About'))
			])
		])
	]),
	div(class=page,[
        	h2(Name),
        	article(\[Body])]),
	footer('Copyright 2019 by Adrián Arroyo Calle')
    ]).
