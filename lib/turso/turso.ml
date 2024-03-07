open Ctypes
open Foreign

let () =
    let init = foreign "Init" (void @-> returning void) in
    init ()

let query_blogs = foreign "QueryBlogs" (void @-> returning string)
