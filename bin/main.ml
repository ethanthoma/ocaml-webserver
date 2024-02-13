open Opium

let get_name_handler _ = Template.mypage |> 
    Response.of_html |> 
    Lwt.return
;;

let _ = 
    App.empty |>
    App.get "/hello/:name" get_name_handler |>
    App.run_command
;;
