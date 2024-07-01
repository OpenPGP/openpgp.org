---
title: "Summit 2023 Notes"
permalink: /community/email-summit/2023/minutes/
---

{% include toc %}

## Plenary talks {#Plenary_talks}

### Post Quantum - Aron {#Post_Quantum_-_Aron}

-   Presented performance measurements (time to generate a certificate,
     time to parse a certificate, time to generate a signature, ...)
    of  different algorithms **Dilithium and Kyber: Same order of
    magnitude as traditional crypto** Ed25519 and P256: You can't beat
    it **Sphincs - bad UX: 20 seconds for generating keys, 3 seconds for
      generating a signature**
-   Size of keys
    -   Sphincs is huge
    -   Dilithium and Kyber: same order of magnitude, but larger
-   Size of signatures
    -   Much larger than ECC
    -   Sphincs: 50 kB!
        -   Conclusion: may need to rethink how signatures are stored
        -   Not good for signing small data
-   Size of PKESKs
    -   Reasonably small
-   Standardization
    -   Should wait for CFRG to avoid
        incompatabilities (e.g., byte ordering)
    -   NIST process is not finished.  There is
        an ongoing 4th round.
    -   dkg: Conclusion PQC is a moving target and will be for a while.
    -   Aron: Envisions multiple documents and not one document that
        contains everything.

### Header Protection for Cryptographically Protected E-Mail - dkg {#Header_Protection_for_Cryptographically_Protected_E-Mail_-_dkg}

