let title = "Ethan Thoma"
let blog = Cache.Blogs.get_by_slug "how_not_to_build_a_website.md"

let content _ =
    blog
    |> Components.Hero.component
    |> Components.View.to_response ~title
;;

let view _ = 
    let children = [Components.Hero.component blog] in
    Components.Doc.createElement () ~title ~children
    |> View.to_response
;;
