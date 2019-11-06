:- module(view_index, [view_index/3]).

:- use_module(library(http/html_write)).

gen_link(Post, HTMLLink) :-
	post(Title, Link, Date) = Post,
	HTMLLink = li(a(href=Link,Title)).

view_index(Posts) -->
    {
    	maplist(gen_link, Posts, HTMLLinks)
    },
    html([
        header([
	    h1([a(href='/', 'Remoria')]),
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
	footer('Copyright 2019 by Adrián Arroyo Calle')
    ]).
