---
title: "Minutes of the 9th OpenPGP Email Summit (2025)"
permalink: /community/email-summit/2025/minutes/
---

{% include toc %}

## software represented

- Enigmail (Seamonkey/Thunderbird forks plugin)
- Thunderbird
- Hockeypuck keyserver
- keys.openpgp.org keyserver
- Proton
- Delta Chat
- rPGP
- PGPy
- FreePG
- Debian
- Sequoia
- RNP
- OpenPGP.js
- go-crypto & GopenPGP
- Parula MUA

# Reports

## Action items update

* v4 PQC (Aron) we decided not to
* header protection (dkg): draft ready, waiting for RFC editor
* forward compat (kai): two key handling modes in RNP: strict and relaxed. TB will use relaxed mode for public keys because strict mode strips too much
* HKP (andrew): draft in reasonably good shape, will discuss later. 
* v4 -> v6 migration (andrew): key replacement draft ready for WGLC, no progress on BCP
* autocrypt 2 (holger): have been some discussions - discuss later?
* copy pad to web page (justus): done, is no longer maintainer 

# Plenary talks

## Further PQC KEMs (Falko)

Currently only one standard PQ KEM (ML-KEM) but it is not universally trusted, therefore it is commonly required to be used in combination with a traditional algorithm such as ECDH. But in post-quantum era, ECDH is no longer a protection, so ML-KEM is once again untrustworthy. Options: dual PQC KEM, or a stronger KEM. Candidates: HQC (error correction code), FrodoKEM (unstructured lattice), NTRU (structured lattice). NTRU is v similar to ML-KEM and FrodoKEM is inefficient, so HQC looks most promising.

Daniel H: we should also consider forward secrecy  
Georg: can add another symmetric encryption layer  
Stavros: BSI might fund speculative HQC proposal, but let's not delay current PQC draft implementation. Hybrid KEMs protect against not just  theoretical attacks but also implementation flaws.  
Andrew: if we want to prioritise stronger security properties, HQC+ML-KEM might be best (Aron: agree)

## v2 Autocrypt (Holger K)

Keyservers and Autocrypt must tackle the problem of initial binding of identity to key. But in instant messaging, the identity *is* the key. Dealing with identities then becomes a UI problem. We could use vcards to improve usability, since it interoperates with existing tooling. This also allows us to hide the "real identity" inside the encrypted part.

dkg: email addresses serve two purposes: identity and routing. If we decouple them, does this open other problems e.g. fingerprinting?  
nami: note that with chatmail servers, email addresses are no longer a limited resource.  
Ben: note that a single identity is not one key, but a sequence.

HK: v6 and SEIPDv2 now supported in DC, hope to roll out in 2025. We also disabled a lot of features to reduce attack surface, e.g. key import.  
DH: want to keep the email UX of cold emailing to an address from e.g. a website  
Friedel: encrypted email is fundamentally different, maybe it should be a different UX.  
Ben: we could add query parameters to mailto urls

# Working groups

## vcards (Nami)

DH: Proton and DC support Openpgp in vcards (vcf), but interop not fully clean.  
Bart: Correspondent cert stored in vcard then vcard signed over by local openpgp key, which pins the key to the email address for local use. Vcard has substructure that can have multiple associations in a single vcard.

Ben: JSContact may be a better format. It's an IETF standard and basically the new version of vcard. There's existing discussion in the IETF JMAP working group by Phillip Hallam-Baker about how to add keys to it. https://mailarchive.ietf.org/arch/msg/jmap/aDQ3U5IVDYd5B2KzNcr7tVBb-sQ/  
HK: note that in DC/Autocrypt we are trying to use existing formats as much as possible.  

Bart: it is possible to make a more compatible vcard, it is only a problem for providers who only support older vcard versions.  
DH: we can store other information in vcard, e.g. this person only supports inline, disable encryption for this person etc.  

HK: do you sign vcards for export as integrity protection?  
DH: we could, but currently only use it for local reasoning.  

dkg: how should we guide implementions to use vcard?  
HK: what is the minimal specification that we can define?  
DH: you can concatenate entire address book in one vcard, but at Proton we have one vcard per person/contact and sign separately.  
dkg: does proton normalise this structure on import? Bart: not sure.  

dh: DC attaches the pgp cert to the top level of the identity structure, but proton attaches it under each email address. This causes interop issues.  
ke: is the intent here to standardise a way of attaching extra information to the cert+email?  

dkg: use cases? a) DKG sends Andrew's vcard to Holger b) DKG sends his address book to himself (on another device)  
ben: c) publish my own updated details to my existing contacts  

bart: our keyserver gets scraped (we generate nonsense keys to confuse scrapers). User may want to publish extra information, e.g. here's my website, social media etc. and keyserver is not appropriate method. Also need internal business directory.  

andrew: this is better way for people to publish profile pictures (compared to image attributes)  

dkg: how do we avoid phishing attacks where people create fake vcards with other people's personal info?  
bart: we only show vcards to existing contacts, you have to accept the contact first or be in the org to see e.g. the avatar  
nami: autocrypt gossip can distribute vcards when people are in cc  
dh: you can't know that the mail was actually sent to the people in cc  

holger: important that people can manage their own social graph, vcard is widely supported export format  
bart: we show logos for domains that we have vetted, as an alternative to e.g. bimi (ben: please publish!)  

dh: not sure this is "autocrypt v2" - importing vcards is a manual process  
hk: idea is that I can see a vcard in another app, click on a button, and email the contact with encryption already configured  
ben: I can attach a vcard to an email and non-aware MUAs will not panic, but when I click reply on such a message an aware MUA can configure the encryption without further user interaction  
dh: should work on more interop first  
ds: how does this integrate with other key discovery methods? And how do I present the state to the user?  
hk: trying to be completely independent of key discovery, vcard is just a data representation format  
nami: trying to simplify UX flow  

bart: maybe this is a solution to the "weird attachment" problem  

