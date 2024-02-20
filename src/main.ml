open Opium
open Easy_logging

let logger = Logging.make_logger "Route" Debug [Cli Debug]

let log =
    let filter handler (request: Request.t) =
        let () = logger#sdebug request.target in
        handler request
    in Rock.Middleware.create ~filter ~name:"Logger"
;;

let static =
    Middleware.static_unix 
        ~local_path:"./public/" 
        ~uri_prefix:"/public/" ()
;;

let index_handler _ = 
    Pages.Index.view 
    |> Response.of_html 
    |> Lwt.return
;;

let rec post_search_handler (request: Request.t) =
    let* filename = 
        request 
        |> Request.urlencoded_exn "search"
    in let results =
        if filename = "" then
            []
        else
            List.map Components.Search.row @@ Search.query filename
    in results 
    |> View.make 
    |> Lwt.return
and (let*) = Lwt.bind
;;

let get_blog_handler (request: Request.t) =
    Router.param request "name"
    |> Pages.Blog.view 
    |> Response.of_html 
    |> Lwt.return
;;

let get_blog_content_handler (request: Request.t) =
    Router.param request "name"
    |> Blog.to_response
    |> Lwt.return
;;

let get_healthy_handler _ =
    Response.make ()
    |> Response.set_status (`OK)
    |> Lwt.return
;;

let _ = 
    let open App in
    empty 
    |> middleware log 
    |> middleware static 
    |> get "/healthy" get_healthy_handler
    |> get "/" index_handler 
    |> post "/search" post_search_handler 
    |> get "/blogs/:name" get_blog_handler 
    |> get "/blogs/content/:name" get_blog_content_handler 
    |> run_command
;; 
