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
    content     = "# Not Yet Released\n\nPlease try again in the future!";
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
    let get_blog_table = foreign "GetBlogTable" (void @-> returning string) in
    let json = 
        let str_json = get_blog_table () in
        if str_json <> "" then
            Some (Yojson.Basic.from_string str_json)
        else
            None
    in match json with
    | Some json -> begin
        let list_opt = 
            Yojson.Basic.Util.to_option Yojson.Basic.Util.to_list json
        in match list_opt with 
        | Some list -> List.map json_to_blog list
        | None -> []
        end
    | None -> []
;;

let get_blog_by_slug slug =
    let get_blog_by_slug = foreign "GetBlogBySlug" (string @-> returning string) in
    let json = 
        let str_json = get_blog_by_slug slug in
        if str_json <> "" then
            Some (Yojson.Basic.from_string str_json)
        else
            None
    in match json with
    | Some json -> json_to_blog json
    | None -> empty_blog
;;