andrew: need to be careful to distinguish encryption setup and identity management


## PQC (Aron)
attendeeds: Aron Wussler, Falko Strentzke, Friedel Ziegelmayer, Justus Winter, David Runge, May-Lee Sia

### IETF PQC draft
- considered "stable" by Aron Wussler
  - open topics: seed vs expanded format in some implementations
  - question: is it ready?
  - changes to KDF may still need to be done, but otherwise should be finalized this year
- JW: last feedback remarks from Justus
    - do get last call
    - give implementations time to finalize based on final spec
    - porting of interfaces can happen later
- DR: finalize RFC also to give hardware implementers more reason to incorporate it
- AW/JW: some of the descriptions are quite lengthy for specifics around rationale and decryption

### NIST curve document

- AW: nice addition, but hard to justify business need for implementing it

### Further combiner PQC

- HQC + ML-KEM potentially interesting for BSI
- HQC artifact size is large, while ML-KEM is ~ 1/10 of the size of HQC
- HQC is faster than ML-KEM but there are no performance issues on either side
- FS: HQC draft will be delayed until it becomes relevant
  - AW: write personal draft to outline HQC use, publish it and see if it can/ should be picked up in the future
- FS: no reason to wait for HQC

- AW: extension to forward to PQC in the future is still unclear
  - open question around security and complexity of implementation
  - FS: alter scheme due
  - AW: KDF may be a reason for complexity, but not unsolvable

### Transitioning

- AW: if we want to move from v4 to v6 it may be good to combine this with PQC (to avoid switching costs)
- v5 allows attaching PQC keys to v4 keys and is not compatible with v6
- JW: maybe roll out as PQC + v6 instead of v6 and then PQC
  - FZ: different between v4 and v6 is negligible
  - AW: proton users request PQC (biggest selling point)
    - needs time to deploy it (60+ platforms/clients)
    - v6 is already rolled out in test accounts with a few issues fixed
    - FZ: is there special handling for v6
      - AW/JW/: some mandatory combinatory fixes and implementations, e.g. aes, sha3

### Implementations

- FZ: ML-KEM for RustCrypto appears pretty much usable
  - JW: investigate the use of seed vs. expanded representation in secret key format
  - FZ: RustCrypto currently supports only expanded version, but ticket exists to create seed version as well
- JW: drafts for ML-KEM exist in nettle, but might take quite a while still
  - OpenSSL wants to ML-KEM DSA in 3.5 and nettle
  - Botan has support

### HSM use

- AW: seed vs. expanded version
  - PQC draft uses seed representation
  - X.509 allows seed or expanded OR both due to pkcs11 requirements

### Takeaways

- last call for draft
- create draft for HQC for future reuse
- relevant crypto implementations partially have support already

## Multi-device (Daniel H)

- Holger: what exactly is multipe device referring to?
- Daniel H.: user wants to send a message to a user with different devices with keys
  - Proton syncs private key across devices
  - Other solution is key per device
  - Subkey selection depends on the choice
    - In this case want to have senders encrypt to all keys
  - If the ecosystem could agree on a common solution, this would make it easier
- ...: adding new device with different key means it cannot decrypt old messages
- Justus: reasonable is only to have one encryption and one signing subkey per device
- ...
- Justus: multipe subkeys are bound by the primary key. Allows to use hardware-backed keys. You have to expose the information how many devices you have.
- Kai: Multiple subkeys for multipe devices requires the clients to encrypt to all subkeys. This is currently normally not the case.
- Ben: Loosing a key/device would means loosing some earlier messages
- Daniel H.: Could also have a backup on another HSM and ask senders to encrypt also to the backup key.
- Holger: This requires all clients to deal with the multipe key scenerio.
- Justus: That is not more work
- Holger: The software has to take decisions etc.
- Justus: You are dismissing my use case
- Holger: Because of hardware backed device your scenerio requires a huge task
- Daniel H.: Multiple devices are considered to use the same email address. Not caring for hardware backed devices would be one way, but not everyone will consent to that.
- Holger: Multi device is a known use case, but having separate encryption keys per device is a different problem, because it requires all communication partners to adapt to it.
- Hocuri: Hardware backed encryption is not a main use case
- Daniel H.: Do you have users asking for this use case
- Justus: We have users asking for TPM-backed keys
- Nami: Hardware backed keys is a use case
- Hocuri/Daniel H.: Maybe we cannot settle on a single model  
- ... Focus on the case with single certificate
- Daniel H.: might have flag in the certificate to signal the model of one encryption key per device
- Justus: We can defer this to the subkey selection slot
- Daniel H.: If we can't agree we might need a flag in the certificate to indicate the encryption subkey selection that is preferred by the holder.
- Kai: If one device doesnt't support for instance PQ this will lead to not being able to read some mails.
- Daniel: Thus we will need flags. Sequoia currently encrypts to all subkeys?
- Justus: yes.
- Kai: We might define such an optional flag, default would be "encrypt to strongest"
- Justus: everyone has different use cases in mind. But it's not nice to dismiss the hardware key use case because the own user base doesn't voice it.
- Patrick: What is bad about sending to all subkeys?
- Kai: There might be weaker keys that shouldn't be used
- Stefan: That should not be decided by the sender, but the one who creates the certificate Encrypting to  all keys should be OK.
- Daniel H.: Adding a weaker traditional key might be because of backwards compatible
- Patrick: For subkeys should use all subkeys, for multiple certificates use the strongest one
- Daniel: If we need both models, we need a flag.
  Andrews draft says that you should consider different certificates equivalent.
  Thus different behaviour depending on whether subkeys are in same certificate or not is compatible.
  Are we saying that multiple subkeys are only for multiple devices?
- Kai: we should ask this on the mailing list
- Patrick: before we agree on that, we have to find out what are subkeys for


### Potential solutions

- One key for all devices
  (and sync key material)
