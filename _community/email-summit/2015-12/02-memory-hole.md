---
title: "Summit 2015-12 Notes - Memory Hole"
permalink: /community/email-summit/2015-12/minutes/memory-hole
---

{% include toc %}

*Memory Hole spec and documentation:
[https://github.com/modernpgp/memoryhole/](https://github.com/modernpgp/memoryhole/)*
Workshop at [2nd OpenPGP Email Summit, Dec 2015](..) run by dkg

## Overview / Status {#Overview_.2F_Status}

t.b.d.

## Workshop Notes {#Workshop_Notes}

Parts of toipc to regard: UI, Generation, Interpreting

### General {#General}

-   memhole headers have to be first mime part within email/protected
    area.
-   protected email = memory hole signed/encrypted email ??? first
    memhole headers found within protected part of email should bubble
    out and be displayed to the user.

### Signed {#Signed}

#### Generating {#Generating}

-   Memhole for signed message easiest to accomplish, presentation
    available already in every mua
-   Select headers to protect when signing:
-   From
-   To, CC
-   Date
-   Reply-To
-   Message-ID
-   References, In-Reply-To
-   memoryhole header line, including memhole version
-   include flag if first existing rfc822 part inside protected area
    should be interpreted as force-display header
-   Order to interpret each line has protection info, starts with 0
    exclude content-type! just from top level how to resolve differences

#### Display/UI {#Display.2FUI}

-   show that headers are memhole headers somehow
-   show memhole headers accordingly to mua style of showing (non)
    tampered signatures/emails
-   when receiving emails with signed and unsigned parts, user should be
    able to show unsigned/"weird" parts of email. by default only
    display signed parts
-   memhole is designed to ensure that the mime body of email is signed!
    (or at least some specific parts are signed)
-   if memhole message protected only display protected/signed header
    lines.
-   display in mua if (un)signed (=(un)protected) email is _not_
    memhole protected!
-   strikeout
-   prefix text
-   click-to-display
-   color/background
-   frames
-   fonts (italics/bold)
-   icons

### Encryption {#Encryption}

-   including protected headers in encrypted part preempts splicing
    attack (combining headers from mail a and encrypted mail b)

#### Generating {#Generating-1}

-   Choose by yourself which headers to force-display and which are
    stripable when encrypting:
-   From
-   To, CC
-   Date
-   Reply-To
-   Message-ID
-   References, In-Reply-To
-   memoryhole header line, including memhole version
-   memhole headers may only appaer in the first protected mime part or
    in the force-display section (text/rfc-822headers part)

#### Displaying/UI {#Displaying.2FUI}

-   how to communicate unencrypted headers (metadata) to the user?

### Open questions {#Open_questions}

-   include/protect conten-description in signed emails?
-   email manifest/separate headers? -> discussion about manifests
    should be started/continued within mailing list
-   how do i detect stubbing securely?
-   non-stripped-encryption-protected-headers: how to display?
