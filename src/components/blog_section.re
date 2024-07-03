open Tyxml;

let blog_card = (blog: Turso.blog) =>
  <article className="card staggered-load-child">
    <a
      aria_label=[blog.description]
      href={"/blogs/" ++ blog.filename}
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
      <h2> "Latest Blogs" </h2>
      <a
        href="/explore"
        _hx_get="/explore/content"
        _hx_target="main"
        _hx_push_url="/explore"
        _hx_swap="settle:150ms show:body:top">
        "See All"
      </a>
    </header>
    <section className="staggered-load">
      ...{List.map(blog_card, blogs)}
    </section>
  </section>;