- One key per device
- One (encryption and signing) subkey per device
- Derived/deterministic keys

## FreePG (David)

### Brief history
Many maintainers (Debian, Arch, Fedora, NixOS) had to patch manually GnuPG for systemd and other requirements 

GnuPG has 4 branches
- Classic, untouched (no ECC)
- stable 2.2, EOL
- stable 2.4, EOL announced
- Master, no more systemd
GnuPG has its own deamon, and when you close the session -> close all the agents (that may end up dangling)

There are approx 30 patches in FreePG:
- Systemd integration
- Patches for interop with key servers
- Discourage producing LibrePGP artifacts (default mode OpenPGP instead of GnuPG)
- Don't set flags for LibrePGP capabilities
- Cleartext trailing lines fix
- Text sig over Binary literal
- Fix to the large RSA key generation

=> everyone who's patching GnuPG please contribute your patches to FreePG and pull FreePG instead
The work is now patches and some integration testing of the patches - but mostly using GnuPG's testing suite.

There's a main branch, containing ordered pactches and they get applied by hand

### Governance
Andrew is the buider, but does not take governance decisions, acting as chair.

Good strategy to communicate between maintainers, would be cool to have mac people around.

### Plans for the future
Do we wanna endorse FreePG? Which features do we want to keep developing? 
Should we push people to move to chameleon instead of GPG?

We could make a list of projects (large dependencies) that we could track to get rid of GPG.
Main projects identified on the spot:
- git
- pacman
- kde
- pass
- duplicity

Apt and dpackage and devscript no longer depend on GPG, but there is stil tooling depending on this

Seems like there is need for FreePG for a long time. Since we will need PQC, we need to ship it in FreePG.
In order to implement PQC, we need v6.
Implementing v6 signatures in FreePG may require a large restructuring, because of the way signatures are created.

Can we push more projects to use chameleon instead?

PQC v4 encryption could help with FreePG, because changing v4 to v6 adds friction. With GPG, you just get a v5 PQC subkey to a v4 key.



## Key migration (Andrew)


Andrew: replacement-key draft is done except for a minor concern: fallback encryption to other keys?

- dkg asks: What are the user stories?

- Andrew: user says i want to upgrade, and indicates which the old key is it wants to replace.
 - in expert mode, it lets a user  create a unidirectional binding from the replacement to the original, and they have to go back to the original and add the pointer later.

- Neal: i think it the v6 key should be created as part of the certificate maintenance.

- Kai: i wouldn't do the upgrade automatically -- what if two different implementations using the same key create new replacement keys?

- Andrew: shouldn't happen automatically if a replacement-key subpacket already exists.

- Kai: an updating tool should refresh their own certificate before trying to do this kind of upgrade.

- How do we handle simultaneous updates?  after the devices re-sync to discover, the most recent one wins, and the graph can be rewritten to designate the older replacement as another original.


Producer use case: user wants to update their existing v4 key:

- preflight checks:

   - self-email
   - polling keyservers
   - time delay
   - user prompt

- client-driven refresh creates new v6 key

- consistency test.  if inconsistent, then:
  - re-sync with other certificate
  - if multiple replacements exist, demote older replacement.

Producer use case: I'm making a new v4+v6 key combo

Producer use case: I have a v6 key and i want to offer a v4 key for fallback

All of the above should be solvable with the existing mechanism as long as all the secret key material is available locally.

Producer use case: i have one secret key, i notice that it's marked with a replacement, but i don't have the secret key material for it; trigger a sync from your other device.

The graph this mechanism creates can't have loops or chain on indefinitely.

The edges are only valid if they are bidirectionally asserted.

significant discussion around whether the draft should say anything about an unreciprocated linkage.


question about how many "steps" the consumer should take in the case where unidirectional linkage appears.  Rough consensus seems to be "one step".


Consumer story: client does refresh from keyservers:

- finds pointer to the new cert

- verifies bidirectional linkage

Is it "sticky?"  that is, should the implementation automatically apply "validity" to the replacement key that would persist even if the binding is no longer bidirectionally valid?

Would folks use this mechanism to create a v6 cert?

several yeses (dkg, david, Aron; kai "yes, as soon as TBird supports v6"; Neal: this seems more complex than i'd like, but i don't see other approach on the table)

Justus (after session) says "i want an updated key, but i don't want my peers to all prefer it automatically because i might not be able to read messages from it".

## Manual key verification (Nami)

Delta Chat has manual key verification via QR code scans: https://securejoin.readthedocs.io/en/latest/new.html (the QR code contains a fingerprint and an authentication token; a single QR code scan results in both-sided verification).

Also, it's possible to encode the same information into a link instead of a QR code. Then, the user can click on the link, transfer it via a secure channel, and will get the verification.

Proton is thinking about introducing something similar. What would be useful for them is a) adding a contact via a QR code b) if there is a contact-specific QR code that contains both fingerprints, use it for verification.

Some experimentation with Signal.

We discuss about whether it's enough that Bob verifies Alice's fingerprint, or whether Bob also has to verify that Alice knows the correct fingerprint of Bob.

Closer inspection of the securejoin protocol.  Trying to see whether it can be improved by providing the fingerprint of the party creating the invitation.

UI considerations.  Possibly one message could be optimized away.

Problem with people sharing invite links to social media, defeats the purpose of two sided verification and opens up phishing vectors.  People don't read the warning not to share the links.  Possible workaround: make the two-sided verification stop working after X minutes.

Privacy concern if both fingerprint are included in the link, leaks the link between the two persons.

# Day two

## Cleartext (non-disturbing) signatures in headers (dkg)

