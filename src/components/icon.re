open Tyxml;

let createElement = (~src: string, ~alt: string, ()) => {
    let svg_content = In_channel.with_open_bin(src, In_channel.input_all);

    <div className="icon">
        <div className="content">
            {
                try(Html.Unsafe.data(svg_content)) {
                    | Not_found => Html.txt(alt)
                };
            }
        </div>
    </div>
};
