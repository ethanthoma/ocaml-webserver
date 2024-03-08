open Tyxml;

let nav =
    <ul id="nav">
        <li>
            <a href="https://github.com/ethanthoma" className="outline">
                <Icon src="./public/svg/logo-github.svg" alt="github"/>
            </a>
        </li>
        <li>
            <a href="https://twitter.com/EthanBThoma" className="animate outline">
                <Icon src="./public/svg/logo-twitter.svg" alt="twitter"/>
            </a>
        </li>
        <li>
            <a href="mailto:ethanthoma@gmail.com" className="animate outline">
                <Icon src="./public/svg/mail.svg" alt="email"/>
            </a>
        </li>
    </ul>

let component =
    <header>
        <div id="left">
            <a 
                className="outline"
                href=""
                _hx_get="/content" 
                _hx_target="main"
                _hx_swap="innerHTML settle:150ms" 
                _hx_replace_url="/"
            >     
                <Icon src="./public/svg/logo.svg" alt="logo"/>
            </a>
            Search.component
        </div>
        nav
    </header>
