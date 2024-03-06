open Tyxml;
open Components;


type blog_metadata = {
    url:            string,
    title :         string,
    description :   string,
    tags :          list(string),
}


let blog_card = (blog) => 
    <article className="blog-card">
        <a href=blog.url>
            <h2>{Html.txt(blog.title)}</h2> 
            <p>{Html.txt(blog.description)}</p>
            <ul>
                ...{
                    List.map((tag => <li>{Html.txt(tag)}</li>), blog.tags)
                }
            </ul>
        </a>
    </article>

let view = (blogs) =>
    <Doc>
        <section>
            ...{
                List.map(blog_card, blogs)
            }
        </section>
    </Doc>
