open Tyxml;

let nav =
    <ul id="nav">
        <li>
            <a 
                href="https://github.com/ethanthoma" 
                className="outline"
                aria_label="My GitHub account"
            >
                <Icon src="./public/svg/logo-github.svg" alt="github"/>
            </a>
        </li>
        <li>
            <a 
                href="https://twitter.com/EthanBThoma" 
                className="animate outline"
                aria_label="My Twitter account"
            >
                <Icon src="./public/svg/logo-twitter.svg" alt="twitter"/>
            </a>
        </li>
        <li>
            <a 
                href="mailto:ethoma@student.ubc.ca" 
                className="animate outline"
                aria_label="My email address"
            >
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
                aria_label="The Home page"
                _hx_get="/content" 
                _hx_target="main"
                _hx_swap="settle:150ms show:body:top" 
                _hx_replace_url="/"
            >     
                <Icon src="./public/svg/logo.svg" alt="logo"/>
            </a>
            Search.component
        </div>
        nav
    </header>
