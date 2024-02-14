open Tyxml;

let create_button = (~num, ~selected) =>
    <button 
        _hx_get=("/tab/" ++ num)
        className=[selected ? "selected" : ""] 
        role="tab" 
        aria_selected="false" 
        aria_controls="tab-content">
        {Html.txt("Tab " ++ num)}
    </button>

let nav_bar = (~num) =>
    <div className="tab-list" role="tablist">
        ...{List.init(
            3, 
            (i) => 
                create_button(
                    ~num=string_of_int(i + 1),
                    ~selected=(string_of_int(i + 1) == num)
                )
        )}
    </div>

let tab_content = (~num) =>
    <div id="tab-content" role="tabpanel" className="tab-content">
        {Html.txt("This is the content of tab " ++ num ++ ". Click the other tabs to see more!")}
    </div>;

let view = (~num) => {
    View.make([
       nav_bar(~num),
       tab_content(~num),
    ]);
};
