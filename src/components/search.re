open Tyxml;

let bar =
    <div id="search-bar">
        <input 
            className="form-control" 
            type_="search"
            autocomplete="off"
            name="search" 
            placeholder="Search for blogs..." 
            _hx_post="/search" 
            _hx_trigger="focus, input changed delay:50ms, search" 
            _hx_target="#search-results-content"
            _hs="
                on focus trigger openSearch on #search-results then
                on blur trigger closeSearch on #search-results 
            "
        />
   </div>

let results = 
    <div 
        id="search-results" 
        className="hidden" 
        _hs="
            on closeSearch add .hidden then
            on openSearch remove .hidden
        ">
        <div className="search-results-underlay" _hs="on click trigger closeSearch"></div>
        <ul 
            id="search-results-content" 
            _hs="
                on focusin trigger openSearch then
                on focusout trigger closeSearch
            ">
        </ul>
    </div>

let component =
    <div id="search">
        bar
        results
    </div>

let row = (filename: string) =>
    <li>
        <button 
            _hx_get={"/blogs/content/" ++ filename} 
            _hx_target="main"
            _hx_push_url={"/blogs/" ++ filename}
        >
            {Html.txt(filename)}
        </button>
    </li>
