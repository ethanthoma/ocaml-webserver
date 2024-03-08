module Blogs = struct
    open Turso

    let blogs_cache: blog list ref = ref @@ get_blogs ()

    let update_cache () =
        let blogs = get_blogs () in
        blogs_cache := blogs

    let get_cache () =
        !blogs_cache
end

