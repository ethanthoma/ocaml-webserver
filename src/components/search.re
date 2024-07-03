open Tyxml;

let bar =
  <div id="search-bar">
    <label className="hidden" _for="search"> "Search for blogs..." </label>
    <input
      className="form-control outline"
      type_="search"
      autocomplete="off"
      name="search"
      placeholder="Search for blogs..."
      _hx_get="/search/content"
      _hx_include="this"
      _hx_trigger="focus, input changed delay:50ms, search"
      _hx_target="#search-results-content"
      _hs="
                on focus trigger openSearch on #search-results then
                on blur trigger closeSearch on #search-results
            "
    />
  </div>;

let results =
  <div
    id="search-results"
    className="hidden"
    _hs="
            on closeSearch add .hidden then
            on openSearch remove .hidden
        ">
    <ul
      id="search-results-content"
      _hs="
                on focusin trigger openSearch then
                on focusout trigger closeSearch
            "
    />
  </div>;

let component = <div id="search"> bar results </div>;

let row = (blog: Turso.blog) =>
  <li>
    <button
      className="border"
      _hx_get={"/blogs/" ++ blog.filename ++ "/content"}
      _hx_target="main"
      _hx_swap="settle:150ms show:body:top"
      _hx_push_url={"/blogs/" ++ blog.filename}
      _hs="on click trigger closeSearch on #search-results">
      {Html.txt(blog.title)}
    </button>
  </li>;