dkg: There are lots of ways that we could do non-disturbing cleartext sigs, but headers appear to be the best candidate. DKIM already does something similar at the domain level and is relatively robust, so let's reuse the concept. Use the DKIM normalisation rules, but sign over using openPGP and place in headers like DKIM signature. This could solve both the strange attachment and broken signature warning messages (broken signature == no signature)  
justus: worried about DKIM normalisation, which is ill-defined for MIME  
bart: worried about size of PQ sigs; could we put in a MIME body part header instead?  
kai: that would only work with messages that are already MIME, or we would need to convert to MIME  
falko: don't agree with BS==NS, I want to debug signature failures  
dkg: we don't want to bother normal users with confusing warnings, if we want to build a debug tool for experts, that's OK  
patrick: can we put it in the MIME part instead?  
dkg: advantage of DKIM style is that outer headers are also signed, this can't be done if signature is inside MIME part  
alex: if we're using protected-headers, the headers are inside the MIME part already, so they are covered  
dkg: protected-headers requires MIME tree reorganisation, which would be unnecessary with DKIM style  
bart: needs interop testing; we could come up with a novel MIME structure that doesn't have the strange attachment issue  
patrick: we could use a multipart-mixed with only one part, and put signature in the part MIME headers  
kai: multipart could also solve mailing list footer breakage  
alex: putting inside MIME part means that DKIM signature would also cover the PGP signature, so it couldn't be stripped  
andrew: we could add an optional parameter to the content-type to signal use of this mechanism  
patrick: structure should be self-contained - everything in it is signed, everything outside is not  
alex: dkim2 spec in progress, will require relaxed/relaxed normalisation because that's what majority of mail uses already  
kai: DKIM style signatures would require an end marker  
andrew: we can use DKIM length parameter?  
alex: it's unclear what then to do if a footer is added, DKIM is trying to deprecate because of efail  
kai: there are scenarios where people pass signed mail via gmail outbound, but gmail adds an smime signature, which breaks the pgp signature  
andrew: need to be careful also with apple ecosystem, where apple requires that mime en/decap is done by the apple api, not the app code  
alex: could we use a proton bridge style interface?  
bart: bridge is supposed to do all crypto operations  
dkg: what about encrypted signed messages? Perhaps this system is only for cleartext signed, and encrypted signed should be done by existing methods?  
andrewg: we should strongly encourage that encrypted signed messages should be done in the pgp layer and just pass the encrypted blob to the MIME layer  
bart: we don't need the outer content-type hint, we should always look for the signature inside.  
dkg: header protection should be mandatory  
andrew: signature header MUST come first, signs over all following headers + body  
kai: need to support multiple signature headers  
andrew, dkg, kai to draw up spec
https://gitlab.com/andrewgdotcom/cleartext-signatures

spec:
* top-level message headers contain content-type: multipart/mixed
* message headers are copied into outer mime part using protected-headers method
* one or more prefixed "Signature:" headers inside outer mime part
  * All "Signature:" headers MUST come first
  * Each signature header contains a type prefix, and a base-64 encoded data part, e.g. "t=p; AABBBBCCCDDDEEEFF..."
  * Signature signs all non-Signature: headers plus the body part inside the mime part
  * Uses standard header whitespace and line-breaking rules
  * Potentially extensible to smime, using different type in "t=" prefix
  * For OpenPGP, the base-64 encoded data MUST be exactly one complete signature packet

Draft should contain spec, client guidance and test vectors.

PGP/MIME encrypted messages should remain as is, and not use the spec described here

## Exporting the social graph (Nami)

This session is not about synchronizing key material to a new device, but assumes it has happened already.

We attempted to determine a format we could agree on to have some way of synchronizing contacts and their public key material with the user's own devices regularly.

Or at least get to a preliminary understanding of how clients are synchronizing and how we can do it without stepping on each other's toes
Discussion of Vcards vs. JSContact (RFC 9553)

- Vcards are widely used but spec can be unclear
    
- JSContact (RFC 9553) is more clearly defined but would mean switching
    -  However RFC 9555 describes going from Vcard to JSContacts

Orthogonally:

