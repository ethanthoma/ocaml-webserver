open Opium
open Easy_logging
open Components

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

let index_handler _ = 
    Index.view |> 
    Response.of_html |> 
    Lwt.return
;;

let post_search_handler (request: Request.t) =
    Lwt.bind
        (request |> Request.urlencoded_exn "search")
    @@
    fun query -> 
    query |>
    Search.view |>
    Lwt.return
;;

let get_blog_handler (request: Request.t) =
    let body =
        let name = Router.param request "name" in
        let blog_content = 
            "<main>" ^ Blog.to_string name  ^ "</main>"
        in
        Index.view |>
        Format.asprintf "%a" (Tyxml.Html.pp ()) |>
        Str.replace_first (Str.regexp {|<main></main>|}) blog_content |> 
        Body.of_string
    in Response.make ~body () |>
    Response.set_content_type "text/html; charset=utf-8" |>
    Response.add_header ("Connection", "Keep-Alive") |>
    Lwt.return
;;

let get_blog_content_handler (request: Request.t) =
    let name = Router.param request "name" in
    Blog.to_response name |>
    Lwt.return
;;

let _ = 
    let open App in
    empty |>
    middleware log |>
    middleware static |>
    get "/" index_handler |>
    get "/blogs/:name" get_blog_handler |>
    post "/search" post_search_handler |>
    get "/blogs/content/:name" get_blog_content_handler |>
    run_command
;; 
