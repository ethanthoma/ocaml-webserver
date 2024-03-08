open Ctypes
open Foreign

let () =
    let init = foreign "Init" (void @-> returning void) in
    init ()
;;

type blog = {
    filename: string;
    title: string;
    description: string;
    content: string;
    tags: string list;
    date: string;
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

let get_blogs unit = 
    let query_blogs = foreign "GetBlogTable" (void @-> returning string) in
    let json = Yojson.Basic.from_string @@ query_blogs unit in
    List.map json_to_blog (json |> Yojson.Basic.Util.to_list )
;;

let get_blog_by_slug slug =
    let query_blog_by_slug = foreign "GetBlogBySlug" (string @-> returning string) in
    let json = Yojson.Basic.from_string @@ query_blog_by_slug slug in
    json_to_blog json
;;
