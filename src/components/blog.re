open Tyxml;

let component = (blog: Turso.blog) =>
  <article className="blog-content animate-fade-in">
    <div className="date"> {Html.txt(blog.date)} </div>
    {blog.content |> Omd.of_string |> Omd.to_html |> Html.Unsafe.data}
    <div className="explore-footer">
      <a
        className="call-to-action"
        aria_label="See all the blogs"
        _hx_get="/explore/content"
        _hx_target="main"
        _hx_push_url="/explore"
        _hx_swap="settle:150ms">
        "Explore More"
      </a>
    </div>
  </article>;
