open Tyxml;

let row = (filename) =>
    <tr><td>{Html.txt(filename)}</td></tr>

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
