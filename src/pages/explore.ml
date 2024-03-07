let list_md_files =
    Sys.readdir "./blogs" 
    |> Array.to_list 
    |> List.filter (fun file -> Filename.extension file = ".md")
;;

let blogs = 
    list_md_files 
    |> List.map (fun filename -> 
        let blogs: Components.Blog_cards.blog_metadata = {
            filename = filename;
            title = "blog title";
            description = "descrip";
            tags = ["tag1"; "tag2"];
        } in blogs
    )
;;

let content _ =
    blogs
    |> Components.Blog_cards.component
    |> Components.View.to_response
;;

let view _ = 
    let children = [Components.Blog_cards.component blogs] in
    Components.Doc.createElement () ~children
    |> View.to_response
;;
