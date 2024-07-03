# How to Build a Website: Part Two
 
To read about the first part, [click here](/blogs/how_not_to_build_a_website.md).
 
## The Dare
 
All good projects probably started with a dare. In the middle of February, I
started exploring the cool, little language of [OCaml](https://ocaml.org/). I
wanted to make a video game using [raylib](https://www.raylib.com/), a simple
graphics library that [Tsoding](https://twitter.com/tsoding) and
[Teej](https://twitter.com/teej_dv?lang=en) have used it in their projects.
Surprisingly, learning 3D graphics for the first time is not easy...
 
Around this time, one of my friends decided to make themselves their own
personal website. Unlike me, they actually knew *how* and *what* to do. They
had this thing that I didn't have called **design**. Amazing. I told them, 
 
> hey, why not make it in Ocaml/reasonml
 
And so started their very, very short journey into OCaml where they learned how
great using [opam](https://opam.ocaml.org/) and [nix](https://nixos.org/) is.
Like any rational person, they decided to not learn how to use opam, nix,
OCaml, reasonml, dune, TYXML, etc. for their website and went with a much less
thorny path. Unfortunately for me, I'm dumb enough to suffer to see if I *can*
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
classic. Unfortunately, opam-nix rebuilds everything so using it as a shell
isn't really practical so (like I did) just make your own quick opam 
environment.
 
### Now _This_ is How You Make a Blog
 
A static webpage isn't really exciting enough or exactly modern. I want to at
least pretend to future employers that I know what I'm doing. So, time for a 
little bit of reactivity. How? Everyone's favourite
 
**htmx**
 
[Htmx](https://htmx.org/) is a JS library that lets you make requests through
HTML tags instead of writing JS to do anything useful. Htmx is pretty easy and
fun to use. Everytime I try to read React code, it just looks like some DSL
that overcomplicates things. Maybe I'm wrong. Maybe not. I don't do frontend so
it doesn't matter.
 
Awesomely, the htmx website comes with a host of examples solutions to common
patterns. The search bar at that top for example, was a initially a straight
copy of the htmx example. Getting it to work in TYXML, was another issue.
TYXML's jsx preprocessor for reasonml is what I used for my HTML fragments.
It's pretty easy to use (besides figuring out dune and opam). I don't try
to do anything fancy. Others have gone wild with
[tetris](https://github.com/cptknx/tetris), for example. Maybe not the best use
case but neither is are half the technologies I use in this blog.
 
### The HOT Stack: HTMX Ocaml Turso
 
My blogs are stored in markdown files. I agree with the philosophy of storing it
as plain text. Only issue is plane text is too plain. I still need metadata like 
a title or short description or the date and so on. 

My first feeble attempt was storing it as a markdown comment but parsing and all 
that jazz made me bored and honestly felt like I could shove another technology
into this blog instead. And so, I happened upon this [ThePrimeagen 
tweet](https://twitter.com/ThePrimeagen/status/1686482867809894400) and decided 
to use [Turso](https://turso.tech/). Turso is a banger database service with a 
great free tier. A couple of steps later I had a blogs table and was ready to 
go. All that's left was actually fetching from the db.

### When You Knew You Went to far
 
Getting blogs to Turso was pretty eh. I parse the markdown with some escaping 
via bash and then pipe it into the CLI... I am sure I can make a better script 
but it works for now. The much more exciting part is getting my site to read 
from the db. There was one, single minor problem.
 
Turso doesn't have an Ocaml SDK.
 
In fact, there wasn't even an SDK for SQLite. So what to do? Well, there is a Go
SDK...and Ocaml can read C code...and you can compile Go to C...
 
Writing Go is almost always pretty easy and so was using the Turso SDK. A couple
Go functions that connect to the db and read my blogs for me. Only slightly 
annoying part is that I can't return a custom Go struct since the Go to C 
compiler only supports primitives, not custom structs. Easily solved by turning 
it into a C string. I'm sure there are better/faster ways to do all this but if 
I was going to make the fastest server I would've just used C and 
[emscripten](https://emscripten.org/).
 
### How to Climb a Dune
 
As you may or may not know, Ocaml typically uses Dune for compilation. And so do
I. My task now is to
- get Dune to compile my Go code to C
- get Dune to link my C code
- call the linked C code from Ocaml
 
Getting Dune to work, however, sucked. It sucked a lot. Maybe I'm not "one with 
the docs" but it was hard to understand and took me like a week to piece 
together enough forum posts to get it to work. In the end, there are two parts I
needed to do.

The first thing I had to do was get Dune to compile my Go code. This was easy 
enough using a Makefile and calling it from dune. I could bind the "C" functions
using the Ocaml ctypes library which made it nice and easy. My dune file gives 
me an .a, .so, and a .h file for linking. I then export the Ocaml bindings as a
library for use in my application.

Speaking of the main application, I also have to link the "C library" to it. To 
be quite honest, I never done linking in C as I just did everything in giant C 
file for one off tasks so it could all be a mess but it works so who cares. And 
that's about it. 
 
### Piecing it All Together

As I mentioned before, I am using opam-nix. I use this to run my dune project 
and produce a derivation/binary I can run. To run it, I opted to just throw it 
in a Docker image (also produce by nix). Luckily, the cloud provider that was I
planning to use, [Render](https://render.com/), supports loading from Docker 
images. A couple (many) steps later, my GitHub workflow compiles my site and it
gets deployed automagically (sadly I had to make the magic). Clearly not an 
overcomplicated approach at all. I definitely don't recommend this exact stack 
for your website but I did learn a lot.
 
Ocaml is maybe not mature enough on the server/client side for a website. I was
originally going to use a web client and the 
[Hrana spec](https://docs.turso.tech/sdk/http/reference) for Turso but I just 
couldn't get it to work. Given enough time, a fully Ocaml (no Go/C) version is 
possible and probably much easier to configure. To be honest, I don't know what
you **should** do and I don't know if there ever is a should for a personal 
website. What I do know is that Typescript sucks to use and I rather do all this
random, complicated stuff than JS or TS. 
 
All I can say is, do what's fun and what you want to learn. There's always stuff
you have to do and code you have to write. Why not branch out and learn a new 
language, technology, library and so on. You will never be the 10x dev if
you stay in your comforts. Your comfort zone is your world of comfort, why 
settle for a small world.
