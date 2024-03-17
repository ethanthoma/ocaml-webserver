let title = "Explore / Ethan Thoma"

let content _ =
    Cache.Blogs.get ()
    |> Components.Blog_cards.component
    |> Components.View.to_response ~title
;;

let view _ = 
    let blogs = Cache.Blogs.get () in
    let children = [Components.Blog_cards.component blogs] in
    Components.Doc.createElement () ~title ~children
    |> View.to_response
;;
