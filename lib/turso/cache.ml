module Cache = struct
  type 'a t = {
    mutable data : 'a;
    mutable last_updated : float;
    update_function : unit -> 'a;
    max_age : float;
  }

  let needs_update cache =
    let now = Unix.gettimeofday () in
    now -. cache.last_updated > cache.max_age

  let update cache =
    Dream.log "Cache.update: Checking...";
    if needs_update cache then (
      Dream.log "Cache.update: Fetching from DB...";
      let%lwt new_data = Lwt_preemptive.detach cache.update_function () in
      cache.data <- new_data;
      cache.last_updated <- Unix.gettimeofday ();
      Lwt.return_unit)
    else Lwt.return_unit

  let rec schedule_update cache =
    Lwt.bind
      (Lwt_unix.sleep (60. *. 60. *. 24.))
      (fun () ->
        Dream.log "Cache.schedule_update: daily cache fetch";
        let _ = update cache in
        schedule_update cache)

  let get cache =
    let current_data = cache.data in
    let _ = Lwt.async (fun () -> update cache) in
    current_data

  let init ~(update_function : unit -> 'a) ?(max_age : float = 60.) () =
    let cache =
      {
        data = update_function ();
        last_updated = Unix.gettimeofday ();
        update_function;
        max_age;
      }
    in
    let _ = Lwt.async (fun () -> schedule_update cache) in
    cache
end

module Blogs = struct
  let update () =
    Dream.log "Blogs: Updating blog cache...";
    let blogs = Turso.get_blogs () in
    blogs

  let cache = Cache.init ~update_function:update ~max_age:(60. *. 5.) ()
  let cache_by_slug = Hashtbl.create 5

  let update_by_slug slug =
    Dream.log "Blogs: Updating slug cache...";
    Turso.get_blog_by_slug slug

  let get () = Cache.get cache

  let get_by_slug slug =
    try Cache.get (Hashtbl.find cache_by_slug slug)
    with Not_found ->
      let new_cache =
        Cache.init
          ~update_function:(fun () -> update_by_slug slug)
          ~max_age:(60. *. 60.) ()
      in
      Hashtbl.add cache_by_slug slug new_cache;
      Cache.get new_cache
end
