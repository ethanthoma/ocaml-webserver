# Turso Ocaml-bindings

**NOTE: this library is setup just for my blogs db and is not generic**

This is a simple go-to-c Turso library. The Ocaml code binds via Ctypes and Dune.

Look at cmd/C.go to see how code is exported from the pkg directory. In the 
future, I will probably make this more generic but it is sufficient for now.

If you are wanting to use this code in your own project, you will need to add 
this to your executable stanza for Dune:
```dune
(link_flags -cclib -Wl,--whole-archive -cclib ./lib/turso/libgo_turso.a -cclib -Wl,--no-whole-archive)
```
