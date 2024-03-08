open Tyxml;

let component = (blog: Turso.blog) => 
    <div className="hero animate-fade-in">
        <div className="text">
            <p className="subtitle fancy">"computer science graduate student"</p>
            <h1 className="title">"Ethan Thoma"</h1>
            <p className="description">
                "Studied computer science, data science, and 
                statistics. Focused on ML in NLP, statistical 
                learning, and explainable ML. This is a collection 
                of my thoughts, code, and research..."
            </p>
            <a 
                className="call-to-action" 
                _hx_get={"/explore/content"} 
                _hx_target="main"
                _hx_push_url={"/explore"}
            >
                "Explore"
            </a>
        </div>
      
        <div className="grid">
            <div id="blog-snippet" className="one">
                <a 
                    _hx_get={"/blogs/" ++ blog.filename ++ "/content"} 
                    _hx_target="main"
                    _hx_push_url={"/blogs/" ++ blog.filename}
                >
                    <h2>{Html.txt(blog.title)}</h2>
                    <p>{Html.txt(blog.description)}</p>
                </a>
            </div>
            <div className="spacer two"> </div>
            <div className="spacer three"></div>
            <div id="buy-me-coffee" className="four">
                <a href="https://www.buymeacoffee.com/ethanthoma">
                    <Icon src="./public/svg/bmc-icon.svg" alt="buy me a coffee"/>
                    <p>
                        "Buy me a coffee"
                    </p>
                </a>
            </div>
        </div>
    </div>
