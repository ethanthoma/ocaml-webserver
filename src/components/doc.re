open Tyxml;

let createElement = (~title: string, ~children, ()) => {
  let description =
    <meta
      name="description"
      content="Ethan Thoma's personal website written in Ocaml using the HOT stack. Blogging and machine learning related."
    />;

  let fonts = <link href="/public/fonts/fonts.css" rel="stylesheet" />;

  let htmx = <script defer="" src="/public/js/htmx@1.9.10.min.js" />;
  let hyperscript =
    <script defer="" src="/public/js/_hyperscript@0.9.12.min.js" />;
  let anti_prime =
    <script async="" src="/public/js/antiThePrimeagen@0.0.2.js" />;

  let style = <link rel="stylesheet" href="/public/styles/main.css" />;

  let favicon = <link rel="icon" href="/public/favicon/favicon.ico" />;

  let view =
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <meta
          name="viewport"
          content="width=device-width, initial-scale=1.0"
        />
        <meta name="htmx-config" content="{\"attributes\":\"hs\"}" />
        <title> {Html.txt(title)} </title>
        description
        fonts
        htmx
        hyperscript
        anti_prime
        style
        favicon
      </head>
      <body>
        Header.component
        <main> ...children </main>
        Footer.component
      </body>
    </html>;

  view;
};
