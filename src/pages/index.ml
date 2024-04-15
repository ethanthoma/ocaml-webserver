let title = "Ethan Thoma"

let rec last_three_blogs blogs =
  if List.length blogs < 3 then last_three_blogs (blogs @ [ Turso.empty_blog ])
  else [ List.nth blogs 0; List.nth blogs 1; List.nth blogs 2 ]

let blog_section () =
  let blogs = Cache.Blogs.get () in
  Components.Blog_section.component @@ last_three_blogs blogs

let content _ =
  (let open Tyxml.Html in
   article
     ~a:[ a_class [ "home"; "animate-fade-in" ] ]
     [ Components.Hero.component; blog_section () ])
  |> Components.View.to_response ~title

let view _ =
  let children =
    let open Tyxml.Html in
    [
      article
        ~a:[ a_class [ "home"; "animate-fade-in" ] ]
        [ Components.Hero.component; blog_section () ];
    ]
  in
  Components.Doc.createElement () ~title ~children |> View.to_response
