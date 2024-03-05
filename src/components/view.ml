let to_string component =
    component
    |> Format.asprintf "%a" (Tyxml.Html.pp_elt ())
;;

let to_response component =
    component
    |> to_string
    |> Dream.html
;;
