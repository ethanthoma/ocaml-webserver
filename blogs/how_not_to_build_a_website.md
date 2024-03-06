# How not to Build a Website: Part One

##  It's just a Blog

After graduating, I had a bit too much free time. I was applying for grad school
(without much success) and thought maybe I should make a website. Why? Well, all
of the potential supervisors I was cold-emailing had one. Plus, my personal 
project space on my resume was a little too empty. However, there was a small 
issue: I'm not a webdev. My undergrad was entirely focused on machine learning.
My electives were all stats and data-sci. My only webdev experience was being 
forced to make an e-commerce website in Typescript using AWS. All I learnt from 
that is I didn't want to use Typescript or AWS.

### How Complicated Can I Make It

My first time touching anything web related was way (maybe 2017?) back in high
school. At that point I had only programmed in Java but heard webdev was easy so
I thought, why not. Obviously, it didn't go well. I hated using CSS. And like 
all teenage programmers, I made it way too complicated filling every line with 
Javascript. All I remembered was that CSS was confusing and that it was hard to
do much without JS. So in the spirit of over-complicating it, for my personal 
website, I decided to use SCSS.

Why SCSS you may ask? I don't know. For some reason I decided against CSS. But 
the SCSS did work. With a couple files of HTML and SCSS, I cobbled together one
magnificantly (ugly) website. To test it, I just opened the `index.html` from
file explorer (Windows, I know, sorry). Of course you have to **compile** the 
SCSS for that to work. Luckily, I knew just enough Bash to make a simple script...

### A Build Tool, What all Static Sites Need

For SCSS and HTML to be easy to open up statically, I needed to do two things:
1. compile SCSS to CSS and
2. have the CSS and HTML be together.

Obviously, I didn't want my compiled CSS to be in the same directory as my source
code. So I made a Bash script. All it did was create a build dir, copy my HTML, 
and compile my SCSS to CSS. Easy right?

Wrong.

Just simply building wasn't enough (*cough, cough*). I also wanted to change how 
I structured my project. However, at this point, I was hosting it out of an 
S3 bucket (yes, I know, but all I knew was AWS). S3 makes assumptions where the 
`index.html` is and I was too lazy to figure out how to redirect it. 
My solution? A dynamic way to change where my HTML is copied to within the build 
directory. Of course, to make this work, I created a JSON config file:

```json
{
    "main": "html/index.html",
    "root": "./frontend/",
    "scripts": {
        "build": "./bin/build",
    },
    "include": [
        "src/*",
        "vendor"
    ],
    "exclude": [ ]
}
```

Beautiful.

### But Why? Infrastructure as Code

At this point, I could run my site locally and just had to zip and upload to S3
to get it online. However, I wanted to automate the uploading process for reasons
unbeknownst to me. And so, I began my infrastructure as code (IaC) journey.

In my previous experience with AWS, I used something called [AWS CDK](https://aws.amazon.com/cdk/).
This let me create my infrastructure using Typescript. This time, I decided to 
use something called [Pulumi](https://www.pulumi.com/). Pulumi is very similar 
to AWS CDK but it also supports a bunch of languages beyond Typescript. Think of 
it like Terraform but without the struggles of learning some DSL. After 
wigglying about for a couple hours, I eventually got it to upload my build dir 
to S3, setup a CDN, and get Cloudflare to link my domain name to the CDN. All I 
had to do was run `pulumi up` and it was all deployed. 

_Simple, easy, Pulumi ™_.

### Even more Bash

With both the build step and Pulumi, I decided it was time to "upgrade" my 
simple Bash script. How you ask? By adding script tags. This way I can emulate
the perfect, flawless node experience. I created another Bash script that would
recursively search my directories for a `config.json` and let you run any of the
scripts in it. It also lets you call scripts from scripts. I called it `mirai`.
Talk about a dark _mirai_...

```json
{
    "main": "html/index.html",
    "root": "./frontend/",
    "scripts": {
        "build": "./bin/build",
        "deploy": "mirai build && cd infra && aws-admin pulumi up && cd ..",
        "deploy-y": "mirai build && cd infra && aws-admin pulumi up -y && cd .."
    },
    "include": [
        "src/*",
        "vendor"
    ],
    "exclude": [ ]
}
```

Later on I added a way to install libraries by putting URLs into a libs tag.
The config would download the URLs into the vendor directory. I also added a way
to build and run the site as a Docker image using nginx to serve the files.

### This Has to Be Better Than Bash

This was getting complicated, obviously. I had three custom Bash scripts doing 
way too much. Around this time I was switching away from Windows and JetBrains 
IDEs and diving head first into the Linux and Neovim world. I had a new 
philosophy now: use the right tool/language for the right job. On this alone, I 
can write a whole blog post, but instead, I will just say that there is also the 
key idea of keeping things simple. This I found out out the hard way as I went 
further down the rabbit hole: a build system.

As I was getting used to the [Nixos](https://nixos.org/) lifestyle, I watched a 
short presentation on using [Bazel](https://bazel.build/) and Nix flakes. 
Adopting Bazel was not an easy task. I spent about a month learning and 
configuring Bazel. It was complex. But, eventually I got it to re-produce the 
what my Bash scripts did. My thoughts on Bazel? You probably don't 
need it. It's clunky and complex. And, as I was already in the Nix flakes world, 
there were probably much, much easier ways for me to get reproducable and 
[hermetic builds](https://bazel.build/basics/hermeticity) than Bazel.

### Maybe I Need to Design

Through all this, what I made was a complicated build and deployment process. 
What did I not make? A website. The very thing I set out to do. Over three to 
four months all I had to show was a bunch of empty HTML pages with no content.
No blogs, no resume, no nothing. The fundamental issue comes rearing its head: 
there was no plan.

I didn't know **how** to make a website. I still don't _really_ know. I was 
caught in the middle of not knowing if I wanted to [make or learn something](/blogs/to_learn_or_to_do.md).
Because I had no plan, so I went nowhere. It's like running a race without knowing 
the direction. So what did I do then? I scraped it. Sometimes you realize you 
went down the wrong path. It comes down to restarting or fixing it and I think
people get too bogged down in the sunk cost that you want to waste way more time
trying to fix it compared to restarting. Not to say you should always restart 
either. Some devs _always_ try to restart. A new stack or a new language will 
surely make it better, right? There's no golden rule for this. Sometimes, a 
little bit of space and a bit of time and you'll figure it out on your own.

All in all, use the write tool, keep it simple, and, whatever you do, don't make
a custom Bash CLI for a static site.

### This Website

This is a looooong blog. Long for me since it's my first. In the second part, 
I will go over how I made _THIS_ website and the stupid decisions I made along 
the way. [Click here](/blogs/how_to_build_a_website.md) to read about it.
