open Tyxml;

let component = (blog: Turso.blog) => {
    print_endline(blog.content);
    let filename = "./blogs/" ++ blog.filename;

    let file_data =
        In_channel.input_all
        |> In_channel.with_open_bin(filename)
    ;

    print_endline(file_data);

    let blog_content = 
        blog.content
        |> Omd.of_string 
        |> Omd.to_html
    ;

    "<article class=\"blog-content\">" ++ blog_content ++ "</article>"
    |> Html.Unsafe.data;
}
