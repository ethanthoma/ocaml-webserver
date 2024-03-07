open Tyxml;

let blog_card = (blog: Turso.blog) => 
    <article className="blog-card">
        <a 
            className="animate border"
            tabindex=0
            _hx_get={"/blogs/" ++ blog.filename ++ "/content"} 
            _hx_target="main"
            _hx_push_url={"/blogs/" ++ blog.filename}
        >
            <h2>{Html.txt(blog.title)}</h2> 
            <p>{Html.txt(blog.description)}</p>
            <ul className="tags">
                ...{
                    List.map((tag => <li className="tag">{Html.txt(tag)}</li>), blog.tags)
                }
            </ul>
            <span>"Read more"</span>
        </a>
    </article>

let component = (blogs) =>
        <section className="blog-section">
            ...{
                List.map(blog_card, blogs)
            }
        </section>
