# How to Build a Website: Part Two

To read about the first part, [click here](/blogs/how_not_to_build_a_website.md).

## The Dare

All good projects probably started with a dare. In the middle of Feburary, I
started exploring the cool, little language of [OCaml](https://ocaml.org/). I
wanted to make a video game using [raylib](https://www.raylib.com/), a simple
graphics library that [Tsoding](https://twitter.com/tsoding) and
[Teej](https://twitter.com/teej_dv?lang=en) have used in their projects.
Surprisingly, learning 3D graphics for the first time is not easy...

Around this time, one of my friends decided to make themselves their own
personal website. Unlike me, they actually knew *how* and *what* to do. They
had this thing that I didn't have called **design**. Amazing. I told them, 

> hey, why not make it in Ocaml/reasonml

And so started their very, very short journey into OCaml where they learned how
great using [opam](https://opam.ocaml.org/) and [nix](https://nixos.org/) is.
Like any rational person, they decided to not learn how to use opam, nix,
OCaml, reasonml, dune, TYXML, etc. for their website and went with a much less
thorny path. Unfortunetly for me, I'm dumb enough to suffer to see if I *can*
do it. So I did.

### I Like Opium

The first iteration of the website you see today started with the Ocaml Opium
library. To be honest, it's pretty great. It is super simple, doesn't try to do
too much, and I get to opt into anything else I want. Setting up a router was
really just

```ocaml
open Opium

let get_name_handler _ = 
    Template.mypage |> 
    Response.of_html |> 
    Lwt.return

let _ = 
    App.empty |> 
    App.get "/hello/:name" get_name_handler |> 
    App.run_command 
```

```reasonml
open Tyxml;

let mycontent =
  <div className="content">
    <h1> "A fabulous title" </h1>
    "This is a fabulous content."
  </div>;

let mytitle = Html.txt("A Fabulous Web Page");

let mypage =
  <html>
    <head> <title> mytitle </title> </head>
    <body> mycontent </body>
  </html>;
```

And that's how my first iteration came to be. Pretty simple, pretty readable.
The darkside of this though, was, of course, opam, dune, and nix. Getting any
of these to work together is never going to be easy out the gate. I opted to
use [opam-nix](https://www.tweag.io/blog/2023-02-16-opam-nix/), another Tweag
classic. Unfortunetly, opam-nix rebuilds everything so using it as a shell
isn't really practical.

Instead, I crafted my own environment which required me to install Opam and all
my project dependencies. This obviously took a lot of tweaking but eventually I
got it to work. I'd say it's nix fault but it's probably opam's fault since
it's always opam's fault.

### Now _This_ is How You Make a Blog

A static webpage isn't really exciting enough. Not for the solid one day of
work I put into it. Next, is reactivity. How? Everyone's favourite

**HTMX**

[Htmx](https://htmx.org/) is a JS library that lets you make requests through
HTML tags instead of writing JS to do anything useful. Htmx is pretty easy and
fun to use. Everytime I try to read React code, it just looks like some DSL
that overcomplicates things. Maybe I'm wrong. Maybe not. I don't do frontend so
it doesn't matter.

Awesomely, the htmx website comes with a host of examples solutions to common
patterns. The search bar at that top for example, was a initially a straight
copy of the htmx example. Getting it to work in TYXML, was another issue.
TYXML's jsx preprocessor for reasonml is what I used for my HTML fragments.
It's pretty easy to use (besides figuring out dune and opam). An example for my
`call_to_action.re` is

```re
open Tyxml;

let createElement = () => {
  <a
    className="call-to-action"
    aria_label="See all the blogs"
    tabindex="0"
    _hx_get="/explore/content"
    _hx_target="main"
    _hx_push_url="/explore"
    _hx_swap="settle:150ms">
    "Explore More"
  </a>;
};
```

This creates a simple button element. I use the `hx-get` which tells the htmx
library to fetch the content from the endpoint, `hx-target` says to place the
content received into, `hx-push-url` says to update the URL at the top of the
screen, and `hx-swap` element says to wait 150ms before settling. I don't try
to do anything fancy. Others have gone wild with
[tetris](https://github.com/cptknx/tetris), for example. Maybe not the best use
case...

### The HOT Stack: HTMX Ocaml Turso

At this point, my blogs were stored in markdown files. This was perfect, for
ease, but sucks for things like metadata. This of course _requires_ a database.

Running with [ThePrimeagen
tweet](https://twitter.com/ThePrimeagen/status/1686482867809894400), I decided
to use [Turso](https://turso.tech/).

### When You Knew You Went to far


