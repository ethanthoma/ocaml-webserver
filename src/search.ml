open Opium

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

let get_search_handler (request: Request.t) =
    let search_value =
        match
        request
        |> Request.query "search"
        with
        | Some value -> value
        | None -> ""
    in let body =
        search_value
        |> query
        |> List.map Components.Search.row
        |> List.map Components.View.to_string
        |> String.concat "\n"
        |> Body.of_string
    in Response.make ~body ()
    |> Lwt.return
;;
