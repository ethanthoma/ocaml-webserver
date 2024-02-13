open Opium

let index_handler _ = 
    Index.view |> 
    Response.of_html |> 
    Lwt.return

let get_tab_handler req = 
    let num = Router.param req "num" in
    Tab.view ~num |>
    Lwt.return
;;

let _ = 
    App.empty |>
    App.get "/" index_handler |>
    App.get "/tab/:num" get_tab_handler |>
    App.run_command
;; 
