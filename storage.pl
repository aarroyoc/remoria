:- module(storage,[load_data/0,save_data/0]).

:- use_module(library(semweb/rdf_db)).

load_data :-
    File = "db/remoria.xml",
    exists_file(File),
    rdf_load(File).

load_data :-
    rdf_load("sample/remoria.xml"),
    rdf_save("db/remoria.xml").

save_data :-
    rdf_save("db/remoria.xml",
        [
            document_language('en'),
            encoding('utf-8')
        ]).
