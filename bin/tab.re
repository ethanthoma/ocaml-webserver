open Tyxml;

let create_button = (~num, ~selected) => {
    let class_name = selected ? "selected" : "";

    <button 
        _hx_get=("/tab/" ++ num)
        className=[class_name] 
        role="tab" 
        aria_selected="false" 
        aria_controls="tab-content">
        {Html.txt("Tab " ++ num)}
    </button>
};

let nav_bar = (~num) => {
    let is_selected = (tab) => tab == num;

    <div className="tab-list" role="tablist">
        {create_button(~num="1", ~selected=is_selected("1"))}
        {create_button(~num="2", ~selected=is_selected("2"))}
        {create_button(~num="3", ~selected=is_selected("3"))}
    </div>;
};

let tab_content = (~num) =>
    <div id="tab-content" role="tabpanel" className="tab-content">
        {Html.txt(num)}
    </div>;

let view = (~num) => {
    let content = [
        nav_bar(~num),
        tab_content(~num)
    ];

    View.make(content);
};
