module Blogs : sig
  val get : unit -> Turso.blog list
  val get_by_slug : string -> Turso.blog
end
