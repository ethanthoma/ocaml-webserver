open Tyxml;

let bar =
    <div>
        <h3> 
            "Search Contacts"
            <span className="htmx-indicator"> 
                <img src="/assets/img/bars.svg" alt=""/>
                "Searching..."
            </span> 
        </h3>
        <input 
            className="form-control" 
            name="search" 
            placeholder="Search for articles..." 
            _hx_post="/search" 
            _hx_trigger="input changed delay:50ms, search" 
            _hx_target="#search-results" 
            _hx_indicator=".htmx-indicator"/>
   </div>

let results =
    <table className="table">
        <thead>
            <tr>
                <th>"Entries"</th>
            </tr>
        </thead>
            <tbody id="search-results">
        </tbody>
    </table>

let row = (filename: string) =>
    <tr><td><a href={"./blogs/" ++ filename}>{Html.txt(filename)}</a></td></tr>

let view = (query) => {
    if (query == "") {
        View.make([]);
    } else {
        View.make(
            List.map(
                row,
                Blog.query(query)
            )
        );
    }
};
