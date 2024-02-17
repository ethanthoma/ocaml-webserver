open Tyxml;

let bar =
    <div id="search-bar">
        <input 
            className="form-control" 
            type_="search"
            name="search" 
            placeholder="Search for blogs..." 
            _hx_post="/search" 
            _hx_trigger="input changed delay:50ms, search" 
            _hx_target="#search-results"
            _hx_on__after_request="this.reset()"
        />
   </div>

let results = <ul id="search-results"></ul>

let component =
    <div id="search">
        bar
        results
    </div>

let row = (filename: string) =>
    <li >
        <button 
            _hx_get={"/blogs/content/" ++ filename} 
            _hx_target="main"
            _hx_push_url={"/blogs/" ++ filename}
        >
            {Html.txt(filename)}
        </button>
    </li>
