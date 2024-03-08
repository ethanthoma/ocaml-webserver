module Blogs : sig
    val blogs_cache : Turso.blog list ref

    val update_cache : unit -> unit

    val get_cache : unit -> Turso.blog list
end
