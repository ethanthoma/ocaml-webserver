open Tyxml;

let my_title = Html.txt("A Fabulous Web Page");

let htmx = <script src="https://unpkg.com/htmx.org@1.9.10"></script>

let nav_bar = <div id="tabs" _hx_get="/tab/1" _hx_trigger="load delay:100ms" _hx_target="#tabs" _hx_swap="innerHTML"></div>

let view =
    <html>
        <head> 
            htmx
            <title> my_title </title> 
            <link rel="icon" href="/assets/favicon/favicon.ico"/>
        </head>
        <body> 
            Search.bar
            nav_bar
            Search.results
        </body>
    </html>;
