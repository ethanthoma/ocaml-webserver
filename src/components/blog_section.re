open Tyxml;

let blog_card = (blog: Turso.blog) =>
  <article className="card staggered-load-child" tabindex=0>
    <a
      aria_label=[blog.description]
      _hx_get={"/blogs/" ++ blog.filename ++ "/content"}
      _hx_target="main"
      _hx_push_url={"/blogs/" ++ blog.filename}
      _hx_swap="settle:150ms show:body:top">
      <h2> {Html.txt(blog.title)} </h2>
      <p> {Html.txt(blog.description)} </p>
      <div> {Html.txt(blog.date)} </div>
    </a>
  </article>;

let component = blogs =>
  <section className="blog-section animate-fade-in">
    <header>
      <h2> "My Blogs" </h2>
      <a
        tabindex=0
        _hx_get="/explore/content"
        _hx_target="main"
        _hx_push_url="/explore"
        _hx_swap="settle:150ms">
        "See More"
      </a>
    </header>
    <section className="staggered-load">
      ...{List.map(blog_card, blogs)}
    </section>
  </section>;
