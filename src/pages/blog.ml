let title (blog: Turso.blog) = blog.title ^ " / Ethan Thoma"

let content request =
    let blog =
        Dream.param request "slug"
        |> Turso.get_blog_by_slug
    in 
    Components.Blog.component blog
    |> Components.View.to_response ~title:(title blog)
;;

let view request =
    let blog = 
        Dream.param request "slug" 
        |> Turso.get_blog_by_slug
    in
    let children = [Components.Blog.component blog] in
    Components.Doc.createElement () ~title:(title blog) ~children
    |> View.to_response
;;
