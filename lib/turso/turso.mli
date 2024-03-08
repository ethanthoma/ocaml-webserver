type blog = {
    filename:       string;
    title:          string;
    description:    string;
    content:        string;
    tags:           string list;
    date:           string;
}

val get_blogs : unit -> blog list

val get_blog_by_slug : string -> blog
