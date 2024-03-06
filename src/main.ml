open Dream

let get_healthy_handler _ =
    Dream.response ""
    |> Lwt.return
;;

let index_handler _ = 
    Pages.Index.view
    |> Pages.View.to_response
;;

let get_blogs_handler _ = 
    Search.list_md_files 
    |> List.map (fun filename -> 
        let open Pages.Blogs in {
            url = filename;
            title = "blog title";
            description = "descrip";
            tags = ["tag1"; "tag2"];
        }
    )
    |> Pages.Blogs.view
    |> Pages.View.to_response
;;

let get_blog_handler request =
    Dream.param request "name"
    |> Pages.Blog.view 
    |> Pages.View.to_response
;;

let get_blog_content_handler request =
    Dream.param request "name"
    |> Components.Blog.component
    |> Components.View.to_response
;;

let get_hero_content_handler _ =
    Components.Hero.component
    |> Components.View.to_response
;;

let () = 
    run ~port:3000
    @@ logger
    @@ router [
        get "/public/**" @@ static "./public";
        get "/healthy" get_healthy_handler;
        get "/" index_handler;
        get "/search" Search.get_search_handler;
        get "/blogs" get_blogs_handler;
        get "/blogs/:name" get_blog_handler;
        get "/blogs/content/:name" get_blog_content_handler;
        get "/hero/content" get_hero_content_handler;
    ]
;; 
