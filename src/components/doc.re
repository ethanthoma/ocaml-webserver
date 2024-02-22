open Tyxml;

let createElement = (~children, ()) => {
    let title = Html.txt("Ethan Thoma")

    let htmx = <script src="/public/js/htmx.min.js"></script>
    let hyperscript = <script src="/public/js/_hyperscript.min.js"></script>

    let style = <link rel="stylesheet" href="/public/styles/main.css"/>

    let favicon = <link rel="icon" href="/public/favicon/favicon.ico"/>

    let view =
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title> title </title> 
                htmx
                hyperscript
                style
                favicon
                <link rel="preconnect" href="https://fonts.googleapis.com"/>
                <link rel="preconnect" href="https://fonts.gstatic.com" _crossorigin=""/>
                <link href="https://fonts.googleapis.com/css2?family=Hind:wght@300;400;500;600;700&family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet"/>
            </head>
            <body>
                Header.component
                <main>...children</main>
                <footer>
                    "© 2024 Ethan Thoma and/or his affiliates. All rights reserved."
                </footer>
            </body>
        </html>;

    view;
};
