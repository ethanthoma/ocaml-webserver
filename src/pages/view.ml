let to_string page =
    page
    |> Format.asprintf "%a" (Tyxml.Html.pp ())
;;

let to_response page =
    page
    |> to_string
    |> Dream.html
;;
