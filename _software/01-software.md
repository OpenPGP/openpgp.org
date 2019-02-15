---
title: "Email Encryption"
permalink: /software/
excerpt: "Email Encryption"
modified: 2018-02-08T09:00:00-00:00
---

{% include base_path %}

{% include toc %}

All email applications on this page support the OpenPGP standard either directly or with additional software.
The authors of this webpage are not actively participating in the development of each of these third-party apps.
No security audits have been done by us and, thus, we cannot provide any security guarantees.

## Windows
* [eM Client](/software/emclient/)
* [EverDesk](/software/everdesk/)
* Outlook:
  * [gpg4o](/software/gpg4o/)
  * [Gpg4win](/software/gpg4win/)
  * [p≡p](/software/pep/)
* [Thunderbird: Enigmail](/software/enigmail/)

## Mac OS
* [Apple Mail: GPGTools](/software/gpgtools/)
* [Canary Mail](/software/canary-mail/)
* [Mutt](/software/mutt/)
* [Thunderbird: Enigmail](/software/enigmail/)

## Android
* [K-9 Mail: OpenKeychain](/software/openkeychain/)
* [p≡p](/software/pep/)
* [R2Mail2](/software/r2mail2/)

## iOS
* [Canary Mail](/software/canary-mail/)
* [iPGMail](/software/ipgmail/)

## Linux
* [Evolution: Seahorse](/software/seahorse/)
* [KMail: Kleopatra](/software/kleopatra/)
* [Mutt](/software/mutt/)
* [Thunderbird: Enigmail](/software/enigmail/)

## Browser Plugins
* [Mailvelope](/software/mailvelope/)
* [FlowCrypt (Gmail)](https://flowcrypt.com/)
* [Psono](/software/psono/)

## Webmail Provider with Browser Plugins
A lot of webmail providers support email encryption via the OpenPGP standard using [Mailvelope](/software/mailvelope/).
The Mailvelope website provides a list of [supported webmail providers](https://www.mailvelope.com/en/faq#mailer_list).

Providers with help pages:

* [GMX](https://hilfe.gmx.net/sicherheit/pgp/mailvelope-installieren.html)
* [Posteo](https://posteo.de/hilfe/wie-installiere-ich-eine-ende-zu-ende-verschluesselung-pgp-im-browser)
* [WEB.DE](https://hilfe.web.de/sicherheit/pgp/index.html)

Pre-configured (authorized) providers:

* [Gmail](https://mail.google.com/)
* [mail.ru](https://mail.ru/)
* [Outlook.com](https://outlook.live.com/owa/)
* [volny.cz](https://volny.cz/)
* [Yahoo](https://login.yahoo.com/)
* [Zoho Mail](https://www.zoho.eu/mail/)

Other authorized providers with API support:

* [mailbox.org](https://mailbox.org/)
* [riseup.net](https://mail.riseup.net/)
* [Roundcube](https://roundcube.net/)


## Webmail Provider with In-Browser Cryptography
In contrast to the previous section, the following webmail providers do not require the installation of additional browser plugins, instead OpenPGP is implemented in JavaScript provided directly by the website.
While these are easier to set up and provide basic security guarantees with OpenPGP, [some people don't consider these "end-to-end secure"](https://tonyarcieri.com/whats-wrong-with-webcrypto).

* [Hushmail](https://www.hushmail.com/) (limited OpenPGP support)
* [Mailfence](https://www.mailfence.com/)
* [ProtonMail](https://protonmail.com/)

## Project Missing?
If a project is missing and you would like it included, please open a pull request at [github.com/OpenPGP/openpgp.org](https://github.com/OpenPGP/openpgp.org).
Please note that we only include published, working software, which implements the standard.
The software is ordered alphabetically within the sections.
