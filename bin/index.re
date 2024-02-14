open Tyxml;

let my_title = Html.txt("A Fabulous Web Page");

let htmx = <script src="https://unpkg.com/htmx.org@1.9.10"></script>

let view =
    <html>
        <head> 
            htmx
            <title> my_title </title> 
        </head>
        <body> 
            <div id="tabs" _hx_get="/tab/1" _hx_trigger="load delay:100ms" _hx_target="#tabs" _hx_swap="innerHTML"></div>
        </body>
    </html>;
