open Opium
open Easy_logging

let logger = Logging.make_logger "Route" Debug [Cli Debug]

let log =
    let filter handler (request: Request.t) =
        let () = logger#sdebug request.target in
        handler request
    in Rock.Middleware.create ~filter ~name:"Logger"
;;

let get_healthy_handler (_: Request.t) =
    Response.make ()
    |> Response.set_status (`OK)
    |> Lwt.return
;;

let static =
    Middleware.static_unix 
        ~local_path:"./public/" 
        ~uri_prefix:"/public/" ()
;;

let index_handler (_: Request.t) = 
    Pages.Index.view
    |> Pages.View.to_response
    |> Lwt.return
;;

let get_blog_handler (request: Request.t) =
    Router.param request "name"
    |> Pages.Blog.view 
    |> Pages.View.to_response
    |> Lwt.return
;;

let get_blog_content_handler (request: Request.t) =
    Router.param request "name"
    |> Components.Blog.component
    |> Components.View.to_response
    |> Lwt.return
;;

let get_hero_content_handler (_: Request.t) =
    Components.Hero.component
    |> Components.View.to_response
    |> Lwt.return
;;

let _ = 
    let open App in
    empty 
    |> middleware log 
    |> middleware static 
    |> get "/healthy" get_healthy_handler
    |> get "/" index_handler 
    |> get "/search" Search.get_search_handler 
    |> get "/blogs/:name" get_blog_handler 
    |> get "/blogs/content/:name" get_blog_content_handler 
    |> get "/hero/content" get_hero_content_handler 
    |> run_command
;; 
