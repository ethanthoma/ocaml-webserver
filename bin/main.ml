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
        ~local_path:"./assets/" 
        ~uri_prefix:"/assets/" ()

let index_handler _ = 
    Index.view |> 
    Response.of_html |> 
    Lwt.return
;;

let get_tab_handler req = 
    let num = Router.param req "num" in
    Tab.view ~num |>
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
    get "/tab/:num" get_tab_handler |>
    post "/search" post_search_handler |>
    get "/blogs/:name" get_blog_handler |>
    run_command
;; 
