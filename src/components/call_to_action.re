open Tyxml;

let createElement = () => {
  <a
    className="call-to-action"
    aria_label="See all the blogs"
    tabindex="0"
    _hx_get="/explore/content"
    _hx_target="main"
    _hx_push_url="/explore"
    _hx_swap="settle:150ms">
    "Explore More"
  </a>;
};
