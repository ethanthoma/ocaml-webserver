let list_md_files =
    Sys.readdir "./blogs" 
    |> Array.to_list 
    |> List.filter (fun file -> Filename.extension file = ".md")
;;

let query name =
    let open Fuzzy_search in
    Query.create name 
    |> search ~items:list_md_files
;;

