open Tyxml;

let component = (filename) => {
    let filename = "./blogs/" ++ filename;

    let file_data =
        In_channel.input_all
        |> In_channel.with_open_bin(filename)
    ;

    let blog_content = 
        file_data
        |> Omd.of_string 
        |> Omd.to_html
    ;

    "<article>" ++ blog_content ++ "</article>"
    |> Html.Unsafe.data;
}
