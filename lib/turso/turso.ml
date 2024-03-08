open Ctypes
open Foreign

let () =
    let init = foreign "Init" (void @-> returning void) in
    init ()
;;

type blog = {
    filename:       string;
    title:          string;
    description:    string;
    content:        string;
    tags:           string list;
    date:           string;
}

let empty_blog = { 
    filename    = "";
    title       = "";
    description = "";
    content     = "";
    tags        = [];
    date        = "";
}

let json_to_blog json =
    let open Yojson.Basic.Util in
    let title = json |> member "Title" |> to_string in
    let filename = json |> member "Slug" |> to_string in
    let description = json |> member "Description" |> to_string in 
    let content = json |> member "Content" |> to_string in
    let date = String.sub (json |> member "Date" |> to_string) 0 10 in
    let tags = json |> member "Tags" |> to_list |> filter_string in
    { filename; title; description; content; tags; date; }
;;

let get_blogs () = 
    let get_blog_table = foreign "GetBlogTable" (void @-> returning string_opt) in
    match get_blog_table () with
    | Some str_json ->
        if str_json = "null" then
            []
        else
            let json = Yojson.Basic.from_string str_json in
            let blogs = List.map json_to_blog (json |> Yojson.Basic.Util.to_list ) in
            blogs
    | None -> []
;;

let get_blog_by_slug slug =
    let get_blog_by_slug = foreign "GetBlogBySlug" (string @-> returning string_opt) in
    match get_blog_by_slug slug with
    | Some str_json ->
        if str_json = "" then
            empty_blog
        else
            let json = Yojson.Basic.from_string str_json in
            json_to_blog json
    | None -> empty_blog
;;
