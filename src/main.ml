open Dream

let get_healthy_handler _ =
    Dream.response ""
    |> Lwt.return
;;

let () = 
    run ~interface:"0.0.0.0" ~port:3000 
    @@ logger
    @@ router [
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
