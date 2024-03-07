let list_md_files =
    Sys.readdir "./blogs" 
    |> Array.to_list 
    |> List.filter (fun file -> Filename.extension file = ".md")
;;

let blogs = Turso.get_blogs () 

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
