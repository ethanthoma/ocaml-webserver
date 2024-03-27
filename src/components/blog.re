open Tyxml;

let component = (blog: Turso.blog) =>
  <article className="blog-content animate-fade-in">
    <div className="date"> {Html.txt(blog.date)} </div>
    {blog.content |> Omd.of_string |> Omd.to_html |> Html.Unsafe.data}
    <div className="explore-footer"> <Call_to_action /> </div>
  </article>;
