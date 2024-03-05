# How Not to Build a Website Part One

##  It's Just a Blog

After I graduated and started pursuing my masters, I noticed that most if not
all machine learning faculty had a website. Even more so, a blog. Obviously, as
a self-proclaimed ML scientist myself, I too should have a blog. 

Now, the small issue is that I am not a webdev. In fact, I am barely a dev. I 
spent my whole undergrad taking machine learning courses. I only touched web 
related twice by this point:

- I built a simple backend in typescript to parse zip files of json as a psudo 
db. This was as fun as using any scripting language for a project is. 
- I had to make an ecommerce website (ew) in typescript (ew) using AWS (ew). 

At this point, I knew two things: typescipt/javascript sucks and never use AWS 
CDK because honestly, wtf.

### How Complicated Can I Make It

I may have lied a little when I said I only touched web twice. In high school, 
I tried to make my own website. I thought it'd be a quick and simple exercise.
Now, I'm not sure if you used CSS from 7-ish years ago (2016-17) but that 
experience scarred me. To be fair, that was probably me being a dumb teen more 
than anything but it led me to my first bad decision: SCSS.

Bad, not because SCSS itself is bad. Bad because I started my first frontend 
adventure in 7 years with an abstraction. I could not tell you why SCSS was a 
better fit nor could I even point out what it does better than CSS. All I knew 
was that now I have to run a CLI to run even see my static website...

The good news? I had a functional (but completely ugly) website. All I need now
is to deploy it. Using a dashboard would be too *manual*. I'm a developer. I 
**NEED** to use the latest and greatest, surely.

### Infrastructure as Code: Pulumi

After suffering with AWS CDK I decided there must be alternatives. Luckily for 
me, while I was b*tching about AWS with my friend at the library, some random 
guy came up to us and asked if we were talking about cloud infrastructure. He
recommended an infrastructure as code (IaC) tool called Pulumi. 

I quickly skimmed through the docs and unlike AWS CDK I didn't have to click 
through 4 or 5 different websites only to see I'm reading about the wrong 
version. So, that's what I decided to use. And to be fair, Pulumi is great. 
It took me **a while** to get my S3, Cloudfront, and Cloudflair to all talk 
nicely to each other but I got it to work (I used the terraform-to-pulumi parser 
though). With a simple `pulumi up`, I could easily deploy my code. Boom!

### A Build Tool, What All Static Sites Need

With SCSS and IaC tooling now, it was getting a bit much to get the website from
source to prod. My initial solution involved bash scripts. There comes a point 
where I think anyone can agree that a bash script has gone too far. Clearly, I 
think that point is far, far in the distance cause BOY did I make a bash script.
Not only did it run the build and deploy scripts, I created a JSON config file 
that let me dynamically create scripts to run and a whole host of other 
nonesense:

```json
{
    "main": "html/index.html",
    "root": "./frontend/",
    "scripts": {
        "install": "./bin/install",
        "build": "./bin/build",
        "docker-build": "docker build -t website -f ./docker/Dockerfile .",
        "docker-start": "docker run -d -p 8080:80 -v './dist:/usr/share/nginx/dist' --name website website",
        "start": "mirai docker-build && mirai docker-start",
        "stop": "docker stop website > /dev/null && docker rm website > /dev/null",
        "restart": "mirai stop && mirai start",
        "deploy": "mirai build && cd infra && aws-admin pulumi up && cd ..",
        "deploy-y": "mirai build && cd infra && aws-admin pulumi up -y && cd .."
    },
    "include": [
        "src/*",
        "vendor"
    ],
    "exclude": [
    ],
    "libs": [
        "https://unpkg.com/htmx.org@1.9.3/dist/htmx.min.js",
        "https://unpkg.com/htmx.org/dist/ext/class-tools.js",
        "https://unpkg.com/hyperscript.org@0.9.9"
    ]
}
```

The bash script would parse this config.json, figure out what to copy to build,
parse the SCSS, download libs, etc, etc. I even went as far as making it into 
its own CLI sourced from my .bashrc. I left the world of typescipt just to 
remake their tools.

### This Has to Be Better Than Bash

This was getting complicated. The reason? I wanted templated HTML. HTMX was the 
"new" craze that my site needed. So I opted to redo all my build stuff into the
**industry standard** Bazel.

Adopting Bazel was not an easy task. It is a Google-made build tool. Nowadays,
that probably doesn't inspire much confidence but I thought I would like to try 
something new and works with multiple languages. At this point, my IaC is in Go,
my frontend is HTML and SCSS, and for templating I was probably going with Go as
well.

I spent about a month learning and configuring Bazel and eventually got it to 
re-produce my previous bash scripts (maybe bash isn't so bad). With all my tools
set-up, I can finally make a proper blog / personal website.

### Maybe I Need to Design

So far, all I have done is the classic: avoid the stuff that's hard or that you 
don't know or is tedious. I still don't have a website. No blogs, no resume, no
nothing. The fundamental issue comes rearing its head: there was no plan.

I didn't know **how** to make a website. There was no, do this and this and this
and voila, a product. It was half learning new stuff and half building things. 
This just doesn't work. If you want to build something, BUILD it. If you want to
learn something LEARN it. My mistake was simple. I wanted to learn and build but
never did one or the either. Projects can be and generally are a combination of
both. Learning is fun. Learning to use Pulumi and Bazel and monsterous bash was 
fun. What it wasn't is making a website. And at the end of the day, what I 
actually wanted was a website.

So I scraped it. Simpily as that. What I made was an exercise of learning. I 
think too many people fall into the issue of redoing or fixing. The sunk cost
fallacy hits deep and after spending hours upon hours, we feel a tinge in the
heart when our project needs to be put down. It was really was just "what is it
supposed to be/do and what is it currently being/doing."

### This Website

This blog is getting way too long. In the next part, I will go over how *THIS* 
website came to be. Click [here](/blogs/how_not_to_build_a_website_part_two.md) 
to read about it.
