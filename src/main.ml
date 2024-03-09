open Dream

let get_healthy_handler _ =
    Dream.response ""
    |> Lwt.return
;;

let minified_css_loader _root _ _request =
    match Minified_css.read "main.css" with
    | None -> Dream.empty `Not_Found
    | Some asset -> Dream.respond asset
;;

let cache_control (handler: Dream.handler) request  =
    let%lwt response = handler request in
    let seconds = string_of_int @@ 60 * 60 * 24 * 31 in
    Dream.add_header response "Cache-Control" 
    @@ "pubic, max-age="^seconds^", immutable";
    Lwt.return response
;;

let public = [
    get "/public/styles/**" @@ static ~loader:minified_css_loader "";
    get "/public/js/**"     @@ cache_control @@ static "./public/js";
    get "/public/fonts/**"  @@ cache_control @@ static "./public/fonts";
    get "/public/**"        @@ static "./public";
]

let () = 
    run ~interface:"0.0.0.0" ~port:3000 
    @@ logger
    @@ router @@ List.append
        public
        [
            get "/"                     Pages.Index.view;
            get "/"                     @@ static "./public/seo";
            get "/healthy"              get_healthy_handler;
            get "/content"              Pages.Index.content;
            get "/search"               Search.content;
            get "/explore"              Pages.Explore.view;
            get "/explore/content"      Pages.Explore.content;
            get "/blogs/:slug"          Pages.Blog.view;
            get "/blogs/:slug/content"  Pages.Blog.content;
        ]
;; 