Self-sent messages are marked in the same way that autocrypt setup messages are marked.
The body includes the data format (either VCard or JSContact, which we couldn't completely decide)
This data MUST be encrypted unless it's local

More discussion:
If fully encrypted, you can use JSContact
(We lean towards JSContact, but it can be that a Vcard is more expected by the receiving user)

Ben suggests: we decide how to add keys to it from the outcome of the existing discussion in the IETF JMAP working group by Phillip Hallam-Baker about how to add keys to it.:
https://mailarchive.ietf.org/arch/msg/jmap/aDQ3U5IVDYd5B2KzNcr7tVBb-sQ/

But we probably need a way of synchronizing which is compatible with existing IMAP servers


Action items:

- talk to Thunderbird about how our approach is feasible for them
- move Delta Chat Contact synchronization to JSContacts and specify it so others can build upon it
- 


## Expect Signed Mail (dkg)

Existing draft from dkg and Aron: draft-dkg-lamps-expect-signed-mail

We want a signalling mechanism to say that "all my message will be signed, unsigned messages and broken signatures should be flagged".

We need to be able to show warnings for broken signatures, which means we should also warn for unsigned messages since it's equivalent for security. MUAs are unwilling to do that by default. We need a transition similar to HSTS.

Open questions:
- What is the scope of the declaration? Domain or email address?

Ways to signal this:
- DNS
- Certificate
- Signature
- Message header

What should you do if you get an unexpected unsigned message?
- Warn the user
- Report back? Like HSTS report

Bart: Analogy to HSTS would be to put an email header that is cached. Though it could be stripped.
For transport, we have DANE and MTA-STS serving this process. Those are out of band.
Perhaps this should be out of band as well. So not a header.

Daniel G: Can't be DNS, because some clients can't resolve it.
So it should be in the certificate then.

DKG: Current draft defines a header.
Unexpected unsigned -> warn, or give inline feedback, in a (response) email to the sender.
Can't send a new message, is a web bug.

Andrew: Closer to DMARC, then.

DKG: What if I enable the flag and then change my key?

Bart: Could put it in the certificate.

DKG: But then if I have two certificates? Can the signal be different?

Andrew: If you put it on the certificate, you need to have it to see this signal.

DKG: But if the attacker can strip the signature&cert they can also strip the header

Daniel H: And the OpenPGP library can't know whether to set this flag

Andrew: And you'd want to set it per email address, so it'd need to be in the User ID self-cert
Handling User ID-specific information is not well-supported

Patrick: And you might want a certificate without a User ID

DKG: If I set Expect-Signed, but then send a message to a mailing list that's forwarded without a signature, should you get a warning?

Patrick: Probably yes
And what if you send different values to different users?

Daniel H: Sending a signed mail should never hurt

DKG: But what if I want to undo?

Andrew: Let's not handle per-recipient
We can have a three-state header, default (empty) is to leave as-is; explicit opt-out needed

DKG: Opt-out could be an expiry in the past

(... more discussion about mechanism)

DKG: We need some deployment experience
We have a description of how to do it with a header, we can try that and see whether it works well.

Andrew: Who thinks header is most promising? (Everyone except Neal and Bart)  
Neal: should be in a signature  
Bart: should be in the certificate

DKG: How to handle mailing list?  
Could rewrite the From address  
The scope should be the From address

Patrick: Mail header makes it easier than a signature, because then it's clearly bound to the sending email address

Bart: If you put it in the certificate, then it lives in the cert store
Can update it with syncing and WKD etc

Patrick: But if you have multiple certificates you need to update all of them

Andrew: you could put it in an unsigned subpacket

David: If we put it in DNS, then we might have timing issues

Andrew: and it's gonna per per domain

DKG: Could do per address

Andrew: But doesn't scale

Bart+Daniel H: should discuss Prefer-Encrypt and do the same thing

Andrew: Should put that in the certificate

DKG+Andrew: Should keep it separate

Neal: Could do both in the certificate and in a header  
Updating a header is more agile  
Thunderbird is averse to updating certs  
Need to define an order of preference  
DKG: can I override the value in the cert in my email client?

DKG: What if one client sets the flag and another doesn't send signed mail?

Daniel H: Need to know that all user agents sending signed mail

Bart: could analyse all mail and check if it's signed

DKG: Are we OK with the report back on reply?

Andrew: Sounds like an abuse vector  
I want to stalk someone, send them an unexpected unsigned email

DKG: But it's only when you reply

Bart: Could be a user action  
Could leak that signature verification is broken :)

Andrew: Could leak local state of your certificates, or which client you're using

