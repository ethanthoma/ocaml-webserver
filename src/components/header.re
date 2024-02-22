open Tyxml;

let nav =
    <ul id="nav">
        <li>
            <a href="https://github.com/ethanthoma">
                <Icon src="./public/svg/logo-github.svg" alt="github"/>
            </a>
        </li>
        <li>
            <a href="https://twitter.com/EthanBThoma">
                <Icon src="./public/svg/logo-twitter.svg" alt="twitter"/>
            </a>
        </li>
        <li>
            <a href="mailto:ethanthoma@gmail.com">
                <Icon src="./public/svg/mail.svg" alt="email"/>
            </a>
        </li>
    </ul>

let component =
    <header>
        <div id="left">
            <a href="/">     
                <Icon src="./public/svg/logo.svg" alt="logo"/>
            </a>
            Search.component
        </div>
        nav
    </header>
