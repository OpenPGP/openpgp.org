---
title: "Summit 2022 Notes"
permalink: /community/email-summit/2022/minutes/
---

{% include toc %}

This page documents the notes that were taken during the [6th OpenPGP
Email Summit](..) which took place 2022-05-27/28.

## Plenary talks {#Plenary_talks}

### PQC plenary {#PQC_plenary}

Stefan: What about implementing both composite and composable? -> To a
session

Justus: How many combinations are there? 2/3 KEM, 2/3 Signatures mixed
with ECDH

Discussion moved to a session.

### WKD Usability Plenary {#WKD_Usability_Plenary}

Neal: WKD fetches its trust from a centralized solution, namely TLS CAs

## Workshops {#Workshops}

### Automatic Forwarding {#Automatic_Forwarding}

-   Elliptic Curves allow transforming ciphertext from one asymmetric
    key to another via a multiplication on the curve
-   Lattice-based post-quantum crypto also seems like it would allow
    this (Also hybrid with ECC) But we should check (and for which
    algorithms)
-   Q: What is the problem we want to solve? A: Forward messages
    (temporarily as a mailing list) securely, in a standardized way, so
    that you can forward to other providers
-   Q: Where does the MTA get the forwarding parameter? A: Out of band,
    uploaded to the server
-   Justus: how could we change the OpenPGP
    spec to facilitate this
    -   Remove the fingerprint from the KDF
        -   Check whether there was a reason in the original spec to add
            it
    -   Define an algorithm ID for X25519 (without the fingerprint in
        the KDF)
    -   Wait for PQC?
-   Vincent: if the server signs up for a mailinglist, they get access
    to all emails retroactively
    -   Aron: for ProtonMail, the proxy is
        ProtonMail, and the participants
        are users, but in general this is true
    -   This can also be used for access lists
-   Risk: forwardee's key should be marked, such that it's not used
    for encryption, because otherwise the forwarder+proxy can read it
    (since the scheme works in both directions)
-   Justus: rapid key rotation might solve this as well (by giving a
    temporary key to the forwardee) Aron: but then you have to plan it
    (potentially long) in advance
-   You might also want to forward to yourself (multi-device?)
-   You could compute a transformation parameter between two arbitrary
    keys by generating a third key and computing the parameter between
    both pairs
-   Daniel: don't put encryption key flags, add a new decryption key
    flag
-   Justus: non-exportable binding signature

Next steps:

-   Check for motivation of fingerprint
-   Check whether it can be removed
-   Check whether PQC supports this, and which algorithms
-   Check the timeline for PQC, whether it's worth doing something in
    the meantime

### Reducing UX Complexity {#Reducing_UX_Complexity}

(session 1, friday 13:30 main room)

Facilitated by Nami

Nami:

-   security trainings with activists
-   Autocrypt

Marin:

-   mobile app with Proton
-   advanced users want fancy knobs, but other users want simple

Nora:

-   i'm a user, interested in thinking through different workflows

Falko:

-   introducing new features/algorithms, how do we keep the UX simple,
    but provide details for folks who need it.
-   what are the choices?

Neal:

-   continuum of needs, not always solved by hiding things
-   visibility into the security is necessary for some parts of security

Paul:

-   i'm a library developer.  my users are developers
-   we need to think about usable libraries, not just end-user tools

Bart:

-   Proton sees a spectrum of needs.
-   can we show folks what they need without confusing them?
-   negative signals about unsafe, vs. positive signals when things are
    safe
-   how do we evolve the ecosystem?
-   we want regular workflows to be ignored, with problems highlighted

Chris:

-   intevation wants to improve usability
-   different target groups have different requirements
-   can we have profiles in a MUA for different needs?

Stavros:

-   There exist secure, unusable products (3 months training)
-   i'm a fan of Threema's color system, which visualize the
    authentication status of public keys

dkg:

-   why can't lawyers do this?
-   API usability is also interesting but shouldn't be the focus here.

Lars:

-   encrypt everywhere
-   i've been doing it since 92 but clearly failing

Kai:

-   different users, how do we satisfy all of them?
-   Thunderbird is struggling with this
-   Autocrypt seems too risky for small groups of activists
-   make it easier to compose e-mails, obtain keys, decide about keys,
    etc.
-   interested in input

Patrick:

-   we didn't progress a lot over 20 years; we're still stuck in "you
    have to be an expert"
-   we need to change that.
-   Enigmail dealt with UX over the last several years, and we should
    have done that better.
-   we've been too focused on experts and activists and forgot about
    the mass of users
-   opportunistic encryption would be great

Lara:

-   i work on libraries as well
-   API usability carries over into UX failures

Nami:

-   deltachat uses autocrypt
-   no mention of keys
-   everything is opportunistic, with one exception: there are
    "verified groups"
-   i have more key verifications because we have these groups.
-   i have three different users in mind:
    -   masses who don't really need encryption
    -   activists who do need encryption, and are in group conversation
        (activism requires group conversations)
    -   experts who have sensitive one-on-one conversations (lawyers)
    -   "nerds" (technical experts)
-   can we synchronize use cases across implementations

Bart:

-   challenges the idea of "people who don't need encryption"
-   if we accept that premise, that makes everyone else more targeted
-   please don't "if i'm not doing anything wrong i don't have
    anything to hide".  this is a systemic risk

Patrick:

-   the point is to adopt the individual's perspective

Bart:

-   we don't poll people whether they want https.  we just deployed it

Kai:

-   maybe the first group is "people who don't want to be bothered
    with any encryption details"

Nami:

-   remember that the autocrypt session is a different one; i'd like to
    learn about that separately.

Paul:

-   i don't want a different user interface for different users.
-   can we think through a single user interface that works for all of
    them?
-   browsers "just work" but users can dig deeper.

Kai:

-   will it be additional information or actions required?

Neal:

-   if we should do opportunistic encryption for the masses, there will
    be unreadable messages.
-   the tools of security improve opportunistic encryption; the more
    that a certificate is authenticated, the easier it is to do the
    encryption.
-   an ignorant user can make use of authentication mechanisms for a
    certificate to be confident

Nora:

-   how does key certification work for the Airbus problem?  the keys
    were authentic

Bart:

-   we ended up having unreadable messages when we tried to enable
    autocrypt headers
-   ultimately, multi-device key management is what we sell
-   we don't support other non-Proton MUAs,
    because that kind of management is tricky.

Patrick:

-   you've found a solution that works across devices, that's
    compelling

Paul:

-   a fundamental issue is secret key and public key management

Nami:

-   we want to transfer secret key material via QR codes
-   we might also want a hack that identifies whether other
    MUAs are attached to this mailbox
-   maybe this is worth following up with on the multi-device session

Kai:

-   sounds like key management is a big part of the UX
-   we have a list of pain points we could share

Nami:

-   matrix error recovery is worse

UX pain points

-   secret key management
-   public key management
-   visibility into {encryption,verification} -- for
    {composing,receiving,replying}
-   unreadable mail
-   error recovery
-   key verification flows

possible solutions:

-   TOFU
-   key transparency

Nora:

-   semantic vs. technical details
-   semantic: "your peer might have changed devices"
-   technical: "your security number changed; here are two
    fingerprints."

Nora:

-   received unreadable mail: "did you install autocrypt on some other
    device recently?"

Patrick:

-   "semantic" is the mindset we need to move toward

Bart:

-   maybe PGP/MIME preamble sometimes says technical detail --
    could we put something in here?

Kai:

-   preamble is problematic because it's not localized.  it should be
    the UA's job to figure out what to say

Bart, Patrick:

-   but you don't control that UA. when you send, you have to prepare
    something for the legacy clients.

Lars:

-   if the message is in english, people can feed it to Google
    Translate.

Kai:

-   Thunderbird should do that if we get a message that we can't
    decrypt it.

Nami:

