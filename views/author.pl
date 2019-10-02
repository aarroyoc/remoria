:- module(view_author,[view_author/3]).

:- use_module(library(http/html_write)).

view_author(AuthorName) -->
    html([
        h1(AuthorName)
    ]).
