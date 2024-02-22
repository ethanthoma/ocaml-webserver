open Opium

let to_response view =
    let body = 
        view
        |> Format.asprintf "%a" (Tyxml.Html.pp ())
        |> Str.global_replace (Str.regexp {|hs=|}) "_="
        |> Body.of_string
    in Response.make ~body ()
    |> Response.set_content_type "text/html; charset=utf-8"
    |> Response.add_header ("Connection", "Keep-Alive")
