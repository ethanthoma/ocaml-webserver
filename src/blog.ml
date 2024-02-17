open Fuzzy_search

let list_md_files =
    Sys.readdir "./blogs" 
    |> Array.to_list 
    |> List.filter (fun file -> Filename.extension file = ".md")
;;

let query name =
    Query.create name 
    |> search ~items:list_md_files
;;

let to_string filename =
    let blog_content =
        let filename = "./blogs/" ^ filename in
        In_channel.with_open_bin filename In_channel.input_all 
        |> Omd.of_string 
        |> Omd.to_html
    in "<article>" ^ blog_content ^ "</article>"
;;

let to_response filename =
    let open Opium in
    let body =
        filename 
        |> to_string 
        |> Body.of_string
    in Response.make ~body ()
    |> Response.set_content_type "text/html; charset=utf-8"
    |> Response.add_header ("Connection", "Keep-Alive")
;;
