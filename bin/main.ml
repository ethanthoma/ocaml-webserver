open Opium
open Easy_logging

let logger = Logging.make_logger "Route" Debug [Cli Debug]

let log =
    let filter handler (request: Request.t) =
        let () = logger#sdebug request.target in
        handler request
    in Rock.Middleware.create ~filter ~name:"Logger"
;;

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

let _ = 
    let open App in
    empty |>
    get "/" index_handler |>
    middleware log |>
    get "/tab/:num" get_tab_handler |>
    run_command
;; 
