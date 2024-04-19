open Tyxml;

let createElement = () =>
  <a
    className="logo"
    href="/"
    aria_label="The Home page"
    _hx_get="/content"
    _hx_target="main"
    _hx_swap="settle:150ms show:body:top"
    _hx_replace_url="/">
    <Icon src="./public/svg/logo.svg" alt="logo" />
  </a>;
