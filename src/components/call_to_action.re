open Tyxml;

let createElement = () => {
  <a
    className="call-to-action"
    aria_label="See all the blogs"
    tabindex="0"
    href="/explore"
    _hx_get="/explore/content"
    _hx_target="main"
    _hx_push_url="/explore"
    _hx_swap="settle:150ms show:body:top">
    "Explore More"
  </a>;
};
