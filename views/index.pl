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
	h1('Remoria'),
	ul(HTMLLinks)
    ]).
