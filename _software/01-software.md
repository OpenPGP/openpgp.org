---
title: "Email Encryption"
permalink: /software/
excerpt: "Email Encryption"
modified: 2017-09-27T09:00:00-00:00
---

{% include base_path %}

{% include toc %}

All email applications on this page support the OpenPGP standard either directly or with additional software.
The authors of this webpage are not actively participating in the development of each of these third-party apps.
No security audits have been done by us and, thus, we cannot provide any security guarantees.

## Windows
* [eM Client](/software/emclient/)<sup>[4](#gnupg)</sup>
* [Outlook : gpg4o](/software/gpg4o/)<sup>[1](#gnupg)</sup>
* [Outlook : Gpg4win](/software/gpg4win/)<sup>[1](#gnupg)</sup>
* [Outlook : p≡p](/software/pep/)<sup>[1](#gnupg)</sup>
* [Thunderbird : Enigmail](/software/enigmail/)<sup>[1](#gnupg)</sup>

## Mac OS
* [Apple Mail: GPGTools](/software/gpgtools/)<sup>[1](#gnupg)</sup>
* [Mutt](/software/mutt/)<sup>[2](#gpgme)</sup>
* [Thunderbird : Enigmail](/software/enigmail/)<sup>[1](#gnupg)</sup>

## Android
* [K-9 Mail : OpenKeychain](/software/openkeychain/)
* [p≡p](/software/pep/)<sup>[1](#gnupg)</sup>
* [R2Mail2](/software/r2mail2/)

## iOS
* [iPGMail](/software/ipgmail/)

## GNU/Linux
* [Evolution : Seahorse](/software/seahorse/)<sup>[1](#gnupg)</sup>
* [KMail : Kleopatra](/software/kleopatra/)<sup>[1](#gnupg)</sup>
* [Mutt](/software/mutt/)<sup>[2](#gpgme)</sup>
* [Thunderbird : Enigmail](/software/enigmail/)<sup>[1](#gnupg)</sup>

## SunOS/Solaris
* [Mutt](/software/mutt/)<sup>[2](#gpgme)</sup>
* [Thunderbird : Enigmail](/software/enigmail/)<sup>[1](#gnupg)</sup>

## Browser Plugins
* [Mailvelope](/software/mailvelope/)

## Webmail Provider with Browser Plugins
The following webmail providers support email encryption via the OpenPGP standard using browser plugins.

* [GMX](http://www.gmx.net/)<sup>[3](#mailvelope)</sup>
* [mailbox.org](https://mailbox.org/) (<sup>[3](#mailvelope)</sup>, also In-Browser Cryptography)
* [POSTEO](https://posteo.de)<sup>[3](#mailvelope)</sup>
* [WEB.DE](http://web.de/)<sup>[3](#mailvelope)</sup>

## Webmail Provider with In-Browser Cryptography
In contrast to the previous section, the following webmail providers do not require the installation of additional browser plugins, instead OpenPGP is implemented in JavaScript provided directly by the website.
While these are easier to set up and provide basic security guarantees with OpenPGP, [some people don't consider these "end-to-end secure"](https://tonyarcieri.com/whats-wrong-with-webcrypto).

* [Hushmail](https://www.hushmail.com/)
* [Mailfence](https://www.mailfence.com/)
* [ProtonMail](https://protonmail.com/)

## Project Missing?
If a project is missing and you would like it included, please open a pull request at [github.com/OpenPGP/openpgp.github.io](https://github.com/OpenPGP/openpgp.github.io).
Please note that we only include published, working software, which implements the standard.
The software is ordered alphabetically within the sections.

---

<a name="gnupg">1</a>: uses [GnuPG](https://www.gnupg.org)  
<a name="gpgme">2</a>: uses [GnuPG](https://www.gnupg.org) with (optionally) the [GPG Made Easy](https://www.gnupg.org/related_software/gpgme/index.html) API.  
<a name="mailvelope">3</a>: requires [Mailvelope](/software/mailvelope/)
<a name="bouncycastle">4</a>: uses [Bouncy Castle](https://www.bouncycastle.org/)  