---
title: "Email Encryption"
permalink: /software/
excerpt: "Email Encryption"
modified: 2016-08-15T15:00:00-00:00
---

{% include base_path %}

{% include toc %}

All email applications on this page support the OpenPGP standard either directly or with additional software.
The authors of this webpage are not actively participating in the development of each of these third-party apps.
No security audits have been done by us and, thus, we cannot provide any security guarantees.

## Windows

##### Gpg4Win
 > Developer/Publisher: intevation  
 > Plattform: Outlook  
 > Homepage: https://www.gpg4win.de/?lang=en  
 > Help: https://www.gpg4win.de/forum?lang=en

##### gpg4o
 > Developer/Publisher: Giegerich 6 Partner GmbH  
 > Plattform: Outlook  
 > Homepage: https://www.gpg4o.com  
 > Help: https://www.gpg4o.com/forum?lang=en

##### p≡p
 > Developer/Publisher: p≡p Foundation  
 > Plattform: Outlook  
 > Homepage: https://prettyeasyprivacy.com  
 > Help: https://prettyeasyprivacy.com/faq/

##### Enigmail
 > Developer/Publisher: [team](https://enigmail.net/index.php/en/2-english/24-team-members) of dedicated professionals  
 > Plattform: Thunderbird  
 > Homepage: https://enigmail.net/index.php/en/  
 > Help: https://sourceforge.net/p/enigmail/forum/

---

## Mac OS
##### GPGTools
 > Developer/Publisher: Open Source Community  
 > Plattform: Apple Mail  
 > Homepage: https://gpgtools.org   
 > Help: https://gpgtools.tenderapp.com/discussions/problems

##### Enigmail
 > Developer/Publisher: [team](https://enigmail.net/index.php/en/2-english/24-team-members) of dedicated professionals  
 > Plattform: Thunderbird  
 > Homepage: https://enigmail.net/index.php/en/  
 > Help: https://sourceforge.net/p/enigmail/forum/

---
## Mobile Devices
##### K-9 Mail with Openkeychain
 > Developer/Publisher: Open Source Community  
 > Plattform: Android  
 > Homepage: https://k9mail.github.io/  & https://www.openkeychain.org/  
 > Help: https://github.com/k9mail/k-9/issues

##### p≡p
 > Developer/Publisher: p≡p Foundation  
 > Plattform: Android  
 > Homepage: https://prettyeasyprivacy.com  
 > Help: https://prettyeasyprivacy.com/faq/

##### R2Mail2
 > Developer/Publisher: rundQuadrat OG  
 > Plattform: Android  
 > Homepage: https://r2mail2.com  
 > Help: -

##### iPGMail
 > Developer/Publisher: Wyllys Ingersoll  
 > Plattform: iOS  
 > Homepage: https://ipgmail.com/  
 > Help: https://ipgmail.com/support/

---

## GNU/Linux
##### Seahorse
 > Developer/Publisher: The GNOME Foundation  
 > Plattform: [Evolution](https://wiki.gnome.org/Apps/Evolution)  
 > Homepage: https://wiki.gnome.org/action/show/Apps/Seahorse   
 > Help: https://bugzilla.gnome.org/

##### Kleopatra
 > Developer/Publisher: The GNOME Foundation  
 > Plattform: [KMail](https://www.kde.org/applications/internet/kmail/)   
 > Homepage: https://www.kde.org/applications/utilities/kleopatra/   
 > Help: https://userbase.kde.org/Getting_Help/en
 
##### Enigmail
 > Developer/Publisher: [team](https://enigmail.net/index.php/en/2-english/24-team-members) of dedicated professionals  
 > Plattform: Thunderbird  
 > Homepage: https://enigmail.net/index.php/en/  
 > Help: https://sourceforge.net/p/enigmail/forum/
 
 ---

## Browser Plugins
##### Mailvelope
 > Developer/Publisher: Mailvelope GmbH  
 > Plattform: Chrome / Firefox  
 > Homepage: https://www.mailvelope.com  
 > Help: https://www.mailvelope.com/en/faq

---

## Webmail Provider with Browser Plugins
The following webmail providers support email encryption via the OpenPGP standard using browser plugins.

* [GMX](http://www.gmx.net/) (Mailvelope)
* [mailbox.org](https://mailbox.org/) (Mailvelope, also In-Browser Cryptography)
* [POSTEO](https://posteo.de) (Mailvelope)
* [WEB.DE](http://web.de/) (Mailvelope)

---

## Webmail Provider with In-Browser Cryptography
In contrast to the previous section, the following webmail providers do not require the installation of additional plugins, instead JavaScript cryptographic libraries are served by the website itself.
While these are easier to set up and provide basic security guarantees with OpenPGP, [some people don't consider this "end-to-end"](https://tonyarcieri.com/whats-wrong-with-webcrypto).

* [Hushmail](https://www.hushmail.com/)
* [Mailfence](https://www.mailfence.com/)
* [ProtonMail](https://protonmail.com/)

---

## Project Missing?
If a project is missing and you would like it included, please open a pull request at [github.com/OpenPGP/openpgp.github.io](https://github.com/OpenPGP/openpgp.github.io).
Please note that we only include published, working software, which implements the standard.
The software is ordered alphabetically within the sections.