(... more discussion on whether we're leaking something sensitive)

Neal: we should only signal whether the signature is mathematically valid, not whether it's authenticated

DKG: But what if it's signed by a different person's key?

Neal: Should be bound to a fingerprint


## Deterministic keys (Georg Schmidt)

- idea is to create OpenPGP private keys deterministically based on passward-derived seeds
  - KDF input is  also  the email address
  - PGP is normally creating a creation timestamp, that can be set to fixed value instead
- Aron: we have done resarch at Proton regarding the use of mnemonics
  - at proton we generate deterministic fake keys for non-existing email accounts
  - mnemonics come in handy because they are generated by the system and have 128 bit of entropy
  - The problem is that the seed-password can never be changed; problem when it is leaked
  - Proton has a backend and thus choose to encrypt the keys with a user password instead of using deterministic key generated at the client side
  - Most OpenPGP prevent you from generating deterministic keys
- All signatures of the certificate are supposed to be deterministic as well
- The question to answer is whether this approach is an advantage and doable
- Aron: Proton solved the problem of deterministic generation only for a single implementation
- Aron, Falko, ...: you would need to rework all the OpenPGP stack to achieve a solution for reproducible keys
- Kai: would it still make sense to write
- Falko: would be relevant to create QR codes for private key transfer
- Aron: I like the idea because of the easy transfer, not depending an any synching mechanism
- ... Can have forward secrecy by deriving key also from month/year information, this leads to a new seed
- Kai/Aron: solution can also be to have a non-interoparable solution for a single client
- Bernd/Aron: Third party signatures etc. will not be maintained by a seed-based certificate
- Georg: Other idea is to store password-proteted keys on IMAP that are encrypted with public/private key pair
- Aron: This is done at Proton but it turns out that developers often have questions about the details.
  - There are the 3 main approaches:
    1. If you store the keys on IMAP encrypted with the same seed then you have complexity in operations regarding synching changed keys
    2. Deterministic key generation has complexity in the generation itself
    3. 3rd option is key hierachy: master key that encrypts the OpenPGP keys. This creates complexity in the implementation. This is our choice at Proton
- Kai: this seems quite complex. If it comes to deterministic key generation, does each application have their own considereations or does it make sense to document this centrally  as a recommendation
- Aron: I would do it public
- Bernd: As long as no consumer is involved, it doesn't have to be a general stanard
- Aron: If in public, the advantages are:
  - forces better documentation than writing only in private, 
  - you have review process, 
  - if wanting to interoperate, then the public doc would be a basis
- ... Sync-service is a simpler solution like signal implements it
- Kai: what is the best place to maintain such a document / discuss / work out this further
- Aron: The OpenPGP Email Mailing List would be a good forum
- Kai: if I work out such a scheme for Thunderbird, would it be sufficient to work it out with interal team or should I do this in public
- Georg: Public standard should be ensured to be secure
- Aron: It makes sense to make a proposal publicly available for review. But you should consider what you really need; if other approaches like synching are available
- Bernd: I would recommend to use well-tested schemes. Deterministic key generation works for instance for Bitcoin.
- Georg: When we use BIP 0032 keys, can we wrap them into OpenPGP keys?

(followup from dkg: please take a look at FIPS 186-4 provable primes from )

## Forward Secrecy

- Daniel H.: if someone compromises your key material and an attacker holds your ciphertexts, can they decrypt the messages?
- Dkg: Important to distinguish between "Perfect Forward Secrecy" and "Forward Secrecy" as there is always a window of opportunity. Prefers "deletable messages"
- Daniel H: Messages can be held in a backup location encrypted with symmetric keys
- dkg: distinguish between device seizure and breaking of cryptographic primitives
- falko: we should assume the maximum attack scenario (trojan/ passphrase exfiltration)
- dkg: users should have guarantee that messages they can't decrypt anymore can also not be decrypted by attackers
- alex: delta chat can delete messages on a running average ("disappearing messages")
- dkg: to be able to use mail as  
- friedel: archiving should be out of scope for this setup
- andrew: cleartext needs to be made inaccessible on seized device
- daniel h: propose short-lived encryption subkeys on a static primary key
- alex: how to make others use the latest encryption subkey?
- andrew: double ratchet
- justus: implemented double ratchet a couple years ago based on signal spec (no sync server, no header specific changes). First mail introduces an offer of the first subkey. Recipient can use the option to get ratchet going.
- dkg: are there new subkeys/packet types to handline a double ratchet?
- justus: adds an additional packet that was meant as an opportunistic update path
- dkg: what is multi-device story of this?
- justus: implementation leaks amount of devices, as devices hold local state. otherwise syncing is required
- dkg: seven connections if there are two and three devices in a conversation.
- gultsch: session handling has to happen between each device of a single user.
- justus: is state handling a problem for omemo?
- gultsch: omemo has the server as middleware to handle state. with mail the first device may not receive encrypted mail but would need to check in with existing devices. MLS makes this all easier
- alex: signal's implementation doesn't have the same guarantee for one-to-one vs. group chats. messages in groups may be out of sync and users may not see what other users see (or have proof for it). MLS implements this based on a shared group-diffie-hellman, so all devices need to negotiate the group key.
- andrew: what about old devices? when are they disconnected?
- dkg: never: same problem as with short-lived encryption subkeys. devices that are switched off are not ratcheted and attacker may exfiltrate old session keys.
- alex: forward secrecy should not be broken
- holger: think about syncing and non-ordered scenarios. that seems to be not a solved problem
- daniel h: person at Mozilla built web app doing MLS over S/MIME. may have race-conditions. how to map e-mail to MLS: given set of participants is a group. if someone is added to thread, it's a new group. if message is sent to new group, new initiation message is sent, so all participants know how to encrypt. MLS seems most promising way forward instead of short-lived encryption subkeys.
- dkg: if all history is copied and the device state is seized, some state is recoverable. what is the timing that we can nail down? what are additional privacy concerns, how are additional devices exposed to the outside.
- daniel h: multi-device story: one user as MLS client, instead of exposing all devices (potentially use MLS for syncing the user devices).
- justus: this assumes only one client. how does deltachat deal with state?
- alex: we could consider doing something like MLS, but only between the user's devices (create encryption subkey, send to MLS network to update all devices and then send updated pubkey to actual conversation participants).
- dkg: what is MLS transport for altering device state?
- alex: also email as transport (message to self)
- holger: imap append,
- dkg: how can others join deltachat clients?
- holger: PGP forward secrecy: rather do time-based key setup than ratchet (as ratchet complicates things).
- andrew: if we use MLS for user devices, should we propose it as multi-device sync?
- holger/ daniel h: was discussed as possible option in previous discussion.
- andrew: multi-device one problem, while forward secrecy is orthogonal
- daniel h: is double ratchet realistic for sender applications?
- dkg: could be done unilaterally.
- andrew: pro for double ratchet: all in-band (how to distribute new subkeys is all separate). MLS can also do that.
- daniel h: post compromise security possible in MLS.
- dkg: short-lived subkeys are also post-compromise security based on a time window.

## Email identity verification

What is the confidence threshold to use a certificate for email for encryption / signature?

KOO can be used as an OpenPGP CA, this would solve the problem
-> establish a list of known OpenPGP CAs and trust keys signed from these

KOO would verify the email receiving capability, therefore a one time access to the email would grant a signature, a MITM.

S/MIME have standardized 3 levels: Mailbox validated (same as KOO) or stricter identity check (via phone and such)

What about having 2 factors (e.g. WKD and KOO, or Autocrypt and KOO) over time, the more hints you get the more confidence is built into the key

KOO could do repeated emails before adding a signature (and re-verify its currency), but KOO is not interested in being a CA.

Using automatically KOO data creates decryption issues on the receiving side because many people did not know they have PGP keys on KOO and did not expect encrypted email. Feature had to be disabled.
Autocrypt solves this issue, but it is unsigned in the email.

Complicated heuristics will be a problem, so make it configurable with sane defaults and have 1 factor only.
There are 3 user types:
- Non-crypto friendly users
- Experienced
- Business

We can use TOFU, like SSH. This will cause issues on key rotation, that are rare.

Thunderbird could send encrypted emails when there are 2 methods, and prompt the users when there is only one method. But users don't read - and this will cause confusion.
In SQ, there is a local certification for each system (WKD, KOO, OpenPGP-CA, ...) and then the user can choose how trusted is each system for them, and if the sum is over a certain threshold the key is used. For normal users the weight should be 1 for most systems, and power users could choose what to do.

## Prefer Encrypted Mail

Not everyone who publishes a PGP public key is ready to receive encrypted Email.

Undecryptable Email is the worst thing.
Autocrypt has the prefer-encrypt=mutual flag to signal that.
In Autocrypt it is bidirectional/consensual, both need to want encryption so it starts.

Suggestion 1) by Daniel Gultsch: add it as an URI parameter to the mailto: URI

Suggestion 2) by Andrew & Bart: add it to the certificate;
- disadvantage: the openPGP library doesn't know the user preference, that's the MUA's job
- disadvantage: an openPGP certificate can have multiple email addresses, but encryption preference is typically associated with an email address
- disadvantage: if it's in the cert it is hard to change
- advantage: this way it is agnostic to the transport mechanism which transfers the certificate

