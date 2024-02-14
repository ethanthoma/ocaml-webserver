open Tyxml;

let my_title = Html.txt("A Fabulous Web Page");

let htmx = <script src="https://unpkg.com/htmx.org@1.9.10"></script>

let search_bar =
    <div>
        <h3> 
            "Search Contacts"
            <span className="htmx-indicator"> 
                <img src="/assets/img/bars.svg" alt=""/>
                "Searching..."
            </span> 
        </h3>
        <input 
            className="form-control" 
            name="search" 
            placeholder="Begin Typing To Search Users..." 
            _hx_post="/search" 
            _hx_trigger="input changed delay:50ms, search" 
            _hx_target="#search-results" 
            _hx_indicator=".htmx-indicator"/>
   </div>

let nav_bar = <div id="tabs" _hx_get="/tab/1" _hx_trigger="load delay:100ms" _hx_target="#tabs" _hx_swap="innerHTML"></div>

let view =
    <html>
        <head> 
            htmx
            <title> my_title </title> 
            <link rel="icon" href="/assets/favicon/favicon.ico"/>
        </head>
        <body> 
            search_bar
            nav_bar
            <table className="table">
                <thead>
                    <tr>
                        <th>"Entries"</th>
                    </tr>
                </thead>
                    <tbody id="search-results">
                </tbody>
            </table>
        </body>
    </html>;
