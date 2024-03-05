(lang dune 3.7)

(name webserver)

(generate_opam_files true)

(source (github ethanthoma/ocaml-webserver))

(authors "Ethan Thoma")

(maintainers "Ethan Thoma")

(license LICENSE)

(package
  (name webserver)
  (synopsis "Htmx webserver")
  (description "Htmx webserver")
  (depends 
    ocaml 
    dune 
    dream
    reason
    tyxml-jsx
    piaf
    fuzzy_match
    omd
    ppx_string
  )
  (tags (topics "Htmx" "JSX" "Ocaml"))
 )
