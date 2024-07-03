open Tyxml;

let nav =
  <nav>
    <a
      href="/explore"
      _hx_get="/explore/content"
      _hx_target="main"
      _hx_push_url="/explore"
      _hx_swap="settle:150ms show:body:top">
      "Blogs"
    </a>
    <a
      href="https://github.com/stars/ethanthoma/lists/research"
      _hx_swap="settle:150ms show:body:top">
      "Research"
    </a>
  </nav>;

let component = <header> <div id="left"> <Logo /> </div> nav </header>;
