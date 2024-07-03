open Tyxml;

let component =
  <footer>
    <p> "© 2024 Ethan Thoma and/or his affiliates. All rights reserved." </p>
    <ul id="nav">
      <li>
        <a
          href="https://github.com/ethanthoma/ocaml-webserver"
          aria_label="The source code to me website on GitHub.">
          "The source code."
        </a>
      </li>
      <li>
        <a href="https://www.buymeacoffee.com/ethanthoma">
          "Buy me a coffee?"
        </a>
      </li>
    </ul>
    <ul id="contact">
      <li>
        <a
          href="https://github.com/ethanthoma"
          className="outline"
          aria_label="My GitHub account">
          <Icon src="./public/svg/logo-github.svg" alt="github" />
        </a>
      </li>
      <li>
        <a
          href="https://twitter.com/EthanBThoma"
          className="animate outline"
          aria_label="My Twitter account">
          <Icon src="./public/svg/logo-twitter.svg" alt="twitter" />
        </a>
      </li>
      <li>
        <a
          href="mailto:ethoma@student.ubc.ca"
          className="animate outline"
          aria_label="My email address">
          <Icon src="./public/svg/mail.svg" alt="email" />
        </a>
      </li>
    </ul>
  </footer>;
