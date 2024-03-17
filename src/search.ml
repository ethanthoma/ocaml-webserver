open Turso

let search query ~items =
    let open! Core in
    let open Fuzzy_search in
    let compare_blog a b = 
        compare_string a.title b.title
    in
    List.filter_map items ~f:(fun item ->
        let title = item.title in
        match score query ~item:title with
        | 0 -> None
        | score -> Some (score, String.length title, item))
    |> List.sort ~compare:[%compare: int * int * blog]
    |> List.map ~f:Tuple3.get3
;;

let query name =
    let blogs = Cache.Blogs.get () in
    Fuzzy_search.Query.create name 
    |> search ~items:blogs
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
