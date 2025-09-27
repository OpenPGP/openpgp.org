---
title: "Minutes of the OpenPGP Email Summit Interim (2025-09-27)"
permalink: /community/email-summit/2025-interim/minutes/
---

{% include toc %}

Attendees:

* Kai Engert
* Aron Wussler
* Daniel Huigens
* Daniel Kahn Gillmor (dkg)
* Andrew Gallagher (partially lurking)

## Certificate usage and trust (Kai)

Proposal: Rather than having some scoring for information about how any given certificate was discovered or (partially) verified, just show the user what the status of the certificate is when potentially using it.

Aron: we have something like 27 states of key status.  it's confusing

Daniel: part of the problem of opportunistically encrypting is that some recipients can't read encrypted mail on some clients.  We need to be able to mark a cert as something that shouldn't be used.

dkg: UX details matter here.

Kai: do we need revocation services?

Daniel: better to rely on freshness (e.g. low expiration time and frequent updates).

## Action Items review

* vcards - improve interop with Delta Chat (Proton)
    * hasn't happened yet
* PQC -
    * Allow V4 subkeys (Aron / Falko)
        * done
    * Prepare draft for last call (Aron / Falko)
        * done
    * Prepare private HQC draft (Aron / Falko)
        * hasn't happened yet
* FreePG (Andrew, David)  (https://freepg.org/)
    * Find governance structure
        * no progress
    * community outreach to users of GnuPG/gpgme to see whether they can switch or chameleon works
        * some progress
    * outreach to other binary distributions of GnuPG (e.g. brew, macports, gpg-tools)
        * no progress
* Key migration
    * More user stories & guidance (Andrew)
    * prepare last call after PQC (Andrew)
        * new draft in the next week or two, pretty much all of the open topics are closed
        * question about how we test.  should be developed more at IETF interim in 2 weeks.
* Manual key verification
    * Proton: discuss approach using QR codes instead of FPR
        * some internal discussion, no clear plans
        * We do need to think about QR codes for v6 keys, which don't use OPENPGP4FPR. can we register a version-independent URL scheme?
* Cleartext (non-disturbing) signatures
    * set up new draft repo in gitlab (Andrew) https://gitlab.com/andrewgdotcom/unobtrusive-signatures
    * test vectors, review behavior in various MUAs (dkg)
    * flesh out, submit to datatracker (dkg, Andrew, Kai)
        * draft is in the datatracker
        * dkg has offered patches to emacs message.el
        * Thunderbird development build signs all the headers, but doesn't create unobtrusive signatures yet -- wants to produce and process them at the same time.  Hopes to have both land at once.  Might not be the default for signed-only mail at first.
        * a couple outstanding issues in gitlab.
* Expect Signed Mail
    * Create first prototype to try it out (Daniel H)
        * no progress
* Deterministic keys
    * Follow up on “Simple key” approach (Kai, Aron)
        * kai shopped it around within mozilla, but hasn't make progress yet. (all public artifacts can be pulled from the cert, only secret key material is necessary)
        * Proton serves deterministic certificates based on a seed, as abuse prevention.  not quite the same thing, and not publicly specified.
        * more work needed; discussion about how interoperable it needs to be
* Forward Secrecy
    * Discuss more on the list (Daniel H)
        * no progress
        * https://sequoia-pgp.gitlab.io/openpgp-dr/openpgp_dr/index.html
        * dkg is chewing over some sort of "deletable messages" for an Autocrypt v2 certs (see below)
* Automatic Key Authentication
    * Prepare proposal (Kai)
        * see above -- Kai's thinking is changing
* Prefer Encrypted Mail
    * mailto: URI parameters (Daniel G)
        * no progress
    * introduce KOO signalling roughly equivalent to prefer-encrypt=mutual defaulting to off (Daniel H)
        * discussed at KOO Board, no objections, but no significant progress
        * KOO: next API should be HKPv2, HKPv2 should replace WKD as well
    * introduce WKD signalling roughly equivalent to prefer-encrypt=mutual defaulting to on (Daniel G / Daniel H)
        * This should be moved toward HKPv2
        * Andrew mildly prefers that the signal is in the certificate, rather than the distribution mechanism.
    * describe vCard annotation roughly equivalent to prefer-encrypt=mutual (Daniel G / Daniel H)
        * https://github.com/autocrypt/autocrypt/pull/456
    * [NEW] OpenPGP notation in direct-key signature over primary key in cert: something like prefer-encrypt@autocrypt.org=mutual ?
        * in some cryptpad, hasn't made it to the public yet.  Daniel H can try to offer it to the public.
* HKP
    * Update spec (Andrew)
        * KOO plans to adopt it
        * v2 aims to RESTify the API
        * task to re-work current description of APIs: v2 primary, and later legacy section maps v1 to the v2 concepts
        * wants WG adoption later this year if possible.
        * hockeypuck implementation might get started soon.
* Encryption subkey selection
    * Write problem statement & propose solution (Justus)
        * we don't know of any existing work; the topic is visible in the WG, but nothing concrete.
* Autocrypt: What do we need
    * Amend Autocrypt spec for key freshness (Nami)
    * … for key change warning recommendations (Nami)
    * … for QR code for AC Setup message (Daniel G)
        * no progress
    * … for moving AC header to mail body header (wait for the non-disturbing cleartext signatures testing result/feedback)
        * deltachat folks are looking to do this
    * … for extending Setup message with social graph / AC state database (Nami)
    * … for prefer-encrypt="..." recommendations in your client (Daniel G)
        * no progress
    * … for vCards (Hocuri)
        * https://github.com/autocrypt/autocrypt/pull/456
* Autocrypt v2 certificate
    * decide between Ed25519 or ML-DSA + Ed25519 primary key (dkg)
        * Ed448 primary
            * (daniel h suggests that might be an issue with webcrypto)
    * decide on migration approach (dkg)
        * No migration
    * revise spec after PQC & replacement-key landed (dkg)
        * will depend on PQC, probably not on replacementkey
* Create public IMAP folder with PGP/MIME signed & encrypted messages (dkg)
    * no progress

## Shipping encrypted messages containing v6 and v4 signatures

Aron recently tried sending encrypted mail with both v4 and v6 signatures to the public.

Trouble for legacy clients:
* GnuPG
* 6-year-old Proton Mail clients on unsupported legacy iOS
* Thunderbird has some trouble ignoring unknown signatures
    * Kai says it will be fixed soon, and uplifted to stable branch
    * https://bugzilla.mozilla.org/show_bug.cgi?id=1986845
