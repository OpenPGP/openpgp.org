---
title: "Summit 2019 Notes"
permalink: /community/email-summit/2019/minutes/
---

{% include toc %}

This page documents the notes that were taken during the [5th OpenPGP
Email Summit](..) which took place 2019-10-12/13.

## Plenary talks {#Plenary_talks}

### Patrick discussed future of Enigmail and Thunderbird {#Patrick_discussed_future_of_Enigmail_and_Thunderbird}

-   enigmail is going away (except for postbox)
-   thunderbird will build in openpgp support as a peer of
    S/MIME support
-   timeline is short -- identifying crypto library is a blocker at the
    moment -- language + licensing are the biggest concerns
-   most likely at the moment sounds like Botan + RNP

### Andre talks about GnuPG plans and updates {#Andre_talks_about_GnuPG_plans_and_updates}

-   2.3.0 is expected to be released 20 December
    -   Biggest work in progress is the keyring daemon
-   they'll have a local office in Duesseldorf soon
-   they're working on organizational/institutional support

### Holger presents deltachat -- implementation and status {#Holger_presents_deltachat_--_implementation_and_status}

-   cross-platform implementations (iOS is biggest blocker)
-   verified groups
-   verification
-   upcoming:
    -   Burner accounts
    -   ed25519 upgrade for keyskeys
    -   chat bots
    -   mime-parser cleanup and review
    -   rPGP improvements and parsing

## Workshops {#Workshops}

### Workshop: How to approach UX Decisions {#Workshop:_How_to_approach_UX_Decisions}

-   Quick round how do people approach UX issues, how are decisions
    made, are there dedicated people working on it?
    -   Some teams had dedicated UX people, worked with universities on
        structured studies
    -   Some had dedicated "special users" who they regularly sought
        feedback from
    -   Others were more ad-hoc: shoulder-surfing, feedback from users
-   You can learn UX Design, it's a good problem solving tool.
-   Eileen: Don't armchair problems, go out and ask people.
-   Eileen introduces personas: helps you be empathetic. AKA a more
    personalized form of threat modelling. Sounds vague at first, will
    get more concrete when you "flesh it" out.
-   A persona is a sketch of a person.
-   A couple of bullet points about a person, based on reality
    -   Demographics, but also how they might use the software
    -   What are their hobbies, their family? Help with empathy.
    -   What is their intent, what do they want to achieve
    -   A more generic form of threat modeling
-   UX testing doesn't have to be complicated, start with pen&paper and
    ask people if they can make sense of your drawings.
-   Based on groups of personas you can build user stories: X wants to
    do Y to achieve Z.
-   Break-away, into pairs, developing our own personas for our
    projects, discussion...