Suggestion 3) by missytake: add it as a key/value parameter to the VCard
- e.g. if KOO or WKD emit vCards in the future

Suggestion 4) the Autocrypt header
- advantage: it's regularly updated
- disadvantage: doesn't work for cold email

Suggestion 5) by Daniel Gultsch: in a WKD response, add a prefer-encrypt=mutual header, and in absence treat it as nopreference
- Proton already treats WKD presense as prefer-encrypt=mutual; but it does lead to problems, e.g. when Airbus published keys their employees couldn't use

Problem: getting multiple different preferences from different sources leads to conflicts

In general: you can probably receive encrypted Email when you have solved the multi-device problem


## HKP

- bart: hashing in WKD is a problem.
- andrew: hashing explicitly there to make easy to serve from disk, but hard to search.
- bart: we want people to set domain server to point at proton hkp server. wkd is a lot of setup party. wkd 2.0 would be much better
- aron: tooling for WKD was mostly painful to use.
- andrew: initial hkp was heavily designed around URL parameters. newer APIs are path based. hkp v1 (hkp v0 was never standardized) uses query parameters as path components (so business logic can be reused). fix a lot of issues in queries with use of key value pairs. encourage people to use new verbs (authget email string, or fingerprint, keyid (deprecated, but in for backwards compat)).
- aron: you should not lookup pkesk
- andrew: any integration that still uses key-id packets requires key-id lookup support.
- bart/aron: key-id lookups can be circumenvented by fingerprint hashing server-side
- bart: local parameter in user id unhashed
- andrew: lookups by user-id are akin to a search. the client needs heuristics to deal with the returned sets of data.
- andrew: new API more well defined and stricter. keyserver only supports v6 keys over the new v1 API, v4 etc. still supported via v0. new hkp API is different. WKD relied on authoritive claim. we want to combine these two by lifting restriction of having policy file that allows to point at a keyserver. 
- aron: why not use normal policy file.
- andrew: can't break gnupg.
- bart: why not use DNS? maybe call hkpv2 to not confuse people that are unaware of its history? for later: does current WKD allow more than one certificate per UserID?
- david: no, but many implementers use it like that either way because use-cases exist where two active certs per userids exist (temporarily).
- andrew: hkp returns a number of certificates. authget on policy file defined keyserver is returning plausible certs (implementation detail)
- aron: how does it interact with replacement key? wkd only provides one which is convenient.
- andrew: according to replacement key draft specifies ordering by preference (which is exposed on keyserver). if multiple certificates need updating, KOO accept certificate bundles and uses the received ordering. 
- aron: picking the first one readable sounds usable.
- neal: authget probably problematic. why not use a third-party certification.
- andrew: server may return
- neal: what does authget mean?
- andrew: authoritive get means that it is assigned via the policy file.
- friedel: authget does not relate to HTTP GET.
- neal: mixing of semantics. the dedicated keyserver does not know that it is the authoritative server for a domain.
- andrew: authget is a suggestion if it is too confusing in relation to authentication. it's an analogy to DNS (authoritative get). keyserver may attach it's own binding sigs to any served certificates.
- bart: why didn't we use DNS?
- andrew: probably in the minutes of last year.
- alex: some platforms like Android may be too restrictive for DNS setup.
- andrew: DNS lookup has many wrinkles and issues.


## Encryption subkey selection (Justus)

justus: there are several different models in current use  
dh: proton selects the most recently created subkey that we understand, if it is not expired nor revoked nor from the future  
justus: openkeychain (and sequoia) encrypts to all valid subkeys that they understand  
justus: gnupg looks at creation time, but also ranks "better" keys first, e.g. ECC  
dh: it is not obviously correct that e.g. ECC is always "better" than e.g. RSA4096  
nikolay: RNP behaves like proton in most cases  
bernd: what are the intentions of people who create multiple encryption subkeys?  
david: there are two encryption flags, someone might distinguish between storage and transport encryption  
justus: most implementations set both encryption flags  
dh: and most implementations (other than historically go-crypto) do not distinguish between them at usage time  
justus: the certificate holder should make the decision  
falko: you could perhaps create a pqc subkey but later have to create a non-pqc for backwards compatibility, and also have multiple devices  
justus: is key owner sovereign?  
dh: in proton, yes because the owner can always create later signatures to re-order  
andrewg: agree, with restriction that only one is ever chosen  
justus: you can lie about the creation time, but you can't change it later without changing the fingerprint  
dh: in openkeychain you cannot set an order preference, for example to tell people to use the "best" subkey  
andrew: in gnupg, you get what gnupg decides  
justus: one motivation is to do opportunistic upgrade, while being more compatible with other clients  
andrew: I don't think any client provides UX for intentionally ordering subkeys by date  
dh: the backdating requirement would rarely arise, maybe we don't need to consider that edge case  
david: should we add something to the binding signatures to impose a hierarchy?  
justus: If we are doing a migration, do we increase security? If you add a PQ subkey but another client only uses the ECC subkey you haven't added any security  
dh: I'm thinking about a migration where your correspondents may not yet be compatible, while J was talking about migration when not all of the owner's devices were compatible yet  
falko: the incompatible device scenario is the same as the multi-device scenario  
andrew: how does the user or the user's client know that it is time to migrate to e.g. PQC when all devices support it?  
justus: if we have per-device subkeys, what do we do?  
dh: that is the same as "Pick a set"  
justus: why not make the ranking explicit?  
andrew: if we have an integer rank mechanism, we could also implement OKC/proton algorithm by setting equal ranks  
falko: this gets even more complex when we combine multi-device and migration  
dh: for migration, you could create two certificates, one with only pqc and one with only ecc, and bind them  


