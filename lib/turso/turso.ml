let json_payload =
    `Assoc [
        ("requests", `List [
            `Assoc [("type", `String "execute"); ("stmt", `Assoc [("sql", `String "SELECT * FROM blogs")])];
            `Assoc [("type", `String "close")]
        ])
    ] 

open Ctypes
open Foreign

let lib = Dl.dlopen ~filename:"_build/default/lib/turso/dllturso.so"
            ~flags:Dl.[RTLD_NOW; RTLD_GLOBAL]

let () = 
    let init = foreign "Init" (void @-> returning void) ~from:lib in
    init ()

let query_blogs = foreign "QueryBlogs" (void @-> returning string) ~from:lib
