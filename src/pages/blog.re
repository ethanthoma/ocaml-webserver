open Tyxml;
open Components;

let to_string = (filename) => {
    let filename = "./blogs/" ++ filename;
    let blog_content =
        In_channel.with_open_bin(filename, In_channel.input_all) 
            |>Omd.of_string 
            |>Omd.to_html
    ;

    "<article>" ++ blog_content ++ "</article>";
}

let view = (filename) =>
    <Doc>
            {
                try(Html.Unsafe.data(to_string(filename))) {
                    | Not_found => Html.txt("")
                };
            }
    </Doc>
