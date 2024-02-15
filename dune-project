(lang dune 3.7)

(name webserver)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Ethan Thoma")

(maintainers "Ethan Thoma")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name webserver)
 (synopsis "Htmx webserver")
 (description "Htmx webserver")
 (depends ocaml dune opium reason tyxml-jsx easy_logging fuzzy_match omd)
 (tags
  (topics "Htmx" "JSX" "Ocaml")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
