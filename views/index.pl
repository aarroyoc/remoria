:- module(view_index, [view_index/3]).

:- use_module(library(http/html_write)).

gen_link(Link, HTMLLink) :-
	HTMLLink = html([li(Link)]).

view_index(Links) -->
    {
    	maplist(gen_link, Links, HTMLLinks)
    },
    html([
	h1('Remoria'),
	ul(HTMLLinks)
    ]).
