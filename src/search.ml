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

let content request =
    let search_value =
        match Dream.query request "search" with
        | Some value -> value
        | None -> ""
    in 
    search_value
    |> query
    |> List.map Components.Search.row
    |> List.map Components.View.to_string
    |> String.concat "\n"
    |> Dream.html
;;
