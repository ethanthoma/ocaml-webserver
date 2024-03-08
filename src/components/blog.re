open Tyxml;

let component = (blog: Turso.blog) => 
    <article className="blog-content">
        <div className="date">{Html.txt(blog.date)}</div>
        {
            blog.content
            |> Omd.of_string 
            |> Omd.to_html
            |> Html.Unsafe.data
        }
    </article>

