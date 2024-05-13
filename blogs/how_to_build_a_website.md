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

At this point, my blogs were stored in markdown files. Technically, they still 
are. However, I still need metadata like a title or short description or the 
date and so on. I first tried to add it as a markdown comment and parse it but
writing a custom parser was _too much_ work... maybe? I don't know, I decided 
somehow that using a database would be easier...

I happend upon this [ThePrimeagen
tweet](https://twitter.com/ThePrimeagen/status/1686482867809894400) (and maybe a
couple of his YouTube videos). I decided to use [Turso](https://turso.tech/) 
which is a banger database service with a great free tier. I signed in with 
GitHub, setup my one db according to their guide, and piped a simple SQL file to
the CLI to store my first markdown blog (with a little bit of quote escaping and
all that jazz).

### When You Knew You Went to far

Getting blogs to Turso was pretty eh. I parse the markdown with some escaping 
via bash and then pipe it into the CLI... I am sure I can make a better script 
but it works for now. The much more exciting part is getting my site to read 
from the db. There was one, single minor problem.

Turso doesn't have an Ocaml SDK.

In fact, there wasn't even an SDK for SQLite. So what to do? Well, there is a Go
SDK...and Ocaml can read C code...and you can compile Go to C...

Writing Go is pretty easy and so was using the Turso SDK. I wrote a little bit 
like

```Go
var DB *sql.DB

func Init(database string, token string) {
    url := fmt.Sprintf("libsql://%s.turso.io?authToken=%s", database, token)

    var err error
    DB, err = sql.Open("libsql", url)
    if err != nil {
        fmt.Fprintf(os.Stderr, "failed to open db %s: %s", url, err)
        os.Exit(1)
    }
}
```

This just makes a connection to Turso in Go. Next, I needed to actually read the
contents:

```Go
func GetBlogTable() (string, error) {
    rows, err := db.DB.Query(`
        SELECT
            *
        FROM
            blogs
        ORDER BY
            date
        DESC;
    `)
    if err != nil {
        return "", err
    }
    defer rows.Close()

    blogs, err := rowsToBlogs(rows)
    if err != nil {
        return "", err
    }

    jsonBlogs, err := json.Marshal(blogs)
    if err != nil {
        return "", err
    }

    return string(jsonBlogs), nil
}
```

Now I can read the blog contents. You'll notice that I return the blogs not as a
struct as `rowsToBlogs` makes but rather as a JSON string. Why? Well, the Go to 
C compiler only supports primitives, not custom structs. This means I can only
return a string from my Go code and the structure of JSON is a pretty managable 
way to do this. I could use a binary encoding but if I was going to make the 
fastest server I would've just used C and [emscripten](https://emscripten.org/).

Next, I expose it all via comments so the compiler knows what to expose on the C
side:

```Go
// #cgo CFLAGS: -fpic
import "C"

var database    = os.Getenv("TURSO_DATABASE")
var token       = os.Getenv("TURSO_DATABASE_TOKEN")

//export Init
func Init() {
    db.Init(database, token)
}

//export GetBlogTable
func GetBlogTable() *C.char {
    blogs, err := blog.GetBlogTable()
    if err != nil {
        fmt.Println("tb error")
        return nil
    }
    return C.CString(blogs)
}
```

And voila! Easy, right?

### How to Climb a Dune

As you may or may not know, Ocaml typcially uses Dune for compilation. And so do
I. My task now is to
- get Dune to compile my Go code to C
- get Dune to link my C code
- call the linked C code from Ocaml

Getting Dune to work, however, sucked. It sucked a lot. Maybe I'm not "one with 
the docs" but it was hard to understand and took me like a week to piece 
together enough forum posts to get it to work. My final Dune file looks like 

```lisp
(library
 (name turso)
 (public_name webserver.turso)
 (foreign_archives go_turso)
 (libraries ctypes ctypes.foreign yojson dream)
 (preprocess
  (pps lwt_ppx))
 (flags
  (:standard -w -49))
 (wrapped false)
 (library_flags
  (-cclib -lgo_turso)))

(rule
 (deps
  (source_tree .))
 (targets libgo_turso.a dllgo_turso.so libgo_turso.h)
 (action
  (no-infer
   (ignore-stdout
    (progn
     (run make))))))

(env
 (utop
  (env-vars
   (OCAML_INTEROP_NO_CAML_STARTUP true))))
```

In the first part I compile my Ocaml code that interacts with the C code. I use
Ctypes which was really simple:

```Ocaml
open Ctypes
open Foreign

let () =
  let init = foreign "Init" (void @-> returning void) in
  init ()

let get_blogs () =
  let get_blog_table = foreign "GetBlogTable" (void @-> returning string) in
  ...
```

For compiling the Go code, I have a simple Dune rule that runs my `Makefile` 
which is pretty simple:

```make
.PHONY: build

build:
	go build -o dllgo_turso.so -buildmode=c-shared -mod=vendor ./cmd/
	go build -o libgo_turso.a -buildmode=c-archive -mod=vendor ./cmd/
```

My main Dune file in my source also was modified:

```lisp
(executable
 ...
 (link_flags
  -cclib
  -Wl,--whole-archive
  -cclib
  ./lib/turso/libgo_turso.a
  -cclib
  -Wl,--no-whole-archive))
```

And that's about it. So easy...right???

### Piecing it All Together

The fun part is done now, all that's left is getting it to compile without the 
fun complexity of setting up Opam and switches and Dune and and and. Of course,
this means getting Nix all set up. I used 
(opam-nix)[https://github.com/tweag/opam-nix] to compile my derivation. It's a 
little bit annoying as I have to set every dependency in the flake but it works.

Then I throw that into a Docker image which I also make with Nix. Badabing 
badaboom, I can now run my "simple" website as a Docker image. Luckily, 
[Render](https://render.com/) supports loading from Docker images. Unfortunately,
I need to get it published to a container registry. And so, time to make a 
GitHub workflow that runs my flake to create my image and publish it to the 
GitHub container registry. Once that's finished, it triggers deployment to 
Render via an API link.

Now, everytime I push to main, it compiles my derivation, throws it into an 
image, saves to the registry, and deploys it to the Render server. Clearly not
overcomplicated. I definitely don't recommend this exact stack for your website
but I did learn a lot.

Ocaml is maybe not mature enough in the server/client side for a website. I was
originally going to use a web client and the 
[Hrana spec](https://docs.turso.tech/sdk/http/reference) for Turso but I just 
couldn't get it to work. Given enough time, a fully Ocaml (no Go/C) version is 
possible and probably much easier to configure. To be honest, I don't know what
you **should** do and I don't know if there ever is a should for a personal 
website. What I do know is that Typescript sucks to use and I rather use C than
JS or TS. 

All I can say is, do what's fun and what you want to learn. There's always stuff
you have to do and code you have to write. Why not branch out and learn a new 
language and technology and library and so on. You will never be the 10x dev if
you stay in your comforts. Your comfort zone is your world of comfort, why 
settle for a small world.
