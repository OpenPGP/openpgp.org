---
title: "FlowCrypt"
permalink: /software/flowcrypt/
excerpt: "Email Encryption"
modified: 2023-06-22T23:45:00-00:00
--- 

🛡️ FlowCrypt offers different simple and convenient email encryption solutions. We provide end-to-end asymmetric encryption, ensuring that only the intended recipients can read the encrypted content. This means that even if intercepted during transmission or stored on email servers, your messages remain secure and unreadable to anyone without the corresponding private key. Our products include:

* [Chrome Extension](https://chrome.google.com/webstore/detail/flowcrypt-encrypt-gmail-w/bnjglocicdkmhmoohhfkfkbbkejdhdgc)
* [Brave Extension](https://chrome.google.com/webstore/detail/flowcrypt-encrypt-gmail-w/bnjglocicdkmhmoohhfkfkbbkejdhdgc)
* [Firefox Extension](https://s3-us-west-2.amazonaws.com/cryptup-release/firefox/cryptup-io-firefox-8.4.8.xpi)
* [Android App](https://play.google.com/store/apps/details?id=com.flowcrypt.email)
* [iOS App](https://apps.apple.com/us/app/flowcrypt-encrypted-email/id1591754995)

💼 We also offer [Enterprise](https://flowcrypt.com/docs/technical/enterprise-server/latest/enterprise-server.html) solutions for key and user management:

* Self-hosted Enterprise Server, including a self-hosted WKD (Web Key Directory) server
* Shared-Tenant Server

For more detailed information concerning the differences between these two solutions, please refer to our [Choosing Between the Enterprise Server and Shared-Tenant Server](https://flowcrypt.com/docs/technical/specifications/enterprise-vs-shared-tenant.html) guide. To request FlowCrypt Enterprise solutions, please [fill in the form](https://mkfvqd0z9lh.typeform.com/to/JlxIU2eF).

🔒 We at FlowCrypt believe in transparency and extensive collaboration as a foundation for robust and secure systems. We run a public [Bug Bounty Program](https://flowcrypt.com/docs/technical/bug-bounty.html) and you can also check the [list of vulnerabilities](https://flowcrypt.com/docs/technical/fixed-vulnerabilities.html) that have already been found and fixed. Our code is publicly available on [GitHub](https://github.com/FlowCrypt), so you can review it and even become a contributor.

➕ FlowCrypt offers a variety of features to enhance your encrypted email experience.

You can:

* Send encrypted emails to both FlowCrypt and other OpenPGP-compatible software as well as receive from both Flowcrypt and other OpenPGP-compatible software users.
* Send encrypted attachments up to **25MB**, with previewing functionality for a bunch of types, such as PNG, JPG, GIF, PDF, and other popular file formats.
* Use FlowCrypt's own Attester [public key server](https://flowcrypt.com/docs/technical/attester.html). You can learn about the advantages of this solution in the [Attester Overview](http://flowcrypt.com/docs/technical/attester.html) guide.
* Share public keys via FlowCrypt Attester. [Demo for flowcrypt.docs@gmail.com](https://flowcrypt.com/pub/flowcrypt.docs@gmail.com).
* Generate private keys using the **ECC** and **RSA** (up to 4096-bit) algorithms.
* Sign encrypted emails to let your recipients verify that the message is from you and that the content hasn't been modified. Sign-only key support is available for the browser extension.
* Compose password-protected emails to send encrypted emails to the recipient who doesn't have any OpenPGP software.
* Use the [Encrypted Contact Page](https://flowcrypt.com/docs/guide/send-and-receive/encrypted-contact-page.html) to send OpenPGP encrypted emails without installing any OpenPGP software.

## Key Facts

* Developer/Publisher: FlowCrypt a.s.
* Programming language: Browser extension/TypeScript, iOS app/Swift, Android app and Enterprise solutions/Kotlin.
* License: Proprietary software with publicly available source code.
* Encryption Library: Browser Extension and iOS app/[OpenPGP.js](https://github.com/openpgpjs/openpgpjs), Android app/[PGPainless](https://github.com/pgpainless/pgpainless), Enterprise solutions/[OpenPGP.js](https://github.com/openpgpjs/openpgpjs) and [PGPainless](https://github.com/pgpainless/pgpainless).
* Price:
    * Free: Browser extension, mobile apps, and Enterprise Server/Shared-Tenant Server for up to 100 emails per domain.
    * [Paid](https://flowcrypt.com/docs/business/enterprise.html): Enterprise Server/Shared-Tenant Server for more than 100 emails per domain.
* Web:
    * [Website](https://flowcrypt.com)
    * [FlowCrypt Downloads](https://flowcrypt.com/download)
    * [Blog](https://flowcrypt.com/blog/)
    * [Twitter](https://twitter.com/FlowCrypt)
* Help:
    * [User Manual](https://flowcrypt.com/docs/guide/overview.html)
    * [FAQ](https://flowcrypt.com/docs/help/faq.html)
    * [RAQ](https://flowcrypt.com/docs/help/raq.html)
    * [FlowCrypt Knowledge Base](https://flowcrypt.com/blog/questions/)
    * [Privacy Policy](https://flowcrypt.com/privacy)
    * [Feature Availability](https://flowcrypt.com/docs/technical/feature-availability.html)
    * [Specification](https://flowcrypt.com/docs/technical/specifications/software-specifications.html)
* GitHub Repos:
    * [Browser extension for Gmail](https://github.com/FlowCrypt/flowcrypt-browser)
    * [Android App](https://github.com/FlowCrypt/flowcrypt-android)
    * [iOS App](https://github.com/FlowCrypt/flowcrypt-ios)
* Contacts:
    * `human@flowcrypt.com` for general support.
    * `security@flowcrypt.com` to submit a report, or reach out to the security team with questions and concerns.
