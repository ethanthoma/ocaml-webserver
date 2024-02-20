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
            <div className="spacer one"> </div>
            <div className="item two">
                <a href="https://www.buymeacoffee.com/ethanthoma">
                    <Icon src="./public/svg/bmc-icon.svg" alt="buy me a coffee"/>
                    <p>
                        "Buy me a coffee"
                    </p>
                </a>
            </div>
            <div className="spacer three"></div>
            <div className="spacer four"></div>
            <div className="item five">
                // should fetch latest blog
                <a href="/blogs/how_not_to_build_a_website.md">
                    <h2>"BLOG TITLE"</h2>
                    <p>
                        "BLOG DESCRIPTION"
                    </p>
                </a>
            </div>
        </div>
    </div>
