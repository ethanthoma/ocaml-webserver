open Tyxml

let to_string page =
    page
    |> Format.asprintf "%a" (Tyxml.Html.pp ())
;;