|  Models     |  Pick 1?  |  Pick set?  |   Migrations?  |
|-------------|:---------:|:-----------:|:--------------:|
|  Proton     |    ✓*     |     ✗       |       ✓⸸       |
|  GnuPG      |   (✓)†    |     ✗       |      (✓)†⸸     |
|  OKC/"All"  |    ✓      |     ✓       |       ✗        |
|             |           |             |                |
|  Rank       |    ✓      |     ✓       |       ✓        |
|  Flag       |    ✓      |     ✓       |       1‡       |
|  List       |    ✓      |     ✓       |       ✓        |

\* By lying about the creation time, potentially  
⸸ If you only have a single device/key  
† If your preference matches GnuPG's hardcoded algorithm preference  
‡ One migration at a time is possible; a multi-step migration (e.g. RSA -> ECC -> PQC) is not possible

OKC = OpenKeyChain

Pick 1? = allows the certificate owner to choose 1 key that they want senders to use  
Pick set? = allows the certificate owner to choose a set of keys that they want senders to use  
  i.e. what you want when you have multiple devices  
  or when you have a migration where you don't know where your own devices support it yet  
  (but then why do the migration as you don't gain security - DH)  
  (you gain some experience with using the algorithms)  
Migrations? = can you have a migration where you don't know where your correspondent's devices support it yet


## Autocrypt: What do we need
* Autocrypt Level 1 never reached traction
* Kai (Thunderbird) wasn’t heard for Autocrypt L1
* Proton consumes autocrypt; no freshness; sender might encrypt to a key they received years ago
* proton key needs a signaling flag that says expire this after 30 days; the emitter should indicate how long that should be
* autocrypt spec has a last seen thing of 35 days.
* automatically let people know if key changes. (DSN) however this allows the server operator to do this malicously
* key change notifications
  * here is what delta does: show warning and give options: use new key, continue to use old key, send unencrypt 
* maybe create recommandations on when to turn on (your own) `preference=mutual` (aka when to send it)
* offer QR code as alternative to 36 digits
* export social graph (via autocrypt setup message)
* sending vcards
* move headers into lower level (header in the mime of the content) 
* make Autocrypt-Header depend on signature. import only when signature matches
  * **if** signing works; make autocrypt depend on that

## Autocrypt v2 key

### key structure

four OpenPGP packets:

- v6 primary key
  - direct key sig
- v6 PQ x25519+ML-KEM subkey (encryption capable) 
  - subkey binding sig

note: no userids, since uids are decorative.

### how to transition?

- (a) Autocrypt2 header, Autocrypt2-Gossip header, parallel state management; phase out Autocrypt & Autocrypt-Gossip.

- (b) Define this as a new key format (like we replaced rsa with ed25519), new users get PQ, existing users just need to create new accounts.

- (c) like (b), but include replacement-key subpacket to new cert, and add an Autocrypt-Transition: header which contains old cert modified with a replacement-key subpacket pointing to new cert


2 choices:

- primary key is ed25519?  or ed25519+ML-KEM?

- which transition approach?


larger keys should not appear in message external headers, we'd prefer to put them in a MIME header in a subpart -- if the header is in the body, it'll be covered by the DKIM signatures.

If we go with (a), we don't need addr= param, and we can learn it from the From address
This should be ignored for multi-from messages.


## Wrap-up: Action Items

* vcards - improve interop with Delta Chat (Proton)
* PQC -
  1. Allow V4 subkeys (Aron / Falko)
  2. Prepare draft for last call (Aron / Falko)
  3. Prepare private HQC draft (Aron / Falko)
* FreePG (Andrew, David)
  1. Find governance structure
  2. community outreach to users of GnuPG/gpgme to see whether they can switch or chameleon works
  3. outreach to other binary distributions of GnuPG (e.g. brew, macports, gpg-tools)
* Key migration 
  1. More user stories & guidance (Andrew)
  2. prepare last call after PQC (Andrew)
* Manual key verification
  1. Proton: discuss approach using QR codes instead of FPR
* Cleartext (non-disturbing) signatures
  1. set up new draft repo in gitlab (Andrew) https://gitlab.com/andrewgdotcom/cleartext-signatures
  2. test vectors, review behavior in various MUAs (dkg)
  3. flesh out, submit to datatracker (dkg, Andrew, Kai) 
* Expect Signed Mail
  1. Create first prototype to try it out (Daniel H)
* Deterministic keys
  1. Follow up on "Simple key" approach (Kai, Aron)
* Forward Secrecy
  1. Discuss more on the list (Daniel H)
* Automatic Key Authentication 
  1. Prepare proposal (Kai)
* Prefer Encrypted Mail
  1. mailto: URI parameters (Daniel G)
  2. introduce KOO signalling roughly equivalent to `prefer-encrypt=mutual` defaulting to off (Daniel H)
  3. introduce WKD signalling roughly equivalent to `prefer-encrypt=mutual` defaulting to on (Daniel G / Daniel H)
  4. describe vCard annotation roughly equivalent to `prefer-encrypt=mutual` (Daniel G / Daniel H)
* HKP 
  1. Update spec (Andrew)
* Encryption subkey selection 
  1. Write problem statement & propose solution (Justus)
* Autocrypt: What do we need 
  1. Amend Autocrypt spec for key freshness (Nami)
  2. ... for key change warning recommendations (Nami)
  3. ... for QR code for AC Setup message (Daniel G)
  4. ... for moving AC header to mail body header (wait for the non-disturbing cleartext signatures testing result/feedback)
  5. ... for extending Setup message with social graph / AC state database (Nami)
  6. ... for `prefer-encrypt="..."` recommendations in your client (Daniel G)
  7. ... for vCards (Hocuri)
* Autocrypt v2 key
  1. decide between `Ed25519` or `ML-DSA + Ed25519` primary key (dkg)
  2. decide on migration approach (dkg)
  3. revise spec after PQC & replacement-key landed (dkg)
* Create public IMAP folder with PGP/MIME signed & encrypted messages (dkg)
* Copy Minutes to `openpgp.org` (Patrick)
* Organize Interim, online in October? (Daniel H, dkg)
* Organize Next Summit (Patrick)
