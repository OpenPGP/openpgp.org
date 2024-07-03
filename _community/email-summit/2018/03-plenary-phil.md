---
title: "Plenary Session - Improve OpenPGP"
permalink: /community/email-summit/2018/improve-openpgp/
---

Phil Zimmermann at the 2018 OpenPGP Summit

## get rid of legacy {#get_rid_of_legacy}

-   TLS 1.3 is huge improvement for TLS, got rid of legacy, i'd like to
    see the same things in OpenPGP
-   I am responsible for some of that legacy crap, i was young. CFB.
-   we should use most modern crypto. and only patent-free.
    (IDEA fail)
-   let's get rid of old stuff.
-   Poly1305 is nice
-   don't like GCM much

## post-quantum-algorithms

-   Post-Quantom-Algorithms. it's in
    WireGuard. need to do the same thing in
    OpenPGP
-   It's a lot more work. OpenPGP is a mess.
    lots of implementations. let's improve it
-   I used to not believe in post-quanton a few years back. but when NSA
    started warning us that we should get ready, we should. If you
    don't trust them, get ready. If you trust them, get ready.
-   we need it now. we can't wait.
-   post-quantum keys can be huge, let's not transport keys but
    fingerprints and download them from servers
-   some keys in the NIST competition from three
    months ago are obscenely large
-   [https://en.wikipedia.org/wiki/Post-Quantum_Cryptography_Standardization](https://en.wikipedia.org/wiki/Post-Quantum_Cryptography_Standardization)

## use other channels for fingerprint verification {#use_other_channels_for_fingerprint_verification}

-   we do fingerprint verification, few other people do
-   ZRTP and Signal protocol in same client:
    Silent Phone
-   lack of network effect in OpenPGP world.
    we still only have a few million PGP users worldwide.
    WhatsApp has 1.5 billion. we're doing
    something not right
-   DigiNotar catastrophe
-   PGP trust model is hard to explain to your mom or anyone really. we
    need to get past that
-   let's leverage other protocols that have alread successfully
    leveraged network effect
-   imagine if PGP public fingerprints could be transferred through
    WhatsApp/Signal/Wire, then transfer it to
    PGP client
-   get larger number of users
-   merkle trees, certificate transparency - these take much longer

## Q&A {#Q.26A}

-   phil: bootstrapping PGP clients is even harder today, today most
    people are on mobile devices, these are locked down
-   phil: I don't use PGP any more. GnuPG can't import my
    private key. I can't make it work. I'm protected from
    EFAIL by inability.
-   Werner: We can import post-quantum-keys at any time. We only need to
    change the spec to allow keys larger 64K.
-   Vincent: Not that easy. Want to use a combination of different keys.
-   Phil: post-quantum into the protocol sounds simple, but ...
-   Phil: less post-quantum signature algorithms. and they sucks. we
    could procrastinate a few more years on signature algorithms
-   Vincent: Who is "you" working on it? Phil: I for KPN,
    C-U-Tel, Startpage.
-   Status? Phil: We need a clean, simple, limited protocol. Like TLS
    1.3.