-   we have these four user personas.  can we flesh them out more?
-   can we find someone to do these interviews?

Kai:

-   we have a lot of feedback about Thunderbird disappointments for
    activists, we could talk to UX experts
-   20-30M of daily users of Thunderbird; minor telemetry.
-   we count a few different stats of users:
    -   encrypted S/MIME messages is lowest -  5800/week
    -   encrypted PGP/MIME is next - 14400/week
    -   signed PGP/MIME messages are next - 59000/week
    -   signed S/MIME is huge - 1.27M

Patrick:

-   at end of engimail, there was 400K active users
-   mailing lists

Bart:

-   monthly active is 10 million
-   not all of them know that they

notettaker: dkg

### Multi-Device {#Multi-Device}

facilitated by dkg, notes by nami

Use case: multiple devices, some of them are openPGP-capable.

Different problems:

-   Unreadable messages on non-openPGP devices?
-   How to synchronize secret keys between devices?
-   also, how to synchronize public keys between devices?
-   additional privacy concerns?

Another problem is time-critical synchronizing, e.g. for revocation
certificates. clock-sync is a problem, as many users have devices with
wrong timezone settings. This leads to invalid signatures. 0.5-1% of
protonmail users are affected.

Delta Chat wants to implement a flow to synchronize the secret key, the
public keys, and all the other stuff during the setup flow on the second
device

Protonmail has it easier because they control the server, but most
clients can't do that. -> let's assume that we can't use the
server for syncing this data, beyond IMAP

You could use an IMAP folder to synchronize the
secret key, but the server might interfere with the transferred keys.
Another option would be sharing the keys over a p2p connection, as long
as both devices are in the same WiFi

Autocrypt Setup Message in spec level 1 transfers at least the secret
key, symmetrically encrypted over IMAP - but it
is no full solution to the problem

-   problem: to synchronize data between devices to bootstrap a
    transfer, you need to transfer a key from one device to the other,
    so it needs user input.
-   this can also be the user scanning a QR code
-   alternative: when both devices are online the same time, the user
    only needs to compare two images/emojis or so, because you can
    transfer a secret in a short round trip
-   something with "let's do this via encrypted, signed git commits"?

We need some complexity for technical reasons and we need some
complexity to accomodate users, but apart from that we should keep
complexity low and don't support every edge case. Users understand that
some things don't work and tolerate that

Some users have one mailbox for multiple email addresses, and different
keys for those addresses

Data we might want to sync:

-   who are my peer devices?
-   secret key material
-   public keys, including the verification status (e.g. where the key
    came from and how it's verified). might be keyrings

If you have more than one encryption subkey, there are some clients out
there which will only encrypt to one of your subkeys. You will get
unreadable mail

### Symmetric re-encryption {#Symmetric_re-encryption}

-   Use-case: encrypting messages symmetrically for archival with a
    "managed" key stored in a keyring
-   Semantically equivalent to re-encrypting with an asymmetric archival
    key
-   Faster, more secure, especially against quantum computers
-   Justus agrees with the use-case
-   Proposal: define a "public-key algorithm"
-   Fingerprint is useful for referring to the key in the
    PKESK
-   Computed over the "public key packet"
-   "Random" value or CMAC of the private key
    in the public key for the purpose of the fingerprint
-   Retcon public key encrypted session key -> key encrypted session
    key
-   Maybe symmetric key encrypted session key -> password encrypted
    session key
-   But: will cause churn and may not be worth it
-   Also "symmetric signatures" using CMAC
-   We have a draft proposal, and experimental implementations

### Distributed verifying keyservers {#Distributed_verifying_keyservers}

facilitated by Patrick, notes by Nora

Patrick: Distributed keyservers are gone in practice, we basically have
one verifying keyserver

Problems (of single-instance verifying keyservers)

-   Single point of failure
    -   Technical reliability
        -   operator
            -   domain/DNS
        -   organizational resilience (bus factor)
-   no (key) transparency
-   trackability of users
-   no resistance to blocking attempts by network operators
-   lawful interception/enforcement
-   ecosystem acceptance
-   funding stability

Vincent: Decentralization looks like a solution to these problems, but
it is not.

Technical Reliability

-   can be achieved differently, e.g. replication

Organizational Resilience (bus factor)

-   At the moment, the number of persons who need to leave k.o.o to stop
    the    service is 1
-   Vincent: We want to increase the bus factor of the project. Have
    more people    who have access to backups and DNS, those two parts
    suffice.    Phil Zimmerman currently controls DNS.
-   DNS: One solution would be to use other domains, served by the same
    server.    Kai: Use a fallback domain, as a backup for mishaps with
    main domain    Vincent: Agreed

Funding:

-   Vincent: should not be a problem, is currently funded for by OTF

Transparency

-   Patrick: We currently do not have key transparency. But it's
    requried for    federation.
-   There are two types of federation, open and closed. SKS used to be
       open, the HKPS pool was closed. Open
    federation is incompatible with a verifying    keyserver, a minimal
    amount of trust is needed. Also, it would allow key enumeration,
     which we need to prevent.
-   Kai: Who decides which keys get listed? Require the user to
    demonstrate    control of the secret key, keep proof of ownership,
    e.g. encrypted mail message.
-   Vincent: We do not encrypt the outgoing mail from k.o.o, that would
    only    defend against attackers who do not control the secret key.
-   Kai: Maybe require DKIM?

Trackability of users:

-   With SKS, you could just run a server and get most of the key
    updates
-   Getting Key updates at the moment leaks a user's entire keyring  -
    Vincent: there's a technical measure to mitigate, update manifests

Ecosystem Acceptance:

-   The ecosystem is attached to the SKS model of federation

Most problems hinge on project governance, discuss in that session.

### Post-quantum crypto {#Post-quantum_crypto}

-   Composite
    -   Advantage: people will hopefully not use disallowed
        combinations, or at least use a "private use" algorithm
        instead
-   Composable
    -   Advantage: easier to use a new combination
-   Q: How many algorithms do we expect NIST will
    standardize? A: Most likely at least 2, possibly more
-   Q: What's the advantage of composable? A: Code point exhaustion,
    and FIPS compliance
-   But: NIST has announced they will standardize
    the CFRG curves
-   (Discussion about Brainpool curves in the crypto-refresh)
-   Other possibility: fixed PQC algorithm + ECDH
    -   Stavros: we'd be fine with that
-   Discussion about signatures
    -   Neal: signatures can be independent / backwards compatible
    -   Falko: but as a policy, eventually we should reject pre-quantum
        signatures

### Autocrypt {#Autocrypt}

facilitation: Vincent

notetaking: dkg

-   is autocrypt still worthwhile?

Vincent: we tried, but in 2020 the project flagged

Patrick: change is probably when thunderbird replaced enigmail

Vincent: I want to advocate for things that can go someplace. are there
goals we can set that would revitalize it? can we identify what went wrong?

Patrick: autocrypt isn't as necessary because of keys.openpgp.org

Bart: does thunderbird have automatic WKD support?

Kai: we look on wkd and on keys.openpgp.org to discover keys in a future release, we will have an easier "find keys online"
mechanism. as soon as we discover a key in an e-mail, we add it to the
cache, and that cache will be in the "find keys"

Nami: my experience is entirely different. in the last week i had two
problems encrypting to people, where i couldn't find the keys. users
of enigmail can't figure out what happens when the keys break, etc.  As a deltachat user i can't communicate clearly with protonmail
etc,

Bart: for the corporate domain, we haven't deployed WKD

Vincent: if deltachat doesn't do WKD or talk to k.o.o, then it might
not be an autocrypt problem

Bart:

dkg: autocrypt avoids metadata leakage; wkd and k.o.o lookups leak
metadata to the

Kai: i didn't do autocrypt because i don't like the idea of
automatically accepting keys. I still like the key exchange. Tbird
always sends outgoing autocrypt headers if your key has only one user
ID, and if the public key is attached to the message. at the time, i
wanted people to really opt in before sending the key. I would be
willing to reconsider automatically sending the header.

Bart: we're concerned about the auto-accept behavior. today, we read
autocrypt headers, and if you can pin keys (advanced setting) we offer
it. We're not willing to do auto-accept. We don't ship autocrypt
headers automatically, but we could.

Kai: another Problem is the auto-replace behavior.

Bart: we're also concerned that if a user replaces their key. In order
to encrypt later, we are looking up WKD and other stuff. If it is a key
that doesn't match, we run into conflicts; and one of the concerns we
had was that it wasn't clear how fresh the key was.

Vincent: in terms of freshness, are you more concerned about downgrade
to cleartext, or about key updates?

Bart: we're more concerned about key updates; using an old key is bad,
when the autocrypt-using recipient has changed their key since then and
we haven't gotten it.

dkg: well, Autocrypt stores a timestamp, when the key was last seen.
Implementors can use that to reason about whether to use that?

Bart: yes, but who does that? What to draw from that? [not sure if
that was the point *n]*

dkg: yeah, then the spec is lacking, we should put that in the spec.

Patrick: we could:

- set a time window at which you should refresh

- broadcast key exchanges

Vincent: because autocrypt is inband, it can't do updates or refresh.
autocrypt doesn't do

dkg: we could specify: if an autocrypt key is older than X, you should
use a different key discovery mechanism to check whether the key is
still fresh (WKD, keys.openpgp.org, ...)

patrick: we could also ask the user in that case: "hey, the key is
pretty old. do you want to use it or send unencrypted?"

Bart: DKIM has an expiration parameter, almost
nobody uses it, but we now use it

dkg: the openPGP spec has that in it, there are also expiration dates.

Bart: yes, but we can not rely on users logging in and updating their
stuff, in that way we are abusing that spec.

dkg: one of the basic things that an openpgp implementation needs is to
be able to refresh a key

Vincent: key expirations are "hard" in some sense -- i think we want
something softer.

Bart:

Kai: if autocrypt would remove encrypt-by-default and key replacement,
we could adopt it.

dkg: autocrypt is not encrypt-by-default, prefer-encrypt mutual

Bart: another problem which a freshness guarantee would resolve: if a
protonmail using organization with a custom domain moves their domain +
email to gmail, they would keep receiving encrypted email they can't
decrypt because we sent out autocrypt headers with prefer-encrypt=mutual
for them for a while.

dkg: autocrypt is a mechanism that proposes keys; if you have different
keys that you want to prefer over autocrypt, that's fine.

Patrick: seems like most of what's in Autocrypt seems fine, but it
needed some time for people to "ripen" on it.

Vincent: we might want to improve the spec in some way to clarify things
like expiration, integration into other parts.

Nami: When we wrote the spec years ago, I was often thinking "yeah,
that is an unconventional approach, but there are no real reasons
against it" - and I think this is why we are having many of these
discussions now :D maybe it just needed some years to ripen, until the
ideas were accepted by more implementors.

Vincent: adoption has some chicken-and-egg issues

Kai: what if we want proof of posession for freshness?

Bart: we could just spec this out -- a signature or a header

Vincent: i'm not convinced that this is meaningful. the header is
either there or it is not.

Bart: i expect that clients do WKD lookups for freshness. we cache WKD
keys for a limited time and then do additional lookups. I am very
sensitive to users getting messages that they cannot decrypt. any flow
that results in unreadable messages .

Vincent: this was part of autocrypt. we wanted to protect against
unreadable mail, that's the whole reason for the prefer-encrypt
setting. It's only supposed to be turned on by users who are confiy
will be able to decrypt email, and want others to send encrypt email to
them.

Bart: could Autocrypt headers include a freshness parameter?

### SOP {#SOP}

-   A wish for SOP is that all linux system would come with a binary
    that implements sop and programs would use the sop interface instead
    of a specific implementation, also makes it easier to read this
    could allow swapping libraries: need to evaluate if it's something
    we need
-   Having a separate interface for keystores operations that could be
    combined with sop    Sequoia has a project planned for that
    pgp-cert-d Improvements:
-   SOP could do certificate validation
-   SOP coulld edit keys, create revokation certificates
-   offer a json interface for programatic use of sop
-   do key server operations: wkd and key server
-   use keys in other things that files: cards yubi keys
-   could be expanded for security research, see which implementations
    or combinations are vulnerable to a scenario
-   interfacing with keystores
-   web of trust operations: is a key signed by another key AI:
-   open tickets on the sop gitlab for features

dkg: invite participation and contributions and threatens people to make
them the primary author of the SOP spec

### Header Protection {#Header_Protection}

dkg: Work in LAMPS for S/MIME, claim to
have it but noone does it, signed message: body signed, header is not,
in transit header will leak, how do we get crypto protection on headers,
how do we send messages with such protections without breaking
communication, idea in LAMPS: wrap header inside
protected area and put outside whateever you want to be in the
unprotected header part, two proposals: wrapped messages vs. injected
headers, header confidentiality vs. authentication different stories,
HCP = Header Confidentiality Policy = Rule what do i do on the outside
headers, hcp_minimal vs. hcp_strong, we want to recommend
hcp_minimal in LAMPS

patrick: hcp_strong lacks reply to

dkg: there are a lot of issues with hcp_strong

paul: how do you communicate those policies

dkg: you don't have to communicate them, with hcp_minimal it's
protected in authenticity, confidentiality only 'Subject', In general
reply is a complex process, with injected headers a legacy will not see
the subject line and you will loose the subject line, we gonna do a
'legacy display element' which will include the subject line in the
first line of the message body

patrick: we are back to our initial idea

stefan: altering the message body vs. including an attachement

dkg: including attachement, no one will read it, 'legacy display
element' is a choice to not break existing implementations, if we are
not doing encryption there is no need for 'legacy display element'

daniel: you can alter the `<div>` when you send to multiple users, like
'send 1000$ to..."

stefan: there is a problem with striping

patrick: if you have a multi-part message the text plain and html can be
completely different, clients who understand the protected header, it
sucks since you have to work on the div part

daniel: the client should check whether there is a match with the
protected header, if you don't do that then this system is not secure

dkg: proposal ist better then status quo, idea is to deploy it and once
adopted by implementations turn unprotected headers of

patrick: initially there was a legacy display element in enigmail but we
removed them, there were complaints about that

dkg: we didn't thought how this will be received by legacy clients
(turn on feature flag) with openpgp assume the receiveing client is not
legacy

kai: todo item: research what is our report about bugs and lost subjects

daniel: maybe the openpgp ecosystem is in a better sitaution, since if
your are sending encrypted pgp mail, then assuming by default that
receivers are not legacy might be a good choice

dkg: wrinkle 1:write consuming code first so people can handle incoming
messages, but you have to write the producing code also since you have
to consider replys, you will have to deploy both code bases together,
wrinkle 2: how do you represent that the message was signed (replay
attack), subject in the body is signed but the subject line is not? you
would like to distinguish between unprotected header messages and
protected messages

patrick: present in details the protection status

dkg: reminded of mixed browser content

daniel: UI display two parts, 1: subject/To/From and 2: Body. Maybe
present a lock beside the protected parts

patrick: is it necessary to present such detail to users or just simple
"fully" or "partly" protected

dkg: how do you represent a distinction between signed and
encrypted+signed

kai: preference show a signature sign next to header information,
instead of "not signed"

dkg: until 2024, say, maybe in detail body signed/header signed
independently, after 2024 if the header is not signed we don't sho that
the message is signed, you don't sho the headers that are not signed,
the LAMPS group will probably not write a
guideline for UI guidelines

dkg: wrinkle 3: encryption: some headers will leak, how do you indicate
this - maybe you don't. but when you reply you have to make sure that
confidentiality is preserved, an MUA has to keep state

kai: automatically encrypting the body in replys, but headers are
encrypted according to local default and not incoming message - i'll
take this with me, we thought about how to indicate that the body will
be encrypted and as well for the subject -

dkg: how do you know that the subject was confidential? look for the
string '...', how do you know if the subject on the unprotected
outside is the same as the protected inside

### Pretty Good Forward Secrecy / Deleting Messages {#Pretty_Good_Forward_Secrecy_.2F_Deleting_Messages}

DeltaX presentation:
[https://sequoia-pgp.org/talks/2018-08-moving-forward/moving-forward.pdf](https://sequoia-pgp.org/talks/2018-08-moving-forward/moving-forward.pdf)
Secret chats:
[https://support.delta.chat/t/off-the-record-chats/1181/9](https://support.delta.chat/t/off-the-record-chats/1181/9)
Signal protocol aka Double Ratchet:
[https://gitlab.com/sequoia-pgp/openpgp-dr](https://gitlab.com/sequoia-pgp/openpgp-dr)

2 approaches.

justus: 1st approach, not PFS, but works now: rotate encryption subkey
often, e.g. once per week. Generate them in advance, e.g. for the next
year, lie about creation time, expire 1 week after creation time. It's
okay supported by the eco-system.

lars: how frequently would that be changed?

justus: it puts a bit of a strain on the certificate update process.
with k.o.o it works okay, with autocrypt it's not so nice...

lara: key size should not exceed a certain size, and the timeframe
shouldn't be very small.

justus: there are two parameters to think about. how long are messages
in flight? when am I willing to delete a subkey? but it's still a good
idea. even if you do it monthly.

nami: maybe if you encrypt to the new key *and* the last key, it
would be easier to digest for autocrypt. if you only rely on autocrypt
to do key discovery, you could get a lot of unreadable or unencrypted
messages between key cycles.

justus: with overlapping key validity time frames you can express the
desire about during which time you want others to use a specific key.

nami: Delta Chat announces a "self-destructing messages" timer with a
specific header; this could also be used to announce *my*
ephemeral key. downside: this only announces *my* ephemeral key,
not those of the others.

justus: there are two different topics: confidentiality + deniability.

nami: is there a use case for plausible deniability?

lars: in a company I know there was a policy that it was forbidden to
invite someone for lunch in cleartext.

justus: the 2nd approach would be the signal approach, a ratchet
protocol. I have a prototype for that; you don't have long-term
encryption material anymore, but you derive the ratchet from the last
messages.

lara: and the first message/first key exchange would be a long-term key?

justus: yes, I'm doing it a bit like that, I upgrade a conversation
encrypted with long-term keys by offering a Diffie-Hellman parameter. I
generate some pre-keys, they are used, and when the pre-keys are
exausted, you can reuse a pre-key. OMEMO can do
this because they are in an always online situation. we can only upgrade
a conversation to PFS.

lara: if an attacker recorded our whole communication including the
first message, they could reconstruct the keys, or not?

justus: no, because it is a diffie-hellman exchange. we can do that even
in the clear.

justus: it would be really cool, but it would be a huge paradigm shift
for PGP. suddenly there would be a lot of state to keep.

lara: yes, and the question would also be, do we really need it? if
it's just about deleting short-lived messages, the 1st approach is
totally fine.

lara: the timeframe for

actions items for 1st approach:

-   what are plausible validity periods?
-   how long in the future can I publish keys?

lara: with WKD, you can also just ask "I need keys for this time
period", because you can more easier ask for more keys later.

lars: I think it would

justus: we kind of do have that, a certificate can have a URL where I
can look to updates for the key. But I mean, we are in the interesting
position that we can change both the openPGP standard, and the existing
important parts of the openPGP ecosystem.

justus: so what are the user's expectations? users expect to be able to
read their old emails. So having symmetric re-encryption would be an
important pre-requisite. so you could have a long-term symmetric archive
key; but we need to ask the users about that.

justus: the other aspect is multi-device support. If you go with the 2nd
approach, it gets a lot worse; OMEMO & Signal
have per-device ratchets, so they have per-device keys, and ratchet
between them; so you change the state all the time, between all of your
devices.

lara: I think it's really not a nice experience to do double-ratchet
between all devices. if you don't turn on your laptop for months, you
lose messages.

justus: protonmail has it easier, because the same server stores the
messages and the key material.

lara: and we also don't care about per-device keys. that makes it
easier.

nami: for autocrypt it would be a lot of constrain, because the
autocrypt header would become very large. maybe sending the large key
initially to try to upgrade to PFS, but only sending the smaller
long-term encryption key in the subsequent messages could solve that; in
any case the encryption could still downgrade to non-PFS openPGP.

nami: it would still be nice to have a long-term key to downgrade to.
could attackers downgrade that?

justus: there are different flags in the openPGP standard. you can flag
a subkey as long-term, and another as shorter (?). The support in the
ecosystem is poor though; most just flag a key with both flags.

lars: we could offer a test suite for this!

justus: we could create a recommendation, "this is a good set of
parameters you need for PFS with openPGP, if you implement it like that
it works nicely". Then implementations can adopt that. There are some
user-interaction questions also, but hopefully UI can be kept to a
minimum.

### Certificate Validation / Certificate Discovery {#Certificate_Validation_.2F_Certificate_Discovery}

Session Leader: Bart

Key retrieval and precedence for how we should do key retrieval.  Key
freshness is for another session.  Is there a consensus for precedence
for different sources?  What degree should we trust different sources?
What can you do automatically?  What can you do with some user
interaction?

Note taker: Neal

Table (see photo):

WKD Autocrypt Inband Attachments Key servers Keys.openpgp.org Manually

Chris: Does inband count?

Bart: Yes.

Nora: Question is: what if you don't have internet access at time of
message composition, but only autocrypt?

Vincent: We can discover information / certificates from messages we've
found along the way.

Bart: Do we all agree that manual trust of a key takes precedence over
everything?

All: General agreement.

Neal: What if the manually trusted certificate is expired?  Do we
fallback to no certificate or a different certificate?

Bart: Today, we prompt the user.  We don't silently overwrite a manual
pin.  We need user input.

Vincent: There are several dimensions that we should consider: meta-data
leaks, etc.

Aron: WKD leaks to the domain owner, but the message will likely be sent
to the domain owner anyway, so there is no additional meta-data leakage.

Neal: We may not want to try sources in order of preference until we get
a positive response, but try multiple sources and to also check if they
conflict (multi-path validation).

Vincent: Some sources may return multiple certificates.

Neal: We should add a row to the table for certificates that can be
authenticated via the web of trust.

Aron: This is about discovery, not authentication.

Nora: To be sure: when we are talking about low user interaction, we are
talking about user interaction during message composition, not uploading
the certificate?

All: yes.

Vincent: What do we mean by freshness?  Do we think that a user is more
likely to keep a WKD entry more up to date than an entry on a key
server?

Neal: My experience is that WKD is a reasonable way to do key discovery
(i.e., by email address), but to find the current version of a
certificate, I look up the certificate (by fingerprint) on a key server.
 It's generally easier to upload a key to a key server than to update a
WKD, which is often ad hoc.

Nora: I would like to list other disambiguation mechanisms, e.g., WoT,
timestamps, etc.

Aron: WKD's meta-data leakage is not high, because it doesn't leak
more than the message that will eventually be sent.

Vincent: That's not quite true: the WKD client may be different from
the server that sends the message.

Vincent: Autocrypt has no meta-data leakage.  Key servers and
keys.openpgp.org leak a lot of meta data.

Bart: I'm worried about keys.openpgp.org taking precendence over WKD.

Vincent: A message with an autocrypt header that is
DKIM signed is pretty reliable.

Bart: If there is guidance about preferring WKD, then perhaps users who
are unable to keep their WKD entry up to date shouldn't use WKD.

Neal: If there are multiple certificates, it may be better to just use
all of them rather than possibly choosing the wrong on or none.

Vincent: It depends on the context, I wouldn't do that for keys that
only come from the public key servers.

Bart: We perhaps shouldn't consider attached keys, as people often echo
back my attachment.

Vincent: You do that when the user id doesn't match the sender?

Bart: That's actually a bug.

Aron: But there are also aliases that we want to support, like gmail dot
aliases.

Neal: I think it is useful to consider attachments.  We can include
private WoT information (new state for a certificatation where a
certification can be exported, but is not allowed to be published in a
public directory).  If we use the same certificates as the original
sender in the thread, then recipients can decrypt all messages in the
thread or none.

Bart: Per-thread decisions introduces new failure modes, which are
confusing.

Aron: When the user receives a message in Proton with an autocrypt
header, they are discretely given the option to pin the certificate.

Bart: We once considered caching all autocrypt headers ever seen and
using that database for looking up certificates for all users.

Vincent: That is a good idea if we only consider
DKIM-signed autocrypt headers.

Vincent: We should come up with an algorithm to run through these
different methods.

Bart: I'm biased to doing something extremely simple.

Aron: If you find a certificate at method rank N, we should probably
keep looking until N+1.

Nora: The ones with low meta-data leakage should always be done.

Bart: autocrypt with freshness we can do; autocrypt without freshness is
not a good idea.

Bart: Freshness should be defined by the sender.

Vincent: The freshness criteria can be defined by the owner of the
certificate rather than the sender.

### PQC Signatures {#PQC_Signatures}

aron: in pkesk makes sense to have single kem-algorithm, signatures
instead have a different security model

stavros: in kem you have an AND combination, in signatures it is a
question if you want AND or OR combination

aron: 1. Option: composite stuff, need to verify both, 2. Option:
PQ-Signature as a single-algorithm as drop-in replacement

stefan: are we concerned with signature verification for messages that i
have received a long time ago. is there a need for combined signatures
(classical+pq)? maybe the complexity

daniel: risk, if the signature algorithm is broken

falko: everyone has to decide when he enters the post-quantum era, at
the time of verification I have to decide - is this signature valid

aron: there is a case for long-lived signature validity periods ->
certificates,

stefan: we have two problems, the key binding signature and message
authentication, I can republish a re-signed key

aron: I would better feel to put PQ-Sigs along with (EC/Ed)DSA, bind
e.g. Dilithium to (EC/Ed)DSA but have SPHINCS+
as a single algorithm due to strong security

daniel: bad use case for key generation, people request a key for WKD to
find out if account exists, we randomly generate a certificate, with
SPHINCS+ performance characteristics this
might be a burden

aron: content signatures are easy to do with composable signatures, but
self-signatures are not straight-forward

stefan: two certificates

aron: two certificates web-of-trusted to each other

stefan: you cn re-sign your old key material with your pq-certificate

aron: would you like to standardize e.g. Dilithium alone

stefan: from an implementer point of view it is better to have very
strict and narrowed down algorithm specification, arbitrary combinations
are difficult to cope with

aron: (EC/Ed) are fast and small, SPHINCS+ for
e-mail in not-contrained environments are not so bad from signature size
point of view

daniel: yes, preference, ecdsa is not as messy as ecdh
implementationwise. Is ecdsa necessary along eddsa

aron: idea kyber+ecdh where you can enter the oid of a curve, if
brainpool does not end up in the standard, then there might be no case
for ecdh

daniel: if you make the case on the mailing list fro brainpool curves,
still, ECC is a just fall-back when introducing PQC

falko: is it still in consideration to have multiple signatures on the
protocol layer

daniel: the semantics of multiple signatures is a logical OR, it would
be difficult to

aron: we could propose to add kyber+x25519 and
kyber+NIST-curves and kyber+brainpool and
likewise for signatures and the working groups decides

### keys.openpgp.org Governance {#keys.openpgp.org_Governance}

Facilitator: Vincent note-taking: dkg

Status quo:  hagrid as a software project and koo as a service are
pretty much identical;  hagrid is explicitly branded internally.  hagrid
is explicitly not maintained as deployable software.  If there's a
reason to change that, we can talk about it.  Development direction of
hagrid is tightly coupled with koo governance.  Hagrid is
AGPL'ed.

Justus: people have asked for hagrid to be deployable

Vincent: people used to ask whether they could "run an instance", like
SKS, but they can't because we don't federate.

Vincent: people run internal keyservers for their internal organization.
 I'm not aware of any publicly running instance of hagrid

Lars: hagrid is not the only way to distribute keys within an
organization.  debian publishes the debian keyring as a package.

Bart: it makes more sense to use WKD if you're going to do an
organizational keyserver

Vincent: at the moment, the bus factor for koo is me.  I'd like to know
how we increase the bus factor.  I'd also like to figure out how we
make decisions about new features (including changes to hagrid)

Neal: there are a few more cases where there are conflicts in vision.
 sequoia wants more certifications published in k.o.o, but vincent
doen't want that; federation is another.

Justus: and multiple certs per user ID.

Lars: when we talk about decision-making processes, we need to indicate
who has a voice, and who has a vote

Patrick: what we need to do is to make sure that it's not just one
person.

Kai: what's the difference between yesterday and today?

Vincent: yesterday, we talked about specifics of operational problems of
k.o.o. compared to a decentralized mechanism like federation; that was
about what are the things we want to do.  this is about how do we make
these decisions going forward.  I don't know how we separate
decision-making from doing, unless we bring in a funding model.

Bart: stakeholder projects (projects that rely on k.o.o) could elect a
steering committee, or they could use "direct democracy"

Vincent: operational decisions are easy -- organizational decisions are
hard.

Lara: how does trust work?  could you swap out the keys?

Vincent: at the moment, an admin could compromise the key store.

Kai: i propose that the first step here is to talk about governance

Justus: these choices are pressing problems.

dkg: let's not try to decide those things today; let's figure out how
we decide them going forward.

Lars: proposal: everyone here today is in the steering committee, with
an equal vote, maybe vincent has a veto.  going forward we need to
figure out how to grow the committee -- maybe nomination process.

Vincent: i'd prefer to identify stakeholders and then have them figure
out the structure.

dkg: if i'm asked to participate in a group that has no structure, i'm
scared.

Vincent: right, these processes are interdependent.

Patrick: maybe we want a bootstrapping committee, and 6 months out
there's a group

Bart: can we stab at something right now?

Kai: is there a template to choose from?

Vincent: what i'm hearing is that a smaller group would propose a set
of stakeholders and a governance model.

Lars: committee needs a deadline to report what they've done.

Vincent and Patrick and Nora: two months, end of july

Today produces a bootstrap committee. that committee has a deadline of
two months to produce a stakeholder criterion (with examples) and a
governance model.

Vincent, i'd prefer to brainstorm governance model.

Kai: the group should have at least one person who has experience in
setting up a governance model.

Vincent: people on the BC should be able to do a one-hour video call per
week Lars: plus one hour of extra work time.

Kai: i'm fine with participating

BC nominations:

 - dkg nominates vincent  - patrick nominates himself  - vincent
nominates dkg  - lars nominates himself

Bart: let's ask other folks at the meeting if they're interested in
being the BC.

Bart:  - a set of projects  - each project gets N votes  - there's a
process for adding and removing projects  - some policy for quorum and
voting resolution -- bart doesn't like consensus

Vincent: vetoing rights?

Vincent: should the governing body have a legal entity, or is that
causing more problems?

Lars: legal structure might help with liability

dkg: what responsibilities are needed for the committee?

Neal: how fine-grained is this decision-making process?  on MR?  or can
we have a conflict resolution mechinsm at this level, but otherwise let
people do the work

Bart: you could also have an executive team that is distinct from the
board

Lars: are there terms of attendance on the board?  once someone is on,
are they on for life?

Kai: how will the communicaton

Neal: if there are minutes taken, they need to be posted someplace.  BC
will post minutes to a git repo and to the email summit mailing list

Vincent: we might make something far more complex than we need to do.

Bart: yes, but it will be important for the ecosystem to have a visible
governance model.

- Who are the stakeholders?  - projects that depend on k.o.o.

Issues of contention:

- third-party certifications
- federation
- multiple certs per e-mailaddress
- key transparency
- social proofs
- feeds for updates

### Strong authentication {#Strong_authentication}

neal: you can't have encryption without authentication, authentication
is do I have the right certificate, e.g. key signing parties but there
are more oportunities, strong authentication can lead to wider adoption
of encryption technology, goal: ideas of other people of ways how to
improve strong authentication

stefan: if you communicate with a person for a long time, then
authenticated communication is easier then with an unknown person

neal: I was thinking of x.509 as weak since you have to trust a central
authority, authentication is a local property, authentication is about
names

daniel: so you want some kind of authentication also of the name in the
certificate?

neal: OpenPGP has a strong authentication
protocol, I see OpenPGP as glueing together
all identities I know, e.g. a subkey for matrix key, then you could talk
to me on matrix immediately

nami: Delta Chat implementation to verify keys: QR code generated on my
device and you scan, that led for me have more fingerprint authenticated
encrypted communication:
[https://countermitm.readthedocs.io/en/latest/]([https://countermitm.readthedocs.io/en/latest/](https://countermitm.readthedocs.io/en/latest/))

stefan: concept relies on already identified person, you can have
content in your key I don't know about, how can I denitify a key of a
person I want to encrypt to?

nami: e-mail adress + key + I we are connected

lars: seqoia has openpgp-ca, governments do authentication for their
people

neal: people are social animals, e.g. employment, clubs, activism, key
signing can be delegated e.g. when onboarding in a company an
administrator can do key signing like a company-CA, companies can sign
their CA-keys, this concept is different from x.509 because it is build
on the web of trust

stefan: what tells me what is verified in what way, which content is
verified in which way

lars: this is part of the certificates, i don't have a way to verify
that this e-mail belongs to this key

neal: you are delegating, i.e. you can act independently in a certain
way

stefan: I want to know the trust level I can put in an authenticated
key, which baseline requirements were met

neal: if you are not willing to rely an a party than do not delegate

lars: alice decides to trust her CA

stavros: if you are in a company with a hierarchy then there is no
choice to trust or not trust your CA

nami: a state could force other CAs to trust its malicious CA.

stefan: what if one CA signs a bunch of others I do not trust

nami: threat model is an attacker that can execute a man in the middle
and interfere with opportunistic encryption

stavros: there is also the impersonation threat model

lars: trust but verify, at the moment we have almost nothing, i have no
way to verify a certificate from a person I didn't meet so far, if we
can improve

neal: circles back: can we use string authentication to improve
opportunistic encryption

paul: one way to improve are policy flags for signatures, to write down
what is your policy to authenticate a key

marin: concerned about privacy implications, if you want to share your
contact list who you trust

neal: three levels: local, private, public signature. the scheme will
not solve all problems, question is, can we move the system forward

nami: QR code check both ways, but also via a verified group, individual
members can add members to the group, the new members now trust the
other group members, at no point you

stefan: here you have a clear use case, e.g. chat room

nami: non-hierarchical group, everyone can invite and kick out other
people

neal: anytime in onboarding opportunities you can inject authentication

stefan: onboarding is a perfect use case, the problem is if you try to
extend your trust to another party

lars: works very well in a coorporation that has a domain, that accepts
e-mail. would it work for a summit where we have different domains?

daniel: exchanging an e-mail adress is alread very simple, if you know
the e-mail adress, binding a certificate to an e-mail adress might be
sufficient

### Key Freshness {#Key_Freshness}

facilitated by bart, notes by nora

Intro:

-   Do different key discovery mechanisms imply different freshness?
-   Is it sufficient to talk about transport mechanisms, or are there
    other    criteria?
-   How is key/cert freshness defined?

Definition:

-   dkg: a cert can have multiple kinds of freshness, per discovery
    mechanism
-   bart: key freshness is an indication to automatically choose a cert
    for encryption
-   bert: Cert freshness relates to the confidence that the person on
    the other  end controls the cert
    -   dkg: Also, do I think I need to update the cert?
-   Vincent: Concrete example. An autocrypt key that is encrypt-mutual,
    and we are encrypt-mutual, too. We might not want to use that cert
    if we haven't seen that key for 5 years.
    -   dkg: Is the history of the cert we have seen enough to use it,
        or do I have to do additional lookup.
-   Vincent: "How *recenty* confident am I that I can use that
    key"
-   Patrick: Maybe call it "binding freshness"?

dkg: Things that go into choosing a cert for an (encryption) operation

-   user choice (manual cert choice)
-   history of using that cert with that email address
-   bart: the time I have gone without positive indication that that
    cert is good.

Vincent: Let's not think about the complex history of a cert, only look
at the timestamp of last seeing the cert in use. bart: Let's give cert
owners a way to communicate expected freshness requirements, e.g. let a
user set a frame of 3 months.

(develop a table of mistory model, indputs, outputs, see photo)

history model: most recent visible cert b/w primary key & email address

-   discovery method
-   signal from method
-   info from certificate
-   default/fallback "window"
-   communications history with the peer: have I seen this cert sign
    sth.?

dkg, vincent: If a part of the certificate that we're using (userid
binding, encryption subkey, ...) is expired, the key can't be fresh at
all. Remove these certs from freshness evaluations.

inputs:

-   manual vs. automatic encryption
-   manual cert + address acceptance (and when?)

actions:

-   go ahead to encrypt
-   refresh binding by email
-   refresh cert by fingerprint
-   refreshing may lead to discovering a revocation -> cannot use the
    cert altogether
-   prompt the user

bart: We currently do not have a background service that updates certs,
we do it at message composition time. (this informs building the certs
history)

dkg: the main goal of this session is avoiding sending unreadable mail.

bart: refresh cert by fingerprint is only relevant if the cert is
already in a user's cert store. the other refresh methods are relevant
on other cases, too. dkg: So, this freshness discussion may only be
about the userid binding. vincent: But, if there is activity related to
the primary key of the cert, that's a freshness signal. But that is a
very weak signal, people aren't changing their certs often. dkg: If
people ever start refreshing/rotating their certs more, that'll be a
good signal for freshness. Also, this would be very helpful for other
openpgp problems, like algo deprecation etc.

Manual freshness signals (included in certs), what are the semantics?

-   Like http ttl
-   if the certs agree, the longer period takes precedence
-   if they don't the newer one wins
-   maximum time to use this cert w/o refreshing
-   can have local caps for freshness times, e.g. per method
-   plausibility checks apply (1s or 10years don't make sense)
-   vincent: that means that autocrypt has a longer freshness period
    than wkd

action item:

-   create a document with a list of transport methods
    -   a specification of how ot get a freshness signal from them
        -   default freshness signal per method
        -   minimum clamp
        -   maximum clamp

vincent: final thought, wrt autocrypt: how do we surface this to the
user? expose configuration dkg: this introduces a new "stale" flag to
the autocrypt header

bart: "best before date for certs"

### Multi Device Synchronized State {#Multi_Device_Synchronized_State}

mailbox

    --------------------------------------------------
    co-devices
    name
    capabilities (OpenPGP)
    inter-device-communication key (IDC)
    secret key material (+associated certs)
    identities (aliases)
    autocrypt prefer-encrypt setting
    peer email addresses
    chosen fingerprint
    associated fingerprints
    autocrypt state
    gnupg owner trust
    gnupg tofu
    pile of certificates (pgp_cert_d?)
    preferences
    digest alg
    use specific transport (WKD)
    --------------------------------------------------

limited scope, but this is deliberately

dkg: THere are lots of sync protocols, but we don't want to reinvent
them. We need to think about WHAT needs to be
synced

nami: DC has stuff for syncing across DC devices

dkg: I have n devices on one account. What do I want to sync, very
specific representation, goal: Have a concrete outcome that can be
criticized

patrick: Do we use IMAP?

dkg: We don't care. Model it as tree of files?

PatricK: Tree of *information* (e.g. also json)

dkg: *draws* Mailbox, under that list of potential multiple
devices

Patrick: Generic vs. device specific information

nami: points out what stefan said about aliases. Some clients might try
to sort by alias

patrick: sounds like MUA specific

dkg: limit the scope down. Whatever is not part of the tree can be
extended

nami: Yes, DC can sync its own stuff without needing to deal with other
MUAs info, useful stuff can be later adopted

patrick: Autocrypt state table. Public keys that are trustworthy are
different from AC state table

nami: Sync in regular intervals? During device setup?

dkg: extensibility, sync freq and conflict resolution out of scope, lets
just focus on what to sync

patrick: prefer-encrypt status

dkg: one of your peers might propose change to preferences / algo
support. Is everyone else okay with that? How to resolve this conflict?

patrick: Capabilities are per device. There could also be
TOFU table,
OwnerTrust

dkg: Do we want generic key storage?

dkg: If I want to sign I wanna take into consideration my own devices,
as well as my peers devices. Each co-device a preference, or
account-wide preferences

patrick: User might have preference how their devices work

dkg: permissions for sync, if Iam device, what parts of the tree am I
allowed to update?

patrick: deivce could sign own deivce-specific stuff

patrick: Do we want to know which device changed what parts of the
state?

nami: Git like versions?

dkg: git can be used with emails :D

dkg: Preferences vs. capabilities?

paul: What if user wants to use WKD and device cannot?

dkg: Metadata leakage, what if device only uses tor, is it okay for it
to ignore no-WKD preference?

paul: sounds like detail

patrick: "I do not want to use opportunistic encryption"-preference?
Or "Only verified encryption" preference? Do I accept non-verified
keys for comms?

nami: user should be able to decide, should not be a preference that is
synced, clients have different philosophies

dkg: even if we sync, clients do not have to respect it.

paul: Lets prioritize items. Most important: secret key material, then
public keys. See pgp.cert.d for example certificate pile definition

dkg: secret key and autocrypt pref is in autocrypt setup

dkg: regarding aliases, we might want t have the tree we have so far per
alias

nami: chosen fingerprint vs. fingerprints seen. Autocrypt makes
assumptions that sometimes we don't want to use a certain key

patrick: Lets encrypt sync messages using idc keys

patrick: How do we recover?

### Multiple Recipient Encryption Strategie {#Multiple_Recipient_Encryption_Strategie}

3 Options:

- Don't send the message

- Send mixed

- All in clear

At Proton the mixed options is done, in Thunderbird user have to decide
if you don't encrypt or fetch keys for the rest of the recipients.

Depending on the user setting: opertonistic encryption, forced
encryption, ... one or the other options could be ok.

Problem with mixed option is that recipient get the message in plain has
no indication that the content is confidential, while other recipients
get same message encrypted and treat it as confidential. Of if you send
email to multiple recipients encrypted, and one replys to all but does
not have all keys, this would leak info if mixed mode is use. So at
least for emails that are recieved encrypted should only be replyed or
forwarded encrypted?

It all depends on users expectations but also of the expectation of what
recipients will do with the content after decrypting the content. If I
have to expect that the email will be leaked after decryption or if I
can assume the recipient will keep it confidential.

Protonmail will show encryption status before sending within the UI to
the user.

Kai suggested to introduce policy levels per email if there could be
other recipients or not and how this email should be treated.

Maybe a header for the desired policy to do net reply or forward
unencrypted. Is this header useful or will it be on on every encrypted
email. Proton would include this as an opt in. This decouples the
encryption state on recieving side from the content policy. It can tell
recipients who get the content over secure channel unencrypted to treat
the content confidential. This header must be a signed header. If the
MUA cannot encryped it could prevent automatic quote if a confidentialy
header is in place. None the less such a header should be standardised
and respected by MUAs or an existing header can
be used.

### Algorithm deprecation {#Algorithm_deprecation}

Kai: RNP made sha1 deprecation including user and subkey binding
signatures

 But there where still users with recent keys. maybe due to an old gnupg
configuration file used for key generation.

 There were too many complaints from users to put the fix on their
shoulders.

 Thunderbird (TB) reverted back to allowing sha1 for user and subkey
binding signatures but disallow it for message signature.

 TB should in the future to have a button to update the sha1 signatures
of one's own key. But other users could use GnuPG based
clients. Werner however indicated he would want to keep the sha1
signatures for these purposes.

 AW: Agrees since other hash algorithms will need deprecation in the
future.

 Justus: The deprecation was planned and what RNP did was correct on
that basis. For sha1 specifically we replaced sha1 with sha1cd with
(attack detection)

Kai: how would this help in this situation?

 Justus: It works like sha1 except when there is attack detected.

Aron: Would like to restrict sha1cd only for signature verification but
not for all instances of usages of sha1 like in
ECDSA.

Justus: We need to distinguish between collision resistance or pre-image
resistance. For key biding signatures there is no attacker controlled
data and thus sha1 is fine there.      Breaking all the certificates
with sha1 is currently not an option.

Kai: If we only accept the sha1cd this doesn't solve the problem.

Justus: The replacement is only on the consumer side.

Kai: RNP already implemented the sha1cd, so we should be fine.

Aron: What creation time should be used for the sha1cd signatures that
are added?

Justus: The current time should be used so that the client uses the
newer signature.

Kai: Metadata issues are another question.

Aron: sha1 is not allowed anymore for v5 keys. Deprecation dates are a
problem because things stop to work from one day to another.

Justus: The most import signature case is signature over data.
If you leave the deprecation to the key version they will be accepted
for a long time.

Aron: This is easier to tell users than the cryptographic detail about
sha1 deprecation.

Kai: Thunderbird could show the user that a key will be deprecated and
stop working soon. This is needed as long as the updrade function is not
there in Thunderbird.

Justus: Deprecation based on key version is slow because of the long
cycles for the standards. Only for the reason of deprecation then one
would need new key versions.

Aron: Could there be a quicker versioning. I don't think we can simply
solve this issue here.

Kai: Would it work with the IETF process to have
a new RFC just with the change of the deprecation of a single algorithm.
   Smaller documents that are easier to amend would facilitate this.
This will be done for post quantum as well.

Falko: Could there be an algorithm catalogue that only contains the list
of allowed algorithms.

Kai to Aron: Do you have any suggestions for the deprecation problem.

Aron: We hat issues with users with very old Android versions. We
decided for versioning with 1 or two times a year.

Justus: What do you do about old clients then?

Aron: The old client would still connect to the new server version.
     In OpenPGP faster cycles for the
standard could solve the problem.

Aron: It is difficult to touch what is out there. Either you announce
and initiate the deprecation very early or you will run into problems.

One could put an expiration date on the algorithms. Clients would have
to be updated in order to receive an extension for the validity of an
algorithm.

Kai: To what other algorithms was deprecation was deprecation already
applied?

Aron: CAST5 and some other.

Kai: What if NIST curves would be considered
insecure from one day to another?

Aron: E-Fail is a good example. Some clients reacted by refusing packet
type 9.

Kai: is the an approach that we can agree on?

Aron: What could bring us together is the presence of qunatum computers
and the deprecation. But if nothing severe happens it is difficult to
bring everyone toghether.

Falko: wouldn't it be the solution just to disable the use of the
algorithm immediately in implementations?

Aron, Justus: But that would disable the functionality for instance for
encryption totally and thus maybe would not be the best solution since
then they might send the message in plaintext.

Kai: Thunderbird could, after introducing the repair button for the key
binding signature, write a block post about the deprecation about sha1
deprecation.

Justus: I don't believe in warnings and repair buttons.

Kai: So maybe we should talk to all MUA and
OpenPGP implementations to implement the
deprecation.     We could recommend to all GPG tools to scan the secret
keys and warn the users. These tools would provide more comfort for the
users then.

Kai: What can we do about the GnuPG problem with sha1. Can
Justus talk to GnuPGP. Justus: GnuPG
should ignore unsafe configuration.

Justus: Having the algorithm preferences in the key up-to-date is
important.

Aron: For the PQC hybrid algorithms an expiration date would be an idea,
since they are meant for a transition phase.

Justus: I would like to talk about the v4 key refreshment
- Replace all binding signatures and in that course
- update the algorithm preferences to SHA2+, AES
- and features
- and primary key binding
- signature creation time needs to younger than that of previous key for new keys
- replace weak subkeys
- revoke the old ones
- extend the expiration time

Weak keys are considered:
- DSA
- El Gamal
- RSA < 2K bit keys
- bitcoin

- Emergency deprecation measures could be specified

Justus: what to do about weak primary keys?

Aron: We need user interaction to trigger user to update is.

Justus: for v4 keys the preferences are on subkey binding signatures.
They must be updated all in the same way.

### v4/v5 Migration {#v4.2Fv5_Migration}

Session Leader: Justus

Note Taker: Neal

Justus: I'm here with my IETF hat on.

There is some interoperability between v4 and v5 certificates in the
draft.  It is okay for a v5 cert to encrypt to a v4 certificate.  A v4
key can decrypt that, but it can't parse the signature (it can't parse
the certificate or the signature package), and it can't reply.  The v4
client also can't reply, because it doesn't understand the v5
certificate.  We considered making a backwards compatible format. This
leads to a lot of issues.  The DT decided it was better to have a clean
break.  But, we need a plausible way for users to migrate to v5. The
suggestion is that users have two certificates: a v4 cert and a v5
certificate.

Neal: Why is using a v4 key with a v5 client a problem?

Justus: The main problem is using a v4 key with a v4 client.  So that is
out of scope.

Aron: The question is: we have v4 clients with v4 keys.  How can a v5
user communicate with a v4 user?

Aron: When we do this, then we should also avoid a downgrade attack by
embedding a pointer in the v4 certificate to the v5 certificate.

Vincent: An adjacent topic is sideloading large certificates.  In the
context of the autocrypt headers, we won't be able to fit a post
quantum certificate.

Vincent: Let's work through WKD, and then key servers.

Aron: For WKD, let's add a parameter.

Vincent: That doesn't work when the parameters are not parsed and the
WKD is just a set of files.

Daniel: We could just return two certificates.

Stravos: What does the default certificate generation workflow look
like?

Justus: You need to generate two keys, if you want a v4 and v5
certificate.

Stravos: How do we move away from v4?  If there is no pressure, people
won't move to v5.

Lars: In these kind of ecosystems where key migrations have been done
before, they take years.

Daniel: I'd like to be a bit more optimistic.  I think we should hope
that for implementations to support v5 keys, it should not take 10
years.  If we can get broad implementation support in a year, then we
can start generating v5 keys.

Vincent: That doesn't work for Debian users.

Aron: We can get users to move by enticing them with new features.

Stravos: Such migration issues are always difficult.  If you have
several companies with a lot of employees, then an overnight migration
will never work.

Lars: I watched Debian migrate from RSA 1k to RSA 2k, and something
else, and it took years, even though people in Debian were actively
hunting down people with old keys.

Neal: Aren't we looking at the specific case that people are using
clients that only support v4?

Stavros: Sure, but there will always be a few v4 only implementations.

Neal: So, what should we do?

Vincent: Let's consider how we get the first 20% of people to switch
while there are still a lot of v4-only implementations.

Daniel: Once the implementations are updated and deployed, we should
change the defaults to v5.

Daniel: I hope everyone commits to implementing v5.

Justus: Let's consider the dual-use case (v4+v5 certificates) again.

Vincent: keys.openpgp.org could have a parameter where the client says
what it prefers.

Aron: I like the idea of negociation as it is more flexible.

Vincent: If gpg is unable to parse v5 certificates and we deliver v5
certificates, then people will start complaining.  That will create
pressure on gpg to implement v5 certificates.

Aron: The more features we add, the more certificates we need to return.
 Feature flags limit the communication to one certificate.

There are two approaches: we add an additional key.  That's simple. Or,
we pass a parameter, and the server returns the right one.

Vincent: Even if I speak v5 and someone else has a v5 certificate, I
might still want a v4 certificate for that person when sending a message
to both.

Nora: What about the scaling effect that Aron mentioned earlier?

Vincent: For PQ keys, we can always do it differently.

Lars: In HTTP one normally says what one accepts.
 We could reuse that to have the clinet say what it supports.

Aron: The default behavior would be to return just v4?

Lars: Or all.

Justus: If one software fetches the certificate and another software
uses it, what should we do?

Aron: You're right, we should return everything.

Vincent: This is very focused and detailed.  Are there any high-level
things we want to discuss?

Justus: The reason I wanted to make this session, is to make people
aware of this problem, and identify issues.  I didn't think WKD was
going to be a problem as our implementation handles all certificates
that are returned.

Vincent: In autocrypt we can return multiple headers.  Older clients
won't parse the newer header.

Aron: What are other ways to delivery keys that we care about?

Justus: DANE?

Neal: LDAP

Aron:

keys.openpgp.org: query parameter, default all WKD: query parameter,
default all autocrypt: multiple headers DANE: TBD
LDAP: TBD

Vincent: We shouldn't return something according to a header, but make
sure the request is a static request so that they can be served from a
file.

Justus: When OpenPGP CA certifies something,
it should be ready to certify multiple certificates.

Aron: We should have a forward pointer to make it clearer that there is
a v5 certificate.

Vincent: A type of upgrade hint?

Aron: Yes

## Outcomes and Actions {#Outcomes_and_Actions}

-   keys.openpgp.org Bootstrap Committee (Patrick, Lars, Vincent, dkg)
-   Cert Transport Freshness Spec. (dkg, Bart, Vincent)
-   PR with Algo expiration (Aron)
-   PQC Composite Proposal (Aron, Falko)
-   Forwarding with Composite PQC (Aron)
-   Fallout of removing fpr from ECDH KDF (Aron)
-   Symmetric Re-Encryption (Daniel Huygens, Justus)
-   Non-Revoking Superceeded Signature Subpacket (V4 to V5 transition)
    (Aron, Justus)
-   Thunderbird Action Items
    -   Better UX if can't encrypt (Kai)
    -   Protect Subject in Reply
    -   Better Autocrypt Support (something explicit/implicit?)
-   V4 Key Maintenance Recommendations (Justus, Lara, Falko)
-   Autocrypt Followup (Nami, Kai, Patrick)
-   PGFS (Pretty Good Forward Secrecy) (Justus,
    Nami, Lars, Lara)
    -   enumerate parameters
    -   Guidance for maintainers
-   Proton:
    -   Explore k.o.o support
    -   Autocrypt Cache (Huygens)
    -   Explore Autocrypt Emit (depends on freshness) (Bart)
    -   Explore creating CA? (Bart, Aron)
-   Recipient Subsets (Kai, Bart, dkg)
-   Outline User Personas (Nami)
-   Meta-Accountability (Patrick)
-   New SOP commands (Lars, Marin)
-   Organize Next Event (Patrick)
-   Convert Pad to Wiki (Kai)
-   Multi-Device-State Sync (Nami, dkg)
