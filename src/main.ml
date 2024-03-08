open Dream

let get_healthy_handler _ =
    Dream.response ""
    |> Lwt.return
;;

let robots_loader _root _ _request =
    match Robots.read "robots.txt" with
    | None -> Dream.empty `Not_Found
    | Some asset -> Dream.respond asset
;;

let sitemap_loader _root _ _request =
    match Sitemap.read "sitemap.xml" with
    | None -> Dream.empty `Not_Found
    | Some asset -> Dream.respond asset
;;

let () = 
    run ~interface:"0.0.0.0" ~port:3000 
    @@ logger
    @@ router [
        get "/robots.txt"           @@ static ~loader:robots_loader "";
        get "/sitemap.xml"          @@ static ~loader:sitemap_loader "";
        get "/public/**"            @@ static "./public";
        get "/healthy"              get_healthy_handler;
        get "/"                     Pages.Index.view;
        get "/content"              Pages.Index.content;
        get "/search"               Search.content;
        get "/explore"              Pages.Explore.view;
        get "/explore/content"      Pages.Explore.content;
        get "/blogs/:slug"          Pages.Blog.view;
        get "/blogs/:slug/content"  Pages.Blog.content;
    ]
;; 
