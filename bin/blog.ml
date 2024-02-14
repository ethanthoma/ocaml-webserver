open Fuzzy_search

let list_md_files =
    Sys.readdir "./blogs" |>
    Array.to_list |>
    List.filter (fun file -> Filename.extension file = ".md")

let query name =
    Query.create name |>
    search ~items:list_md_files
