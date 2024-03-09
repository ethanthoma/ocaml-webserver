let to_string ?(title="Ethan Thoma") component  =
    let title_str =
        let open Tyxml in
        let title_txt = Html.txt title in
        let title = Html.(title title_txt) in
        Format.asprintf "%a" (Tyxml.Html.pp_elt ()) title
    in
    let str =
        component
        |> Format.asprintf "%a" (Tyxml.Html.pp_elt ())
    in title_str ^ str
;;

let to_response ?(title="Ethan Thoma") component =
    component
    |> to_string ~title
    |> Dream.html
;;