-   The need for too many users is often a sign that you're doing too
    much at once (which probably won't make anyone happy).
-   Having only 3 personas can also lead to doing to much at once.
-   Hacker as a persona: do we need to design for them? They can build
    their own thing? But they are often quite vocal (loud), maybe
    support the project financially or technically. But often don't
    even actually need encryption tools, don't have a threat model,
    want encryption for the sake of it.
-   The question is not: how can we simplify things. It is: how can we
    make it work better for the persona we're thinking about. For a
    hacker persona that could actually mean a lot of configuration
    options.
-   Problem: immature projects have more hacker/tech-savvy users, even
    if the target would be more mainstream. Changing the interface would
    repeal them. Maybe leaving hackers behind is ok, they will be able
    to care for themselves. Reaching the "mainstream" is hard, though,
    you can get stuck on the way.
-   A challenge: reacting to user feedback from a vocal minority, e.g.
    power users who know about GitHub issues.
    How to meet and talk to people who are not already "hackers"?
-   A persona is a sketch of a person, a scenario is a sketch of a
    situation/use-case.
-   Personas are beautiful, use personas for your software: :
    ​​​​​​​https://simplysecure.org/resources/persona-template-security.pdf
-   Probably bad example from GnuPG of personas and user
    stories:
    [https://wiki.gnupg.org/EasyGpg2016/VisionAndStories](https://wiki.gnupg.org/EasyGpg2016/VisionAndStories)
-   More resources:
    -   UI Heuristics (NN Group, 1994):
        [https://www.nngroup.com/articles/how-to-conduct-a-heuristic-evaluation/cles/how-to-conduct-a-heuristic-evaluation/t-a-heuristic-evaluation/cles/how-to-conduct-a-heuristic-evaluation/](https://www.nngroup.com/articles/how-to-conduct-a-heuristic-evaluation/cles/how-to-conduct-a-heuristic-evaluation/t-a-heuristic-evaluation/cles/how-to-conduct-a-heuristic-evaluation/)
    -   Formative Testing (Tails interview):
        [https://simplysecure.org/blog/formative-testingistic-evaluation/rmative](https://simplysecure.org/blog/formative-testingistic-evaluation/rmative)
        Testing (Tails interview):
        [https://simplysecure.org/blog/formative-testingistic-evaluation/](https://simplysecure.org/blog/formative-testingistic-evaluation/)
    -   Example of Tails personas:
        [https://tails.boum.org/contribute/personas/](https://tails.boum.org/contribute/personas/)
    -   NoScript Case Study (Designing for
        power users):
        [https://simplysecure.org/blog/noscript-case-study/blog/noscript-case-study](https://simplysecure.org/blog/noscript-case-study/blog/noscript-case-study)
    -   Some templates for UX beginners:
        [https://simplysecure.org/ux-starter-pack/](https://simplysecure.org/ux-starter-pack/)

### Workshop: OpenPGP Standardization (RFC4880bis) {#Workshop:_OpenPGP_Standardization_.28RFC4880bis.29}

IETF started standardizing RFC 4880 bis, but the
perspective is not clear. Many are waiting for a full standard before
implementing, but this is stalling the standard efforts: many open
questions, without a roadmap. Should we push and get a standard out of
the door?

#### Deciding curves and standards {#Deciding_curves_and_standards}

In order to continue we could get a set of test vectors and some working
implementations for the necomers

It is difficult to chose a set of curves that can be defined as a
"minimal subset".

There exists already a subset of GPG:
[https://github.com/boring-pgp/spec](https://github.com/boring-pgp/spec)

It is difficult to deprecate stuff, as you would need to provide a
library to decrypt these algorithms, but not encrypt with them. The best
step to deprecate could be to just replace the asymmetric primitives
with more modern ones "fairly cheaply". This could be done with a
compat lib. Deprecation would create a lot of friction, in order to add
it to the RFC.

Regarding RFC4880bis it could be a minimal
document, e.g. with only one curve, with a subset that requires the
least amount of arguing, and could have the best chance to get the
consensus. People can still support a superset for the satandard.
Different people are already using a variety of curves, and will want to
keep them.

In RFC 4880 there is already a "good bits" subset, and RFC 4880bis-08
has a "Compatibility Profiles" section.

#### AEAD {#AEAD}

Since there was no legitimate streaming crypto in PGP, so it could be
split onto a new RFC, that should take care individually of the
AEAD chunking problem. This will have a dedicated
team to tackle this issue. (The code points, i.e. assigned numbers =
IDs, could be reserved for future use, for then to be added separately,
as it is not a refresh of the current standard)

Removing chunking right now could on the other hand could break many
existing messages, because it has been in the draft for a while. It
could be used to preview emails.

#### Follow ups {#Follow_ups}

-   Streaming, random access w.r.t. chunking of symmetrically encrypted
    data
-   How to break the impasse of releasing the new RFC
-   later work as separated drafts (e.g. privacy issues, attestation
    signatures)

#### Strategic questions w.r.t. IETF workflows for a new RFC4880bis {#Strategic_questions_w.r.t._IETF_workflows_for_a_new_RFC4880bis}

-   Deprecation of items (IDs; assigned numbers for packet tags,
    algorithms)
-   adding more test vectors to improve interoperatibility
-   AEAD chunk size limit issue (almost solved on
    mailing list with compromise)
-   AEAD as a replacement for MDC; maybe without
    chunking to make cryptographers happy
-   good for IETF process: demonstrated consensus
    on the mailing list, not only exchange of arguments
-   authorship of part of the new document; showing effort and
    participation in the working group (WG)

### Workshop: key distribution mechanims interaction in clients {#Workshop:_key_distribution_mechanims_interaction_in_clients}

[https://download.sumptuouscapital.com/tmp/20191012_144832.jpg](https://download.sumptuouscapital.com/tmp/20191012_144832.jpg)

Quick overview of key dist mechs:

-   manual download from a Web site
-   email attachement
-   local trust store - already exists
-   sneakernet
-   WKD - domain specific directory, key for that domain
-   sks keyservers
-   public validating keyservers - server validates key first
-   DANE/OpenPGPkey -
    cert is in the DNS, signed with DNSSEC
-   LDAP
-   AutoCrypt - keys in headers
-   AutoCrypt Gossip - keys of other
    recipients in headers
-   out-of-band, e.g. signal
-   keybase
-   namecoin
-   pep - similar to email attachement
-   vvv - we don't really know what this is but it is a thing - fairly
    close to some other things in this list - not know to be
    used/software exists -
    [https://keys4all.de/media/beschreibung-vvv-loesung.pdf](https://keys4all.de/media/beschreibung-vvv-loesung.pdf)
-   OS/system keystore (Debian package)
-   email round-trip - explicitly ask for key

How do we deal with presenting/combinging all these?

Critiria to care about:

-   opennes
-   uploading opennes
-   network/data protocols
-   metadata leakage
-   scoping
-   api - what do get back
-   maintenance

e.g. of how these are done:

-   detect from all, give option to add to local trust store
-   on send local trust store takes precedence, wkd and local keyserver
    fallback, further (future) fallback to verifying keyserver

gnupg:

-   local keystore, wkd fallback
    -   prioritisation as well, web-of-trust
-   more can be configured
-   grouping and prioritisation by source

mailpile:

-   local keystore, attachments, autocrypt headers, things which can be
    done over tor: wkd, validating keyserver
    -   ranking of multiple results
-   dane not open enough for ppl to participate

mailfence:

-   user keystore easily importable, import from sks (to be removed),
    future maybe wkd & validating

Small discussion on whether sks still has any future Validating
keyserver needs regular checks to the keyserver, not just initial fetch
Users will trust the first sks result, but implementations can not.
Users will just choose the newest key. Key history could allow better
ranking, identify keys which are not wrong but old, ignore the source as
a quality signal. counterpoint: WKD is organisational so can be
preferred, validating keyserver is a fallback if organisation does not
support wkd there's a tension between solutions that providers want to
support vs end devices which want to work with any provider

More info on the rating systems for keys use would be nice! Please add
below.

### Workshop: OpenPGP implementations {#Workshop:_OpenPGP_implementations}

What are the ones we know? (Should we separate
OpenPGP from cryptographic libraries in
general?)

-   rPGP (pure rust) -
    [https://github.com/rpgp/rpgp](https://github.com/rpgp/rpgp)
    , dual licensed Apache/MIT
-   RNP (C API, C++, botan)
-   GnuPG (C, libgcrypt, with bindings)
-   OpenPGP.js (javascript)
-   pgpy (python)py (python)
-   go-openpgp (go)
-   netpgp (C, openssl)
-   LibTMCG (C++, libgcrypt + (botan);
    experimental feature), used by DKGPG -
    [https://www.nongnu.org/libtmcg](https://www.nongnu.org/libtmcg)
-   Previous attempts
    -   GnuPG ME didn't have the right parsers
    -   RNP, C++ library derived from NetGPG
    -   NewPG, former GnuPG dev
        reducing size of codebase
    -   See more:
        [https://www.openpgp.org/software/developer](https://www.openpgp.org/software/developer)

What are criteria to compare libraries/implementations? <1> easy <2>
a bit harder <3> hard <4> really hard to determine

-   What standard operations can you do with the protocol? If it's a
    more limited set of options, then added security but limited usage
    scenarios. What is exposed to the user/developer?
-   API completeness/ compliance to standard (RFC) <4>
-   Portability <1>
-   Dependency chain of the libraries <2>
-   Active maintainers & feedback loop <1>
-   Documentation <1>
-   Is there any key storage and how secure is the storage?
-   Language bindings <1>
-   Test cases for your own testing, demo code <2>
-   Reviews and audits <2>

Core features of OpenPGP: key generation,
decrypt/encrypt, verify / generate signatures, key signing, trust
management

Key storage, does it have a standard format? What are security
requirements for that? See OpenSSL comparision
on Wikipedia

### Workshop: Key Transparency {#Workshop:_Key_Transparency}

[https://docs.google.com/presentation/d/1wtzwbto1cvImx1vBnkXtul3WAhYnLnZej81dKjnP2pc/edit?usp=sharing](https://docs.google.com/presentation/d/1wtzwbto1cvImx1vBnkXtul3WAhYnLnZej81dKjnP2pc/edit?usp=sharing)

CONIKS like. Put the hash of the root into
CT-log

Goal: Prevent a key-server from lying about the binding of an ID to a
key first-use scenario of a key requires less trust, because the
operator leaves publicly verifiable proofs

Merkle-tree of all the keys a key-server has

users need to check the tree regularly for the integrity of their own
key

each operator has their key transparency tree but could that be shared
among operators? but then you get malicious actors messing with the
tree. whitelisting entities who are able to add to the tree might be a
solution.

we could standardise the protocol, e.g. how to actually make a lookup

WKD: Could sign outgoing keys to have a transferrable assertion that
someone served a key at a given time

protonmail's mechanism could probably be ported to other validating key
servers like Hagrid

### Workshop: OpenPGP device syncronization {#Workshop:_OpenPGP_device_syncronization}

what kind of users and which type of device we want to sync?

what does it mean syncronization? let's map needs and concerns

-   needs: we need to be able to sync privkey but at least privkey
-   needs: verify sender and integrity
-   do we need to read history? email are not messenger, users needs to
    read old emails
-   device should have the same capabilities
-   syncronization can be multiple and different - what are the specific
    we need?
-   main concern is on user needs, if mail client is used for e-commerce
    we dont actually need to sync

3 macro challenges

1.  historic access to content (e.g. old mails)
2.  crypto capabilities (verify a msg, sign, encrypt, decrypt)
3.  message status *integrity*

What is a key? 1 OpenPGP certificate can have
multiple keys!

WE AGREE that we don't want individual
certificates for each device. (maybe.)

**how to do it?**

sec subkeys per device

-   encrypt the msg for all the subkey of a personal certificate
-   using hw sec key use-case to sync privkey

**let's back, why we need it?**

- the main certificate need to be sync to ease user to communicate

what do we want to archive? - es. gov resistant on border and having
multiple device, sync device with different keys

>> We need multible personas here, and they have quite a range!

We're defining synchronization: how do we make all of our devices to do
the same things?

user preferences - user may want to see the msg in the same way on all
devices

make sync working only for new user it's fair to exclude privkey import
Primary vs secondary device: no, we AGREE all
the device will share same power once linked the device are sharing same
msgs, config, preferences autocrypt has a setup-msg verification we can
use

important challenge : device injection > we need to keep in mind but
solution is difficult

**transport**

1.  sync points
2.  sync protocol (maybe not imap)

|------------------------------------------------------------------|----------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Persona                                                          | Devices                                                              | Scenario                                                                                                                                                                                                                                    |
|------------------------------------------------------------------|----------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Thomas, 43. Germany. Developer, current GnuPG user.   stationary | desktop (Win), laptop (Linux), personal phone (Android)   Retrieving | encrypted email on phone and also on other devices, ability to read messages on all devices at all times                                                                                                                                    |
| Ming, 24. HK. Data analyst, father                               | laptop (macOS), personal phone                                       | Going to a protest, wants to communicate with fellow protesters, but also need to check in on child                                                                                                                                         |
| Olga, 37. Ukraine. Investigative journalist                      | travel laptop, personal phone (iOS), secure phone (iOS)              | Border crossing, one phone confiscated by border agents; still wants to access and send encrypted mails to her editors and sourcese confiscated by border agents; still wants to access and send encrypted mails to her editors and sources |
| Alex, 56. Canada. Job-seeking                                    | public desktop, personal phone (Android)                             | Works at a computer in a public library during the day, wants to send/receive encrypted email at home and at libraryencrypted email in both desktop and mobile contexts                                                                     |
|------------------------------------------------------------------|----------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

### Workshop: Thunderbird & OpenPGP {#Workshop:_Thunderbird_.26_OpenPGP}

Background: The old thunderbird plugin interface is being removed and
with it Enigmail. Thunderbird is picking up
OpenPGP support as core development c.f
[https://blog.mozilla.org/thunderbird/2019/10/thunderbird-enigmail-and-openpgp/](https://blog.mozilla.org/thunderbird/2019/10/thunderbird-enigmail-and-openpgp/)

The statements below are a snapshot of our current thoughts for the TB
OpenPGP integration. Anything said here might
change during the next months.

Thunderbird will do its own implementation (with existing library)
instead of outsourcing to GnuPG to avoid need for complexity
of separate installed application. We need a library that has been
audited, monitored for side-channel attacks etc. Boton and RNP libraries
seems likely to use for actual cryptographic operations.

A large number of past Enigmail support requests were related to
GnuPG setup. About 20 million installations of Thunderbird and
about 300,000 enigmail users. Wants to make
OpenPGP easily accessible for the masses.

Important to have an upgrade path where they, maybe once, maybe more
often, can migrate key material from gnupg to Thunderbird. Initial
import of the old Enigmail/GnuPG keyring.

How will TB manage the key? It might use the keyring storage
implementation of RNP, and use private keyring files that live inside
the Thunderbird profile directory. Thunderbird could protect all secret
keys with the same random passphrase, randomly created by Thunderbird,
which in turn is protected by the existing Thunderbird master password
mechanism, and the associated symmetric key that Thunderbird/NSS already
manage. (Vincent's recent AutoCrypt Add-on
has implemented that idea, and we could reuse that code.)

Christian commented that the existing password storage mechanism in
Thunderbird/NSS is not considered safe enough within BSI, but unknown
why. We're guessing: KDF not using sufficient iterations. (However, NSS
developers currently working on improving that, see
[https://bugzilla.mozilla.org/show_bug.cgi?id=524403](https://bugzilla.mozilla.org/show_bug.cgi?id=524403)
) Also, it is easy to see the passwords in TB if a user has not enabled
a master password and leaves the computer unlocked.

RNP implements a keystore that is GnuPG compatible (they claim
both KBX/g10 and gpg keyring). Thunderbird might potentially use that
keystore format, but will not share the same keyring directory with
GnuPG.

Although RNP doesn't support smartcards currently, a potential solution
was suggested by Kristian and Andre: talking to
SCDaemon (scd) with IPC. Details need to be
discussed, but it would be an optional solution, that only works if the
user has installed software (scd etc.) in addition to Thunderbird. How
would this work? GnuPG as an optional dependency? Outsourcing
smartcard handling to scdaemon (scd), which is available cross-platform
through Unix socket or TCP/IP (windows) with usual user system
protection? Or... extend the RNP library to talk to scd? Needs
discussion and contributors, but that should wait until we're certain
what library TB will use.

Should master password be a requirement for enabling
OpenPGP? Maybe it's better to keep that
optional, as it could be considered too much hassle. Better to explain
it well (e.g. cloud backups of computer files can be used to access
unprotected keys), to motivate people to enable master password.

Very important to ensure that you have a proper recovery method for
private key material so users don't get into surprises if migrating
between devices. (Backup reminder?)

We're under time-pressure, because of fixed Firefox schedules, which
have an immediate impact on Thunderbird. Fully stable production quality
needs to be ready by summer 2020. So initial expectations is for a
minimalistic deployment, it should still be possible to encrypt and
decrypt messages. Code-reviews is a slow process in Thunderbird process
which can require multiple iterations before committing code. Completely
unrealistic to work separately in a branch and getting it merged back
due to fast movement of the main development tree. Intend to work on
main TB development branch, disabled with a pref while it's not yet
usable.

Because of Efail, TB will only decrypt outermost MIME layer,
this will also impact mailing lists (???unclear what this comment refers
to). If doing it like k9mail there is a set of (nine?) MIME
structures that is recognized and will decrypt nested content.

There will not be a Thunderbird plugin-API for other encrypted mail
add-ons in the first version. It was argued, this could make some users
unhappy. However, it was noted, some will also be unhappy because
Thunderbird no longer supporting the old style plugins in the next year
release.

If we use RNP, we'll probably use JS C-types to call the C API from
javascript. The current enigmail is fully written in Javascript and
calls out to GnuPG for cryptographic operations, these parts
will then be rewritten to use a C API instead. The botan library is
written in C++ with a C API for a subset. The botan library uses
exception handling for a great part, which is not allowed in Firefox, so
Thunderbird can only use the C API.

When asked about the future user experience, a comparison was used to
explain it. One group of apps (i) uses a power user UI, which requires
the user to know about the terminology, but has a lot of control over
many details, examples are gnupg on the command line, and Enigmail might
also fit into group (i). Another group of apps (ii) attempts to automate
as much as possible and avoids asking questions. Examples for group 2
could by Delta Chat and Vincent's recently presented
AutoCrypt extension for Thunderbird.

The idea for Thunderbird is to be in the middle between these two
groups. Make it easier than (i), but make less decisions automatically
than group (ii) does. Explain what's happening, involve the user by
make suggestions and ask for decisions (not by prompts/alerts, it's
better to use one screen notifications, which require the user to take
the first step).

One reason for considering this approach, we cannot have a fully
automated solution that also helps the user to remain secure against
active attackers.

The TB integration might have a new UI with wizards etc to automate as
much as possible, but the user needs to actively choose to enable
OpenPGP to avoid negative user experience. See
also a survey from 2015 about enabling e2e encryption, that supports
taking this approach:

-   call for feebdack:
    [https://blog.mozilla.org/thunderbird/2015/08/thunderbird-and-end-to-end-email-encryption-should-this-be-a-priority/](https://blog.mozilla.org/thunderbird/2015/08/thunderbird-and-end-to-end-email-encryption-should-this-be-a-priority/)
-   results of the survey:
    [https://mail.mozilla.org/pipermail/tb-planning/2015-August/004011.html](https://mail.mozilla.org/pipermail/tb-planning/2015-August/004011.html)

Idea: For new users it might make sense to automatically decrypt
(stored) messages on reception to avoid issues with archiving (loss of
access to message archive if key is lost)

Who is using Thunderbird? Someone who wants more control than webmail /
other solutions. This might be a rationale for giving users choices if
they are explained well enough.

Important to learn from the experience of trainers of e2e encryption
that exists already when designing the UX, e.g. how strictly should
terminology be reused? Avoid new terms/explanations?

Suggested that the OpenPGP community could
follow the Thunderbird beta cycle, as a way to learn what Thunderbird is
doing, and allow you to give feedback, while we still can implement
changes before the release.

Thunderbird is based on the enterprise version of firefox that receives
only one major upgrade every year. Support for thunderbird 60 will end
soon. There is an overlap between versions in Thunderbird for 2-3 months
after a new version is released. Thunderbird 68 is supported until fall
next year. Thunderbird 78 will be released in june. After this it is too
risky to keep supporting old thunderbird as it doesn't receive any new
security fixes.

### Workshop: Validation of Digital Signatures {#Workshop:_Validation_of_Digital_Signatures}

1st: timestamps for signature verification
(OpenPGP signature creation time)mps for
signature verification (OpenPGP signature
creation time)GP signature creation time)

-   validate: 1. cryptographic validation of signature and 2. public key
    validation
-   how to present deviations to the user, e.g., signatures in future
    time
-   notmuch: bug in verification (valid signature too old)
-   evaluate at point of time, the signature was made
-   sophisticated attacks on key validations
-   store validation state in email-clients at first time of
    verification (stashed copy)nts at first time of verification
    (stashed copy)
-   expiration date for signatures (defined in
    OpenPGP standard); use cases for that?
-   use case: command & control system based on email (window of
    validity may help)
-   signatures on data versus signatures on keys (latter maybe more use
    cases?)aybe more use cases?)
-   use case: self-expiring messagesing messages
-   what shut be the message shown to the user: "signature becomes
    invalid" (dkg)
-   hard to define the semantics of expiration dates and present
    non-confusing results to the userantics of expiration dates and
    present non-confusing results to the user
-   prefer not to set signature expiration time; only binary state:
    valid or invalid
-   (attack scenarios: stealing an old private key, bundle of messages)
-   other problem: key validity w.r.t. signature validation (trust
    assumptions for key store)
-   mental model of time-restricted validity
-   format for storing keys/signatures for export/import frm MUA
    including meta-dataincluding meta-data
-   what happens if the key has been revoked?
-   stored meta-data has to be more sophisticated ("not only a bit");
    store a MAC to ensure message integrity
-   two modes of validation: on the fly or caching some meta-data
-   how to involve the sender?
-   test vectors/catalog to compare diffrent implementations
-   option/mode for MUA of recipients: demand verbosity/warning level
-   auto-responder, STS-modes of operations of operation
-   UX-issues: displaying warning messages depending on the level of
    user experience
-   issues with MIME multi-part messages (better to consider it
    as one entity having some property or not)
-   warnings for unsigned messages including bad signatures
-   key discovery issues, privacy issues, auto-crypt
-   missing certificate for validation: include the certificate in every
    message to avoid discovery (certificates in email header)

### Workshop: Mail test suite {#Workshop:_Mail_test_suite}

It would be nice to have a corpus of interesting mails. It would be nice
to select a mail from a given corpus with specific properties or to
generate a mail with specific properties as a test suite to test email
clients for presentation of security indicators to the user.

Where to find mail test cases:

-   notMuch:
    [https://notmuchmail.org/](https://notmuchmail.org/)
-   KMail:
    [https://kde.org/applications/office/org.kde.kmail2](https://kde.org/applications/office/org.kde.kmail2)
-   gMIME:
    [https://github.com/jstedfast/gmime](https://github.com/jstedfast/gmime)
-   Academica:
    [https://github.com/RUB-NDS/Johnny-You-Are-Fired](https://github.com/RUB-NDS/Johnny-You-Are-Fired)
-   add more test cases you know

Problems:

-   Different layers (MIME, PGP implementation, etc.) ->
    Starting with the MIME structure
-   Handcrafted vs. generated mails vs fuzzing
-   many layers involved: mbox, MIME,
    OpenPGP

### Workshop: What we learned from EFAIL {#Workshop:_What_we_learned_from_EFAIL}

-   concentrating on OpenPGP specific issues
-   simplest efail attack vector: reply-attack (MUA decrypting payload)
-   enforce MDC usage to prevent insertion of efail-Gadgets
-   what is an encrypted message for a client? don't do mixed encoding
-   turn off/dropping tag 9 support immedately
-   dangerous to have rendered content in front of encrypted message
-   problems with pgp-mime parts e.g. inside the mime-tree; wired
    structures
-   more recent developments: signing issues (presentation at defcon)
-   filter out conditional style sheet rules to encounter that; use
    sanitizers
-   smarter sanitizing rules (e.g. cure53 library
    DOMpurify)
-   modern aproaches beside HTML (e.g. MD) or
    filter out critical CSS parts
-   no scripts (active content)
-   how to show to user, which parts of the message are really signed
-   including signed plaintext parts; should we still support
    pgp-inline?
-   multiple multi-part pgp messages (pgp partions); cf. symantic
    variants
-   reduce the variants of inline-pgp? (default should be a pgp-mime)
-   share DOMpurify-configurations; define a
    reduced HTML-set
-   prefer sending plaintext messages (hard to achieve in an
    HTML world)

### Workshop: Mail STS {#Workshop:_Mail_STS}

#### Different preferences {#Different_preferences}

-   expect valid signatures
-   always encrypt
-   always expect-encrypted
-   always sign

We decided to focus on "expect valid signatures"

#### Mechanism {#Mechanism}

-   Email header
-   Self-sign (in cert)
-   WKD

#### Points raised {#Points_raised}

-   duration (configurable? Start with short one's and iteratively
    increase?)
-   When should signal be accepeted
-   What signalling mechanism?
-   Explicit vs Implicit
-   Presence in WKD? (domain level?)
-   How to change?

#### Semantics {#Semantics}

-   email+certifiacte
-   strictness
-   feedback target
-   freshness
-   auto-generated emails?
-   exceptions: autoresponders

#### Other examples {#Other_examples}

-   OpenPGP header
-   DMARC
-   TLS RPT

#### On violation {#On_violation}

-   warn
-   reject
-   feedback
-   inine feedback

#### Research paper {#Research_paper}

-   About warnings with feedback in case of mails without signatures:
    [Letterbox20018](https://userpage.fu-berlin.de/wieseoli/papers/stast2018.pdf)

#### Followup {#Followup}

-   [https://gitlab.com/dkg/draft-expect-signed-mail](https://gitlab.com/dkg/draft-expect-signed-mail)

### Workshop: WKD {#Workshop:_WKD}

Implementations?

-   Enigmail using Mozilla platform
    XMLHttpRequest,
-   Mailpile uses unchanged behavior of phython urllib
-   Mailvelope uses HTTP GET
-   Kmail/GpgOL - gpg dirmgr
-   Sequoia

List of Capabilities for clients?

-   DNS records
-   HTTP response codes
-   TLS validation errors

Specifics to consider:

-   Some clients cannot avoid HTTP redirects
    (Enigmail)
-   server auth (password) requests
-   blacklists for known failures
-   special cases for non-confirming
-   fall back unclear
-   punycode / ??? A-labels / ??? U-labels
-   consistency across implementations
-   caching (policy vs. keys)
-   should do policy parsing
-   check policy content-type (e.g. avoid consuming a regular web page
    after a redirect)
-   metadata leakage
-   l= padding (request) - avoid that inspection of the request size can
    give a hint about the requested key
-   cert padding (response) - avoid that guesses can be made about the
    response based on its size. Difficult if key sizes vary a lot
-   keyring pollution / filtering
-   size limit
-   what if multiple responses returned
-   catch-all adresses -> generic key
-   expiration/revocation v:a (???) WKD?
-   publisher's responsibilities
-   spec allows the response to be a current key plus a list of
    revocations

### Workshop: Future of SKS Keyservers {#Workshop:_Future_of_SKS_Keyservers}

-   SKS Keyserver updates, the future is Hockeypuck.
-   Written in Go, implements comms with the existing network.
-   Potentially introducing new functionlity:
-   already does cryptographic validation, will be configurable to stop
    searching by UID (but they are still there,
    GDPR not addressed), configured to only let
    people search and fetch by fingerprint. So useful for revocations
    etc.
-   Development is active, work underway: Casey Marshall at Canonical.
-   **Migration plan**: New pool of only Hockeypuck servers. Once it's
    big enough: that becomes the TLS pool.
-   Aside: Once all/most are on Hockeypuck, protocol changes may become
    simpler (reconn depends on MD5 currently, which is bad).
-   **Hockeypuck pool vs. flooding**: Mitigates keyflooding attacks by
    filtering away 3rd party signatures, which means the end of the web
    of trust in its current form. This is configurable, but the main
    pool will make this a requirement.
-   **Dropping UIDs**: (Can keyservers do this?)
    Requirements for UIDs are begin
    relaxed/dropped in 4880bis, so aggressive UID stripping becomes
    feasible. Vincent submitted a patch to GnuPG to allow
    update/revocation for keys using UID-less inputs. Patch not merged,
    because it's not standards compliant. Maybe coming in 2.3.this?)
    Requirements for UIDs are begin
    relaxed/dropped in 4880bis, so aggressive UID stripping becomes
    feasible. Vincent submitted a patch to GnuPG to allow
    update/revocation for keys using UID-less inputs. Patch not merged,
    because it's not standards compliant. Maybe coming in 2.3.
-   **Web of Trust**: The Hockeypuck pool won't be part of maintaining
    the web of trust due to the filtering of 3rd party signatures. The
    WoT can still exist using other channels for exchanging signatures.
-   **1PA3PC**: Discussion about
    1PA3PC (1st party attestations, 3rd party
    signatures)... within scope for Hockeypuck or no?
-   **Key Discovery**: The move to filtered Hockeypuck means SKS no
    longer is useful for key discovery, its usecase becomes only updates
    to keys (including revocation) the user already has.
-   **Policy**: The pool implements and enforces policies (servers can
    be asked about their config), current plan is for policy to be as
    above.
-   **Hagrid & SKS**: discussion about how Hagrid (keys.openpgp.org)
    interacts with the SKS data set, potentially communicating directly
    with the pool, discussion about APIs for subscribing to
    changes, segway into the Keyserver Update Manifest topic.
-   **Padding**: Discussion about the relevance of padding to keyserver
    queries/responses, to mitigate data leakage to the network.

### ​Workshop: Symmetric key​​​​​​ re-encryption of archived ​​​​​​​mail {#A.2BIAs-Workshop:_Symmetric_key.2BIAsgCyALIAsgCyAL_re-encryption_of_archived_.2BIAsgCyALIAsgCyALIAs-mail}

-   define new subkey type which wraps a symmetric key (i.e. AES)
-   re-encrypt data packet session key with this symmetric key
-   new key packet or reuse existing?
    -   Need to ensure random IV or keep S2K
    -   Don't need to keep S2K, maybe better to not have it
        (cryptographically questionable?)
    -   Use AEAD? (Yes), should use new V5 packet
-   what about nesting/mixing current Asymmetric with Symmetric?
    -   if AES is screwed, we're all screwed
    -   speed
    -   mixing stuff maybe doesn't buy you much and introduces
        additional complexity
    -   counterpoint: you could screw up AES implementation
-   V5 session key include random IV
-   can V5/V4 data packets work with the other version session key
    packets?
    -   We think yes but need to check with implementers
-   Can restrict new subkey to V5 keys only?
    -   Need compatibility for V4
-   Leakage to keyservers?
    -   A risk, no one respects no-export
-   Chosen plaintext attack against AES with attacker-chosen session
    key?
    -   AES resistant to this attack with appropriate IV
-   Could you adding signing (HMAC) with it
-   You could add signature verification status/timestamps etc. to
    either AEAD AD or inside the encrypted
    blob...
