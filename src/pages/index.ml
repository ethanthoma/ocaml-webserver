let blog = Turso.get_blog_by_slug "how_not_to_build_a_website.md"

let content _ =
    Cache.Blogs.update_cache ();
    blog
    |> Components.Hero.component
    |> Components.View.to_response
;;

let view _ = 
    Cache.Blogs.update_cache ();
    let children = [Components.Hero.component blog] in
    Components.Doc.createElement () ~children
    |> View.to_response
;;