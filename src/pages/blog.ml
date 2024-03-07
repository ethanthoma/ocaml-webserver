let view request =
    let slug = Dream.param request "slug" 
        |> Turso.get_blog_by_slug
    in
    let children = [Components.Blog.component slug] in
    Components.Doc.createElement () ~children
    |> View.to_response
;;

let content request =
    Dream.param request "slug"
    |> Turso.get_blog_by_slug
    |> Components.Blog.component
    |> Components.View.to_response
;;
