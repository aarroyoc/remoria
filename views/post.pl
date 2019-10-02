:- module(view_post,[view_post/4]).

:- use_module(library(http/html_write)).

view_post(Name, Body) -->
    html([
        h1(Name),
        article(\[Body])
    ]).