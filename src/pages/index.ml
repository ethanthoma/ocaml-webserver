let blog = List.hd @@ Turso.get_blogs ()

let content _ =
    blog
    |> Components.Hero.component
    |> Components.View.to_response
;;

let view _ = 
    let children = [Components.Hero.component blog] in
    Components.Doc.createElement () ~children
    |> View.to_response
;;
