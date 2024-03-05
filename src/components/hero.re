open Tyxml;

let component = 
    <div className="hero">
        <div className="text">
            <p className="subtitle fancy">"computer science graduate student"</p>
            <h1 className="title">"Ethan Thoma"</h1>
            <p className="description">
                "Studied computer science, data science, and 
                statistics. Focused on ML in NLP, statistical 
                learning, and explainable ML. This is a collection 
                of my thoughts, code, and research..."
            </p>
            <a className="call_to_action" href="/blogs">"Explore"</a>
        </div>
      
        <div className="grid">
            <div id="blog-snippet" className="one">
                // should fetch latest blog
                <a href="/blogs/how_not_to_build_a_website_part_one.md">
                    <h2>"How Not to Build a Website Part One"</h2>
                    <p>
                        "BLOG DESCRIPTION"
                    </p>
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
