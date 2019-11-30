:- module(view_index, [view_index/4]).

:- use_module(library(http/html_write)).

gen_link(Post, HTMLLink) :-
	post(Title, Link, _) = Post,
	HTMLLink = li(a(href=Link,Title)).

view_index(Title, Posts) -->
    {
    	maplist(gen_link, Posts, HTMLLinks)
    },
    html([
        header([
	    h1([a(href='/', Title)]),
	    nav([
	        ul(class='nav navbar-nav', [
		    li(a(href='/about','About'))
		])
	    ])
	]),
	div(class=page,[
            h2('All posts'),
	    ul(HTMLLinks)
	]),
	footer(['Copyright 2019 by Adrián Arroyo Calle. Proudly running using ', a(href='https://github.com/aarroyoc/remoria','Remoria'), ' a blog engine for SWI Prolog'])
    ]).
