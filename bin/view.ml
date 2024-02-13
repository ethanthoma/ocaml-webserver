open Opium

let make elements =
    let body = 
        List.map
            (fun ele ->
                Format.asprintf "%a" (Tyxml.Html.pp_elt ()) ele
            )
            elements
        |> String.concat "\n"
        |> Body.of_string 
    in Response.make ~body ()
    |> Response.set_content_type "text/html; charset=utf-8"
    |> Response.add_header ("Connection", "Keep-Alive")
