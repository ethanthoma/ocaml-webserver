let title = "Ethan Thoma"
let slug = "how_not_to_build_a_website.md"
let _ = Cache.Blogs.get ();;

slug |> Cache.Blogs.get_by_slug

let content _ =
  slug |> Cache.Blogs.get_by_slug |> Components.Hero.component
  |> Components.View.to_response ~title

let view _ =
  let blog = Cache.Blogs.get_by_slug slug in
  let children = [ Components.Hero.component blog ] in
  Components.Doc.createElement () ~title ~children |> View.to_response