-   Draft shows how to protect headers in an agnostic way (pgp mime and
    S/MIME)
    [https://www.ietf.org/archive/id/draft-ietf-lamps-header-protection-15.html]([https://www.ietf.org/archive/id/draft-ietf-lamps-header-protection-15.html](https://www.ietf.org/archive/id/draft-ietf-lamps-header-protection-15.html))
-   Two mechanisms
    -   Wrapped messages - what S/MIME specified, but no one
        did
        -   MUAs don't handle this correctly
        -   Recommended for parsing
    -   Injected Headers
        -   Recommended for sending
-   Idea
    -   When signing a message, the headers usually aren't signed
    -   Idea: Copy headers into the MIME body (all of them, no
        exceptions)
    -   If someone doesn't want to interpret them, it doesn't break
        anything
    -   When you interpret the message, there are some wrinkles
    -   When encrypting, do the same
        -   Header confidentiality policy: sender decides what headers
            should be confidential
        -   No reason to not do this today: legacy clients are able to
            deal with it
-   Draft is big, because it deals with the wrapped messages, but you
    can ignore it.  Just implement the basic scheme today.

### WKD and Abuse Reports {#WKD_and_Abuse_Reports}

-   Fetching keys with WKD means many requests
-   Proton ended up on abuse list
-   Discovered curl bug, but there is another issue:
-   Survey of how many serivces offer WKD
    -   Tons of websites return 200 for any path, so also WKD paths
-   Direct method is spam-prone (no possibility to fail on DNS level)
-   Not limited to direct method
-   Wildcard DNS + Wildcard Certs are an issue
-   Workaround: Look up WKD domain, also lookup
    [https://openpgpkey.example.com/.well-known/openpgpkey/example.com/policyfailure](https://openpgpkey.example.com/.well-known/openpgpkey/example.com/policyfailure)
    and check if second one fails

### Learning from WKD at scale - Bart {#Learning_from_WKD_at_scale_-_Bart}

-   What is the WKD implementation doing
-   Logged what domains have WKD support to see what was going on
-   Expecting a few logs per day or hour
-   Result: very noisy
-   A lot of them clearly don't have WKD, a few were legit
-   Many websites return 200 for anything(!)
-   If a website returns 200 for policy document, then we start using it
    for WKD requests
-   More common with direct method, but the advanced method also had a
    lot of false positives
    -   Lots of websites have wildcard domains and route all subdomains
        to the main website
-   Solution:
    -   Lookup the correct policy string and policy string +
        "policy-failure"
    -   If the first succeeds and the second fails, then we're good
    -   Otherwise, assume that it returns 200 for anything
    -   Works great: reduces key fetches, and abuse score reduced a bit
    -   Logging for 10 days: observed 242 advanced WKD installations
        (not including Proton's), 167 direct WKD installations
-   Conclusion
    -   direct method is more prone to this
    -   would recommend dropping direct method
-   dkg: We could go the way of MTA-STS and require a TXT record.
    -   If we require a new subdomain, then adding a TXT record too is
        not too big of an additional ask

## Workshops {#Workshops}

### V4 - V6 transition {#V4_-_V6_transition}

dkg: want to make a V6 key ASAP, ensure it's
available to who can understand it. What are the problems with this key
distribution?

-   WKD allows only one valid key to be distributed
    -   Add a API to return more certificates -> discuss in the WKD
        session (tradeoff between confused clients
-   KOO only returns one key per address
    -   Change API to return more certificates -> discuss in the KOO
        meetings
-   Autocrypt is designed to allow only 1 key
-   HKP returns any number of keys
    -   Adding a query parameter to filter keys
-   VKS
    -   Change API to return more certificates and augment the API for
        fingerprints
-   Thunderbird & other clients only accept one key, fails on multiple
    keys
-   Client prioritization, how to choose a key?
-   Mixed recipients: how do I encrypt?
-   WoT: corroborative paths
-   No way to deprecate a key without revoking and can we link keys
    -   To be discusses in the deprecation without revocation session
-   What do you signs with?
    -   Probably all keys should be used to sign, and the widest
        compatibility first
    -   Verify as many as you need, until you reached sufficient level
        of trust / fulfill the algorithm criteria
-   How do we handle V5?
-   Multiple signatures on the PGP/MIME level
    -   Just put all the signatures in a single part (multiple packets
        in a single armoring)

### Signature Failures {#Signature_Failures}

how should we display broken signatures?

Some kinds of brokenness?

-   valid signatures but key is revoked?
-   messages without signatures?
-   missing keys
-   address mismatch
-   expected a signature but it isn't there
-   partial messages
-   protected header mismatch?
-   metadata mismatch
-   intended recipient mismatch
-   unauthenticated binding between cert and address is bad
-   text/html e-mail with external resource

Are some kinds of signatures work showing vs. others?

Baseline: keep it simple. treat a broken signature the same as no
signature.

Where the user can reasonably do something about it, maybe we want to
prompt the user

Is it different for cleartext vs. encrypted messages?

what can we learn from web browsers? from Signal? From
OMEMO?

How should we indicate encrypted-only messages (those that have no valid
signature)?

Can we make an HSTS-style signal to so that the
sender can trigger a warning on unsigned messages?

-   per-recipient?
-   global?
-   via protected header?
-   via cert/subpacket?

These signals might break for messages relayed through mailing lists.
SRS (sender rewriting scheme) would make it so that the signal doesn't
apply.

how can we build a consensus that warnings should not be shown?

Re "Broken signature is no signature" does not work for Proton, where
they show a warning about a message that appears to be signed but they
don't have the key so it cannot be validated. When they fetch the key
and the signature is broken, suddenly the message displays as not
signed?

### PQC {#PQC}

(note taker: Falko)

Justus: Who is pushing for SPHINCS+?

Aron: Phil Zimmerman also pushing for SPHINCS+

Long term security solution for signatures. PGP usually not used for
authentication.

Daniel: Is BSI interested in SPHINCS+ in
OpenPGP

Falko: Will probably use it in German gourenment PKI. For
OpenPGP probably also interesting for them for
other purposes.

Aron: (shows the list with algorithm requirements in current draft)
SPHINCS+ is adding the most implementation
complexity. "MAY" for SPHINCS+ and not
"SHOULD" is something we could discuss.

Falko: comparison with numbers from submission

Aron: We have similar numbers than the reference implementations

Justus: I am more concerned with verification and that seems to be not
that bad.

Aron: thought about dropping the small variant

Falko: shouldn't be done because application contexts have different
requirements

Aron: Algorithm matching L3 PQC with 384 (current draft) or 512 bit
curves

Falko: current combination comes from LAMPS and
doesn't address the long term security of the traditional algorithm

Aron: 384 bit curves is what CNSA standard
prescibes, but we don't have to necessarily follow it

Aron: Usually people want either the fastest or the more secure version,
could drop the intermediate parameters

Daniel: makes most sense to pair the algorithms according to their
security levels, as otherwise it is not a fallback to the same security
level

Aron: X25519 and X448 are an exception, they are already paired in this
way

Nickolay: What is contribution to the signing time in the EC +
Dilithium?

Aron: It is about 50% percent overhead, typically curves slower than

...: Maturity of the PQC implementation regarding side channel?

Aron: We are using cloudflare implementation for Dilithium (?). Kyber
reference implementation is constant time and doesn't have fault attack
protection.

Justus: I am interested in a small algorithm catalogue as we will not
implement them ourselves but have to rely on crypto libraries. Nettle's
implementation of OCB took a long time.

Falko: This set is the NIST selection which
schemes will be mostly implemented in libraries.

Aron: SPHINCS+ is going to be asked for by
many parties. Will be used for packet signing and Sequoia will be used
for that.

Falko: Botan will receive all the algorithms in the draft

Justus: But not yet in Botan's FFI interface. There is little things
that need to be added.

Aron: KMAC required some low level tweaking. We
could replace it with SHA-3. In EC KDF there is an ambiguity in the
encoding used with SHA-3. But the new construction could be adopted to
avoid collisions with the one just mentioned.

Justus: now I am fine with KMAC since nettle
already has cSHAKE already. Would be good if
nettle will offer KMAC in the future.

Aron: Shall we move on to the topic of interop testing?

(no objections)

Aron: In the beginning we could just exchange test vectors. But in the
long run the SOP test and interop testing service would be a good
solution.

Daniel: Since it is not standardized yet Justus could handle it like v6
with a new page

Justus: One question is how we get the implementation artifacts.
Currently we are using docker images. It is a bit slower, though.

Aron: The idea would be to create a docker container that with a tag for
the draft version.

Daniel: that would also allow to put a config file on a config file in
github repo where they can add their implementation which is then
automatically fetched.

Justus: It wouldn't necessarily have to be me managing this. Not to
happy with this since I run everything on my machine. Would be nicer to
have a server for this.

Daniel: We have the OpenPGP.org domain. We
could make subdomain tests.openpgp.org for this purpose. But it is very
utopic.

Aron: The idea with the docker images is to take the effort from you
regarding updates to the implementations. Also I remember we had
deprecated SHA-1 in Go-OpenPGP and the interop
test suite did show this only about 7 months later. So the manual
updating isn't optimal.

Aron: Another questions is binding the PQC keys to the packet versions.
So far the spec says you must produce v6 keys and must use v6
PKESK. Yesterday Falko and I talked about this
and we have the options:

1. allow everything: PQC is just new algorithms

2. bind them to the newer keys but also allow v3
PKESK. Then we could send encrypted messages
also to mixed recipients.

3. leave it as now (bind to v6 strongly)

1st is interop advantage with GnuPG. But we also have a salt
in v6 signatures. Salt must be prepended to message in order to be
useful. There is some security reduction.

Falko: Security reduction due to missing salt is generally for v4.
Should view the PQC and v6 improvements separate to enable it for the
greatest set of users.

Aron: I am happy for relaxing the requirements for encryption, but not
for signatures. Do we want to repeat what was done with X25519.

Justus: if the goal is to be interopable with GnuPG this might
not work if GnuPG chokes on the unknown algo version even if
not own fingerprint in packet.

Aron: Do we want to have the binding of PQC to key version? Encryption
is more urgent so should we allow it with v4 keys? For signatures maybe
wait for a few years.

Justus: An argument could be made for unbinding it from the packet
version like X25519. That is not even the question. The question is
sending a v3 PKESK when one recipient has only
v4. Or do we want to allow v4 kyber keys?

Aron: I am OK with the second, but not with the first (regarding
enumeration above)

Falko: For encryption it is urgent to enable it so v4 keys should be
allowed to have a failproof solution.

Aron: That is a fair point.

### Shared Library API {#Shared_Library_API}

(note taker: Patrick)

"C" style --> .so / .dll interface

Sugegestion: use libabc README (Linux Kernel)

Base it on builder operations (e.g. expected timeframe, keys, etc)

Opaque Objects:

-   Operation objects (similar to SOP commands)
-   Data objects (similar to SOP data types)

Example:

1 certs x

2 op_verify y

3 verify_with_cert(x, y)

4 ...

5 verification_result = verify_go (y, data, sig)

--> what happens if x is modified between 1 and 5 (e.g.
verify_add_cert(x, a))

Questions:

-   Object Persistence:
    -   use load() and destroy() to avoid errors.
    -   Mandate reference counting for the load() / destroy() funtcions
    -   Adding certs (or data) could be done via coalsce-ing. The result
        is a new object
-   Error handling:
    -   each step may fail. Functions return error codes
    -   error code that allows applications to display an appropriate
        message to user
    -   human readable string with all errors accumulated (for
        developers -- not intended for end users)
    -   have a "NOT IMLEMENTED" error to
        allow for future
    -   error codes need to be predefined at spec time
    -   Struct for return values are difficult and should only be used
        for specific cases (like error signalling)

#### Addiditional Considerations {#Addiditional_Considerations}

-   discourage customization outside of context init
-   Should the library just support memory operations (vs. streams)?
-   allow for stream objects? use fopen()/fread()/fwrite() (file*) as
    abstraction for input/output?
-   2 types of functions (a memory-based and a stream-based), and allow
    for implementations to not implement the stream-based API

### OpenPGP CA - Run by Aron {#OpenPGP_CA_-_Run_by_Aron}

-   OpenPGP CA based on web of trust
    signatures where you have a central authority that certifies
    certificates.  Users choose to trust the CA; there is no central
    list like in Web PKI.
-   Deployed with OpenPGP CA software, good
    for medium and small environments.
-   OpenPGP CA doesn't scale to serving 100s
    of millions of keys.
-   Proton took this idea and reimplemented it in their backend service.
-   Proton certifies bindings for 6 months after creation time.
    -   We know that this certificate cooresponds to this email address
        (not this user!)
    -   After 4 to 6 months (randomized), extend the duration by another
        six months.  Reuse the same creation time.
    -   Neal: Using the same creation time could create problems as it
        is unclear which one should be used.
    -   Aron: Changing that shouldn't be the problem.  What we don't
        want to do is have lots of signatures.
    -   Room: Alternative: using creation time plus one second.
    -   Room: Is backdating signatures reasonable?
-   Only have one key that signs everything (it's safe)
    -   Would be nice to have a primary key that is kept offline and
        then an intermediate key creates the live signatures.
    -   Certification subkeys do not work.
    -   Could create an intermediate certificate, but how do clients
        find it?  Clients lookup the main CA key using WKD.  WKD only
        allows returning one certificate.  So the intermediate
        certificate needs a different email address.  But, how do
        clients know to look for that certificate?
    -   Sandro: Should not use unlimited keys or very long lived
        certificates.  Instead, roll forward and rely on chaining.
    -   Bart: If we allow WKD to return multiple certificates for an
        email address, then that also solves this problem.
    -   Aron: If we have different addresses, then we know which one is
        the root key.  Otherwise, the root key is ambiguous.
    -   Neal: We shouldn't rely on WKD to determine the CA certificate;
        it should be pinned.
    -   Bart: Could use key rollover.  Resign everything using the new
        certificate.
    -   Neal: Use tsigs with a depth of 255 to chain forward.  Then
        people who pinned an old root can still use the new certificate.
-   Aron: Proton has started serving third-party signatures uploaded by
    a certificate's owner.
-   Aron: How should third-party MUAs use
    Proton's CA?
-   Bart: A squatter could register openpgp-ca@gmail.com.  This could
    create problems.
    -   Neal: Shouldn't assume something is a CA by the local part.
-   Andrew: Danger of users accidentally assigning trust to a CA.
    -   Aron: Most users don't read dialogs.
-   Stephan: Could use a subdomain.  This means users couldn't register
    a username and are more resistant to squatting.
-   Sandro: Could have keys.openpgp.org be a CA of CAs.  Then there is a
    lot of all CAs.
-   Bart: Want a canonical address to lookup the CA.  If we use a
    special domain, then all addresses are recognizable as being
    potential CA keys.
-   Andrew: Would be good to have a transition period where two
    intermediate CAs are live at the same time.
-   Aron: Fan of having the root key be offline and using intermediate
    keys.  Using chaining, the root key changes, but the root key is
    online.
-   Kai: Do you expect clients to automatically trust a certificate
    returned by WKD for openpgp-ca@example.org?
    -   Aron: No.
    -   Kai: Normally, the root is embedded in the application.
    -   Aron: This is a way of creating distributed trust.
    -   Kai: Is there a way for users to make an informed decision.
    -   Aron: We publish it on our website.
    -   Kai: Should Thunderbird maintain a list of good CAs?
    -   Sandro: This is a web of trust question.  You have one
        certificate signing other certificates.
    -   Kai: So, users make the decision.  And clients have to implement
        web of trust.
    -   Aron: Yes, the change is in the infrastructure.  You don't have
        to verify all of the keys yourself.  This is a different shape
        of network, but it is still web of trust.
    -   Andrew: Does this give you any practical advantages over WKS?
    -   Bart: For koo, yes: it works for other domains, not just a
        single domain.
    -   Neal: For organizations, the IT admins could install trust roots
        for their users.  For a bank, onboarding could include a QR
        code.  Companies could also distribute a QR in advertising.
    -   Bart: Oh, that's going to result in some interesting fake
        advertising.
    -   Bart: This doesn't mean that Thunderbird could distributing a
        list of trust roots.
    -   Thomas: GMX and web.de certify certificates since 2016.

### Authentication Certificate - Identity {#Authentication_Certificate_-_Identity}

What is Authentication? what are its problems?

-   Do we do authentication of an email address or the person behind the
    email address?
-   Not constant in time. Things evolve, new certs, revocation,
    certification -> CA
-   Certification vs. Delegation
-   Disagreement - differences sources, different data
-   Bindings - UserID / email / identifier +
    certificate
    -   <alice@example.org, Fingerprint|Cert>
-   Authentication a priori (Pre-check, proactive) or a posteriori
    (TOFU, detect misuse afterwards, reactive)
    Zooko's triangle

        Zooko's triangle

                           Secure
                              ^
                             / \
                            /   \
                           /     \
                          /       \ Fingerprint
                         /         \
                        /           \
                       /             \
         Human-usable |---------------| Distributed
                            Email


There is a difference between global and local identifiers:

-   "Who is mom?" cannot be answered by a global PKI

Organizations have different scopes, depending on their "interest
distance" to the subject.

On a scale from local to global, we can organize organizations like
this:

    Local [ 1st party Orgs | 3rd party Orgs | Special Interest Authorities | WebPKI ] Global

If I want to check the signature on a software package, I need to do:

    Package
    | Download
    v
    Signature
    | Math
    v
    Cert
    | Authentication
    v
    Identity
    | Correct or expected identity
    v
    User

-   Authentication
    -   Checking binding veracity
-   Key Discovery
    -   Aron: Authentication is part of key discovery
    -   Sandro: Download certs from SKS via email: no authentication;
        auth is next step
    -   Aron: Once I "certify" a cert, its discovered
    -   Paul: Download from SKS is candidate key discovery

Key-Transparency BoF at IETF

-   Protocol independent
-   Huge mess, every protocol has different identifiers, expectations
    etc., identifiers are PID, some might therefore not like
    transparency
-   Hard to achieve
-   Comes at a cost on server and client, can be largely automated
-   WoT also comes at a cost, but on the humans, not machines
-   Cross-Domain KT: Don't know if person checks it; or its a forgery

We discussed different key discovery processes in KMail/Kleopatra and
Proton.

Different threat-levels, some messages are "just" embarassing if they
get leaked, while others might bring me to jail / threaten my life.

In Protons new API they differentiate between keys and unverified keys,
depending on the source (WKD/Internal/...)

In Sequoia: WoT is powerful mechanism, ideally we just pour all our data
into WoT and let the WoT engine figure out the rest.

In Sq, WoT is a maximum-flow network with edges having different
weights, calculating how much authenticity flows to the target.

### WKD / Lookup privacy {#WKD_.2F_Lookup_privacy}

facilitators: Kai & Bart

note-taker: dkg

Lookup privacy: queries to keyservers or WKD yield information about who
is interested in which address

How can clients (like thunderbird) refresh keys automatically without
leaking information about who is interested in which clients?

-   is this a problem, given that e-mail activity already exposes
    connections between people?
-   Yes, the metadata leakage for keyring refresh is distinct from
    metadata leakage from e-mail messaging

OHAI (oblivious HTTP) work
is ongoing at the IETF. clients should be able
to use OHAI with a cooperating proxy to hide
thier queries from a server.

-   need to know updates for certificates we already have
-   need to know when a given e-mail address gets a new key
-   need to look for a key for a new correspondent

some systems might work for one but not the other.

Why not have the keyserver report updates generally to avoid the
client? Bernd -- could use bloom filter

Justus: Keys.OpenPGP.org already has a
specification for how to publish updated keys, but it is not yet being
published by the
keyserver.  [https://gitlab.com/keys.openpgp.org/keystore-updates]([https://gitlab.com/keys.openpgp.org/keystore-updates](https://gitlab.com/keys.openpgp.org/keystore-updates))

Justus: classic approach is parcimonie -- update one cert from your
keyring at a time, randomly, running over Tor. Gives you regular
updates, based on how many keys you have and how frequently you're
willing to update.

Detect Tor if it's available.

Justus: if people use the octopus plugin for Thunderbird, this is
already happening.

Andrew: could a WKD server return all keys related to a prefix (based on
the hashed e-mail address)?

-   justus: downside to query by prefix is that it makes enumeration a
    bit easier.

dkg: could WKD servers publish a "recently-updated" keys?

Bart: you don't need a VPN, you just need a TCP proxy -- might be
easier to go through a corporate firewall

dkg: WKD (and any keyserver) traffic sizes are visible. traffic
analysis lets the network operator see who is being asked about, despite
the TLS connection. We need a standard padding policy for queries and
responses.

Justus: koo can look at the actual distribution of key sizes and
determine an optimal padding policy

Kai: what about blockchain or CT-style keys?

Daniel Huigens: key transparency work (at IETF,
focused on MLS). there's a tradeoff about enumeration, though.

Kai: should a public log have OpenPGP
certificates without User IDs? that lets you learn subkeys and
revocations

Bart: What else needs to happen with WKD?

-   advanced method has a false positive when there is a wildcard DNS,
    wildcard certificate, and a webserver that returns 200 for any path
    all create false positives
-   direct method fails with a webserver that returns 200
-   no multi-key support, a problem when new algorithms or key versions,
    etc.
-   specification is idiosyncratic, not actively maintained by the
    community
-   too many queries to determine whether it is supported
-   non-standard base32 encoding
-   duplicated local part parameters (l= query parameter allows the
    mailserver to canonicalize an address or to implement a catch-all
    address, implementations that use it ignore the hash)
-   truncated sha1 hash
-   abuse of .well-known (see RFC 8615?)
-   no padding

Andrew: there are so many changes here that it looks like you're
talking about WKDv2

Proposed changes from Bart:

-   eliminate direct method
-   be more strict about the policy file -- include magic string or
    some other strict formatting to be able to distinguish from random
    files served at all paths

Kai: do we still want WKD? or should we put more attention on
keyservers?

Andrew: WKD obeys the principles of e-mail in that it is
federated/distributed. we should keep it, and the keyservers aren't
sufficient. Keyservers should be a fallback method

dkg: how are we going to evolve away from an earlier WKD spec? do we
need a query parameter? do we need a way to announce that we don't
support v2 (e.g. for migration to a future version?)

### Historical email archive {#Historical_email_archive}

Daniel H, Andrew

Notes: Aron

#### Decryption of emails encrypted to old keys {#Decryption_of_emails_encrypted_to_old_keys}

Session key cache: Having a cache would speed up the decryption of
encrypted keys, but would not solve the re-encryption problem, because
that deleting the PKESK and keeping the cache
only will create problems when user change devices.

Re-encryption: see "Re-encryption of email encrypted emails to obsolete
encryption algorithms"

Full-text cache: Download, decrypt, delete from server. This would
resolve also (3)

#### Search across inbox/archive {#Search_across_inbox.2Farchive}

A cache would improve search performance, but not provide the desired
results.

Searchable encryption leaks information due to access patterns, server
side search is not really possible. You need to have a local index to
have a privacy compliant system.

#### Re-encryption of email encrypted emails to obsolete encryption algorithms {#Re-encryption_of_email_encrypted_emails_to_obsolete_encryption_algorithms}

Another solution is to have a "Public" key algorithm that is a
symmetric algorithm that would create symmetric
PKESKs. This could be used to replace the
algorithm ID in the PKESK. (Throw away old
PKESK and create a new symmetric
PKESK)

Neal: Why not use the SKESK?

Daniel: The SKESK is suitable for passwords, not
for keys.

Andrew: Why not define a different S2K?

Daniel: The PKESK has already the right
semantic, KeyIDs, Algorithm IDs, ... It's
just lacking the right name. We could rename
PKESK to "Key-Encrypted SK" and
"Password-Encrypted SK"


| Re-encryption Solves?  | Symmetric | Asymmetric |
|------------------------|-----------|------------|
| Legacy algorithm       | Yes       | Yes        |
| Old keys / rollover    | Yes       | Yes        |
| Decryption performance | Yes       | No         |

Solutions for Decryption (performance?):

-   Re-encryption - Not possible without collaboration from a MUA.
-   Session-Key Cache and throw away PKESKs
-   Full-Text cache
-   Plaintext local mailbox (+FDE)

Solutions for Legacy Algorithms:

-   Solutions for Decryption
-   POP / Deletion from the server

#### Record that a signature made by obsolete algorithm was verified when it was good (Also consider that hard revocations may have happened, backdated) {#Record_that_a_signature_made_by_obsolete_algorithm_was_verified_when_it_was_good_.28Also_consider_that_hard_revocations_may_have_happened.2C_backdated.29}

The symmetric "public" key algorithm could be also used for
notarization as a signing algorithm to notarize signatures.

Not to break the "Intended recipients" packet you should record the
verification status when re-encrypting.

### Intended Recipient Subpacket {#Intended_Recipient_Subpacket}

abbreviation: IRS

DKG: the IRS is a feature where you make a signature that contains a sub
packet that has a fingerprint of the public key that the message was
intended for.

The problem this feature tries to address:

-   how do you know a signed & encrypted message was really encrypted?
    It could be a signed message that was encrypted by a
    MITM
-   forwarding of messages: contains the signature of the initial
    sender, but was not intended for the final recipient the message was
    forwarded to

Syntax: for each recipient a new sub packet with the primary fingerprint

BCC: you do not use the sub packet to avoid putting information into the
message about the recipient

Concern: sending a cleartext message, no IRS surreptitious (sneaky)
forwarding

IRS cannot be removed from the signature because it is in a hashed sub
packet

Tombstone (empty) IRS signals the message was not encrypted.

What will you do with an encrypted and signed email without IRS?

-   treated as not valid signature
-   maybe case for visibly BCCed messages
-   not treat as a confidential (encrypted) message

Is signature without IRS valid if it is part of a message with a
SESK?

Related to cached signature validation

Different states.

-   invalid signature
-   no IRS
-   tombstone
-   IRS but no match
-   IRS with match

Reevaluate if IRS is the right solution for the problem.

Initially this problem is known since 2001 in the area of mailing lists
(Schleuder).

Encrypted headers could are a solution for this issue.

Might be inconsistencies between protected headers and IRS

Bart: the more we talk about it, the more I think IRS should not be
continued for email

Should this solution exits on the OpenPGP
layer? Difficult to explain to the user what is happening here.

Discussion of protected headers solves the problem completely or only
partly.

Is there a real world problem that cannot be solved outside of
OpenPGP?

Does the surreptitiously forwarded email problem be solved by
OpenPGP?

If not, then a simplification would be to remove IRS.

Kai: file that is too big for email and instead you share a link.

Bart: authentication in this example is if the link is the correct link.
They could replace the downloaded file with other file that is also
signed with the key of the sender.

Final words from DKG: frustrating session, topic is more unclear than
before

Wrapup (DKG): Not clear what signals the IRS gives in a message. In some
cases the IRS would render a signature as invalid. In other cases if
makes a statement about the confidentiality of a message. For many
things the IRS tries to do it doesn't make it right. We would extend the
IRS spec with a tombstone packet that can be used for cleartext signed
messages. There is an intersection between protected headers and IRS.
One solution could be: for email context you ignore the IRS, but that
has also consequences for SOP, because it means you get different
outcomes for different contexts.

### GnuPG interoperability {#GnuPG_interoperability}

Kai, DKG

Notes: Andrew

kai: would prefer if thunderbird was compatible with everyone

what do applications/consumers do?

bart: you can continue to use v4, or we can try to encrypt to both v5
and v6; may be technically possible

aron: also consider how to handle signatures

Technical issues:

-   encrypt to multiple recipients
-   validate signatures
-   key discovery, refresh
-   potential future wire format clash
-   multiple signature issues

bart: in immediate future v4,v5,v6 will have to coexist

aron: will future v6 work e.g. pqc be backported to v5? We may find
further points of divergence

dkg: most technical issues above also apply regardless of v5 existence

daniel h: we should encourage everyone to implement both v5 and v6, but
issues will remain

dkg: we have only one way to encrypt to multiple recipients using
multiple versions, and that is use v4

bart: best thing for openpgp community in long term is for v6 to
succeed. Too much choice has historically been a problem

aron: as proton we will disallow users to upload/create their own v5
keys but may support third-party v5 keys

nickolay: Best to understand everything but create according to your own
policy

kai: I see thunderbird as a power tool, and its users want to be
compatible

bernd: thunderbird can allow power users to choose

bart: defaults are powerful, you can set v6 as default. We are
supporting v5 in e.g. openpgpjs, but we still prefer v6

kai: Changing our default to v5 is off table, but am also reluctant to
change default to v6 because it breaks compatibility

dkg: we are going to have a conflict between v4 and v6 because v4 is
more compatible and we will be pressured to staying with it

aron: we already migrated our users to elliptic curve keys and it was
not that bad

falko: how is rollout planned anyway? What is strategy?

dkg: I expect rollout to start with signalling on existing v4 keys:
sha3, seipd2. Nerds will then generate v6 and use in parallel with v4.
Finally general rollout of v6 by default.

aron: thunderbird does not have to lead this process, can let others
with less compatibility concerns lead rollout

falko: can allow optional use for those who wish to experiment

nickolay: what is the standard implementation for apple mail?

andrew: most common is macgpgtools, which is downstream of gnupg

bart: am worried that an extended period of v5 compatibility will just
prolong the issues

daniel h: my proposal for everyone to implement everything is designed
to encourage future reconciliation

aron: we could bind pqc to v6, that will encourage people to migrate, to
avoid having to reimplement

neil: it is possible that gnupg users and v6 users already form
loosely-connected groups and therefore can't influence each other's
choices. German government mandates a full stack that uses
GPGOL which is therefore independent of what
other implementations choose.

bart: I don't want to force gnupg to do anything, I'm happy for
coexistence so long as those who wish to move on, can

nickolay: are there known security issues with v5?

dkg: there are some, but arguable that these don't affect pqc since
they only allow forging of v3 sigs. Easy fix is rejecting v3 signatures.

daniel h: in email context rejecting v3 should be possible, package
distribution can be treated separately

aron: there is an issue with sphincs wire format lacking salt in v5

justus: most implementations are not sufficiently forward compatible
with unknown versions, algorithms etc. Please check the interop test
suite and fix interop failures.

nickolay: can we ask v5 implementers to reject v3?

dkg: this is ineffective because the creator of the v5 signature can't
be sure the recipient is rejecting v3

### Action items {#Action_items}

-   pqc interop test suite (Justus, Aron, Falko)
-   ping mail clients to check header protection status (dkg, proton,
    kai, sandro)
-   header protection signalling (dkg, sandro)
-   wkd draft v2 spec (proton)
-   keyserver padding (KOO, andrew)
-   encrypted email verification (daniel h, KOO)
-   v6 forward compatibility ping implementations (Justus, Proton)
-   broken sig signalling (Kai, Patrick, Sandro)
-   shared lib api: patch draft and header file (dkg)
-   openpgp-ca key rotation etc. (kai, aron)
-   SOP: sig vs cert timestamps, intended recipint subpacket (dkg)
-   interop patching (sandro, dkg, berndt)
-   cleartext copy draft (dkg, daniel h)
-   copy cryptpad into wiki (patrick, kai)

### Next summit {#Next_summit}

#### Interim {#Interim}

-   october
-   virtual meeting 3-4 hours
-   need 3 topics to discuss
-   patrick to arrange venue/method
-   send list of uncovered topics to mailing list for poll (patrick,
    kai)

#### Full {#Full}

-   early june 2024
-   frankfurt or berlin
-   assume full in person
-   announce soon
-   fri/sat + extra hacking day?
