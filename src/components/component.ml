open Opium

let to_string component =
    component
    |> Format.asprintf "%a" (Tyxml.Html.pp_elt ())
    |> Str.global_replace (Str.regexp {|hs=|}) "_="
;;

let to_response component =
    let body = 
        component
        |> to_string
        |> Body.of_string
    in Response.make ~body ()
    |> Response.set_content_type "text/html; charset=utf-8"
    |> Response.add_header ("Connection", "Keep-Alive")
;;
