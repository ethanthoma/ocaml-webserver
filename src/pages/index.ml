let blog: Components.Blog_cards.blog_metadata = {
    filename = "how_not_to_build_a_website.md";
    title = "How Not to Build a Website: Part One";
    description = "How complicated can you make a static site?";
    tags = ["webdev"; "Bazel"];
}

let content _ =
    blog
    |> Components.Hero.component
    |> Components.View.to_response
;;

let view _ = 
    let children = [Components.Hero.component blog] in
    Components.Doc.createElement () ~children
    |> View.to_response
;;
