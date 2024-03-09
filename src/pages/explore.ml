let title = "Explore / Ethan Thoma"

let content _ =
    Cache.Blogs.update_cache ();
    Cache.Blogs.get_cache ()
    |> Components.Blog_cards.component
    |> Components.View.to_response ~title
;;

let view _ = 
    Cache.Blogs.update_cache ();
    let blogs = Cache.Blogs.get_cache () in
    let children = [Components.Blog_cards.component blogs] in
    Components.Doc.createElement () ~title ~children
    |> View.to_response
;;
