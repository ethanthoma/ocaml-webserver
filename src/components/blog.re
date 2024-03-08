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

        <div className="explore-footer">
            <a 
                className="call-to-action" 
                _hx_get={"/explore/content"} 
                _hx_target="main"
                _hx_push_url={"/explore"}
            >
                "Explore More"
            </a>
        </div>
    </article>

