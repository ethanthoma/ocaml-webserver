let view request =
    let name = Dream.param request "name" in
    let children = [Components.Blog.component name] in
    Components.Doc.createElement () ~children
    |> View.to_response
;;

let content request =
    Dream.param request "name"
    |> Components.Blog.component
    |> Components.View.to_response
;;
