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
        get "/blogs/:name"          Pages.Blog.view;
        get "/blogs/:name/content"  Pages.Blog.content;
        get "/turso"                (fun _ ->
            let json = Turso.query_blogs () in
            print_endline json;
            Dream.json json
        )
    ]
;; 
