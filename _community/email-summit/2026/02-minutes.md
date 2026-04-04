---
title: "Minutes of the 10th OpenPGP Email Summit (2026)"
permalink: /community/email-summit/2026/minutes/
---

{% include toc %}

## Projects Present

- Thunderbird
- Enigmail
- Hockeypuck
- keys.openpgp.org
- Arch
- Signstar
- DeltaChat
- Proton
- GopenPGP
- OpenPGP.js
- Sequoia
- Red Hat
- Ripasso
- Ura Design
- Parula
- RNP

## Action Items from 2025

### vcards

Daniel: Some support for exporting / importing OpenPGP keys in vcards.  DeltaChat and Proton both support it, but slightly differently.  Wanted to make it interoperable.  We did collaborate on a document on how to put an OpenPGP key in a vcard.  There should be an MR in the autocrypt project.  DeltaChat started supporting Proton's format, but Proton has not yet added support for DeltaChat's format.

https://github.com/autocrypt/autocrypt/pull/456

### PQC - Allow for v4 subkeys

Aron: v4 subkeys are only allowed for encryption and only for the MUST version of the algorithm (x25519~mlkem768).

Kai: Made some experiments.  MTG team made some patches for RNP.  Kai tried them.  The patches are not yet merged, but they work in Kai's local build.  Can produce a subkey on an existing certificate and that works.  The general idea is to start testing in the development build.  The problem is that once we have a new format key, classic RNP cannot load the keyring at all (not just the certificate).  Will probably add two versions of the RNP library in Thunderbird to deal with this.

Aron: The draft went through last call.

Daniel: We just have to wait for ratification.

Aron: Expect it to take 15-16 weeks.  We might have to wait a few more months.  But it is finalized.  So if you want to use it, please do.

Neal: Should we do releases?

Aron: Proton has code ready.  We're not holding it up due to the RFC number assignment.  So I would say yes.  Our experience limiting it to an internal release, we found some issues in Thunderbird and GnuPG.

Andrew: Are the GnuPG issues reported?  We might be able to fix it in FreePG.

Aron: I'll get back to you.

### Private HQC Draft

Aron: HQC is another algorithm for PQC and is the new cool one https://pqc-hqc.org/.  It's an alternative to lattice based algoritms, but it's not yet ready.

Falko: dkg warned us to not spoil the message of the current draft by introducing another scheme, so we didn't do anything. Also our funding ended.  BSI also does not (yet) recommend it.  Adoption of HQC might be driven by someone else.  Initial public draft from NIST is expected in the summer, but NIST is working very slowly perhaps due to the current financial situation so we don't really know when that will be done.

### FreePG

Andrew: We found a governance structure, which is published on the website https://freepg.org/governance/, which is also new: https://freepg.org.  Authors are people who were in the DeltaChat room at the time the document was written.  Currently work based on rough consensus.  Assume good faith.  We don't expect that to be a problem.  The main thing that we wanted was to ensure that we have a broad coalition of packagers.  We have arch, fedora, nixos, etc.  Currently being shipped by Gentoo as well, but as a separate package from GnuPG.

Kai: Anyone distributing this on Mac or Windows?

Andrew: Yes, we want that.  Clemens from MacPorts wants to package it.  Mostly my fault that nothing has happened yet.  For Windows will need to go via Chocolaty.

David: Same counts for Homebrew.  Tried to reach out to the current maintainers, but didn't get a response.  Don't have any context to make things happen.

Kai: Perhaps reach out on mastadon.

Patrick: What about gpgtools?

Andrew: I reached out, but I didn't hear anything.  Next priority is mac.

Falko: What about PQC support?

Andrew: We did not yet integrate your patches.  To catch everyone up: there is a patch for GnuPG from several years ago.  Upstream did not merge it, but went with a different specification.  (Explanation of differences between LibrePGP and IETF PQC.) We need someone who is able to clean up the patches.  I think Heiko was considering looking into it.  Definitely a low-priority thing for him.  We would like to do it, but we don't have a roadmap for how to do it.  Suggestions welcome.

### Key Migration

Andrew: Replacement key draft has been textually stable for 6-9 months.  Heiko is implementing it in rpgp or rpgpie.  He came back to change the requirements for the algorithms that are used.  (Summary of draft.)  Really wanted to stick to the idea that there is only a single identifier for objects, which is why we introduced the imprint: this allows us to have the unique identifier, which may be weak, because it uses SHA-1, but also a strong identifier.  The problem arose, because certificates evolve over time and the subpackets including the replacement key subpacket need to be duplicated.  The issue is required to be the same hash algorithm as the self-signature's algorithm.  This makes it impossible to change the hash algorithm without regenerating the replacement key subpacket, but you might not be able to, because the other certificate is not available.  The solution is that we hard code SHA3-256 as the algorithm for imprints.  Why not SHA2?  Exactly because it is a different algorithm, which provides more security.

We have a proposal, which we mentioned on the WG mailing list.  dkg resisted a bit.  No other comments.

Patrick: Last call?

Andrew: No.  We need two implementations and we only have half of one.

### Manual Key Verification using QR codes

Daniel: We did not discuss it.

Ben: Would like a usable form of key verification that works across TB / Parula / Proton.

### Unobtrusive Signatures

Kai: New name.  Thanks to dkg and Andrew for help.  The document has been adopted by the WG.
https://gitlab.com/andrewgdotcom/unobtrusive-signatures
The idea is instead of using multi-part signed with emails, which has a drawback that many MUAs don't understand the encoding, which results in an unknown attachment, which causes confusion and sometimes mails being rejected.  Many users turned off email signing.  Idea: find a different approach so that signatures can be turned on all of the time.  Now the signature is stored in a different place.  Wrap the message in multipart mixed.  Where the content type is usually placed, we place the signature as a header.

Patrick: It's like protected headers with another header.

Vincent: Has this been tested with other mail clients?  I would expect it to not work in K-9

Kai: Yes we test it with some clients.

Vincent: I think it wouldn't have worked with K-9.

Kai: We tested that the content is rendered correctly.  dkg implemented support in emacs (mml).  We also have an implementation in TB daily, which can consume and produce the signatures.  If a signature cannot be validated, the suggestion in the draft is to ignore the signature.  We made this change globally in Thunderbird.

Ben: You still show something.

Kai: We show that it is an OpenPGP message.  Only if you go to the debugging interface do you see it.  I did the pragmatic approach: hide the red x.  Still need to talk to designers.

Andrew: We've had this discussion over the last few years.  A broken signature is not a signature.  But you need to be able to debug it.  If the user is expecting to see a signature, they need to be able to understand what happened.  But we don't want to push it in people's faces that a broken signature was detected.  We want to match the same experience as http/https.  We want to better align expectations of the user.

Daniel: That's kind of step two if you go for the web model.

Ben: In Parula, I tried to implement this.  I like the idea.  I was struggling with the format as the mime libraries don't give me access to the entire mime tree.  That's an implementation limitation, but may be others will have the same issue.  For sending, it is possible to hack it.  For reading, it is harder.  So, this mixed wrapper may be a problem for others.  A plain header would be much easier.

Vincent: Same thought I had.  If it is a mime structure that is not established, it might be hard to use.  That makes it a bigger ask and many clients may not implement it.

Kai: But it is standardized.

Andrew: Apple mail is increasingly restricting access to data.  Doing anything with mime structures is increasingly hard.

Vincent: Is there a list of clients that you tested?

Kai: No.  We tested a few clients and it rendered fine.

Vincent: There are a lot of renders out there.  If you break apple mail, that's a big deal.

Kai: We're now at the stage where we can do testing.  We've also published a call for feedback.  One thing that has been reported, is that it increases the spam score for some people.

Vincent: Spam issue should get better if Thunderbird starts sending this.

Ben: There are services that will show how emails will be rendered in different clients.

Vincent: We pay for that already and would recommend it.

Ben: On the protocol level almost all protocols let me get the raw MIME.  Then I can use my own implementation.

Kai: multipart/signed parts already should not be modified in transit, but multipart/mixed does not currently have that guarantee. New draft suggests that MTAs should also refrain from modifying the new signed structure. We also reference RFC9788's header protection.

### Deterministic keys

Kai: could we ask users for a seed phrase and derive all key material from it?

Aron: proton currently just backs up keys in an encrypted vault; this is more flexible as you can roll the password without regenerating keys.

Kai: I have a simpler idea. The master phrase will be used to protect a PQC keypair that is only used for backups, and backups can be encrypted to this keypair. These can then be stored in the user's IMAP server and used for both disaster recovery and multi-device sync.

Aron: let's take this to a discussion session.

Vincent: I worked on this for a while with K9 mail, but transparently storing arbitrary data in IMAP is hard.

### Forward secrecy

Daniel: Holger presented Autocrypt 2.0 at FOSDEM, which is not exactly PFS, but is "Pretty Good".

### Automatic Key Authentication

Kai: could we find a way to sufficiently authenticate a discovered key to the point where it could be used immediately for encryption? I had to give up on this idea, but want to change the UI model of how keys are manually verified in TB.

Ben: whatsapp claims to have some way of doing this but I don't know the details.

Kai: let's have a discussion session.

Elio: Worth thinking about UX research to validate these expert opinions with normal humans

### Prefer Encrypted Mail

Daniel: we could put a key in a mailto link:

https://github.com/autocrypt/autocrypt/pull/455

We want a way for a keyholder to declare in advance that they would like to receive encrypted mail if possible, without having to prompt the sender (the existence of a key is not sufficient). We have an implementation of a notation that would carry this meaning, but it is not shipped yet.

### HKPv2

Andrew: HKPv2 is relatively stable. Last year's KOO board focused on getting v6 keys into keyservers, for which HKPv2 is necessary, because the client needs to support (or at least not break on) v6 keys. GnuPG breaks when getting v6 keys.  
HKPv2 says you must ignore unknown key versions.  
HKP(v1) has never been properly standardized and needed an overhaul.  
HKPv2 improves the API.  
Will be implementing it in Hockeypuck in the next month. Should be relatively simple.  
Heiko will be implementing it in Hagrid, when he has time (at some point).

Neal: is it still an issue? GnuPG has no default keyserver anymore.

Andrew: that's only for upstream; distros still have a default keyserver, often different ones.

Neal: most upstreams are shipping FreePG

Andrew: some of them, but not all

Patrick: does FreePG replace GnuPG or it's an additional package?

Andrew: depends on the distro; Gentoo ships it separately, others ship FreePG as GnuPG

Ben: how long does it take for downstream to update?

Ben: does GnuPG send a user agent string?

Andrew: no

David: also no useful error message

Ben: is this fixed in FreePG?

Andrew: no

Andrew: we can't fix things for GnuPG on Windows  
Best way to fix this is on the server side

Neal: if they use GPG4Win they don't have a default keyserver

Andrew: but they can set one

Neal: gpg4win is used by corporations who are using LDAP rather than keyservers

Andrew: still need keyservers for external communications

Andrew: need to update HKP anyway  
Waiting for adoption by the WG

Daniel: pinged the chairs, Stephen said he'll get back to chair-related duties soon(tm)


### Encryption subkey selection


Daniel: autocrypt v2 suggests that you should always use the encryption subkey closest to expiration, but this may not be ideal.

### Autocrypt

Wait for Holger.


## Parula demonstration (plenary)

Demoing the new PGP support in Parula, including AutoCrypt.

Implementation:
* Uses OpenPGP.js
* Encrypted emails have header protection always on.
* Encrypted emails are always signed.
* Unobtrusive signatures and normal signatures are in progress.

Source:
* https://parula.app
* https://github.com/mustang-im/mustang
* PGP code: https://github.com/mustang-im/mustang/tree/master/app/logic/Mail/Encryption/PGP

UI:
* Message reader:
    * Icon after From name
    * Click shows explanation, sender public key info, and allows public key verification
* Message composer:
    * Dropdown icon after From identity.
    * When encrypting and lacking public keys for some recipients, shows problem and resolution.
* Private keys:
    * In Settings | Mail | account | Identity
    * Allows to generate new key, or import from .asc file
* Public keys:
    * In Contacts
    * Allows to query keyserver or import from .asc file

Feedback welcome! We're to seek your feedback on what is good, bad, bugs, improvments.

Bugs found:
* https://github.com/mustang-im/mustang/issues/1131
* Incoming: When key is missing locally (?), signature doesn't show at all.


## Fingerprint Verification or Public Key Verification

Host: Ben

https://signal.org/blog/safety-number-updates/ , heading "Simplified Comparions"

Problem statement: We have these PGP fingerprints, which we use to manually verify other people's keys.  Let's assume that other people still do that.  Let's say we want to manually verify, because I need 100% trust.  Comparing fingerprint prints is difficult.  Moxie wrote an article where he says that PGP got it all wrong. (See link above)
1) The name is unfortunate: I don't want to give my fingerprint, I feel like at the police.
2) Display: The spacing makes it hard.
3) The last problem is that people don't know which keys to compare with which.  Most people don't understand public key cryptography.  Moxie proposed using just a single block that combines the key pairs.  Then two people comparing fingerprints read the same thing.
   This is what we implemented in Parula.  We can also use a word list, or scan a QR code.  This session is about how we do this and where we want to be.  It is important that we agree, as different users use different programs and we want users to have a similar experience.  Session is about: which approach should we use?  Can we get agreement?

Kai: We may not always have a pair.  For instance, a key online.  We should record independently that a key is verified, not the pair.

Ben: Let's simplify the discussion.  I want to verify a connection between two specific people.  I don't care about other scenarios.  Let's keep the edge cases aside.  We want it to work for the average user, not the power user.

(Demonstration how to take out 5 notebooks at once.)

Bart: Average user will never compare fingerprints.  It is an expert feature.  Unless you mean the average investigative journalist.

Vincent: I will say: I will not do it.  I never check anything even signal.  I care for the first 3 months and then it is over.  So, it is a feature that should be there, but that's it.  Like in Signal: we should have a button that you can press and that's it.

Ben: We should have one way to do this.  Let's take the example: investigative journalist who does not know much about computers.

Patrick: If most people are like Vincent and only a few need to care, is it sufficient to a mechanism as opposed to something more convenient.  Then perhaps fingerprint comparison is enough.

Andrew: It has to disappear for users.

Bart: This is why we spoke about OpenPGP CA before.

Kai: There are different levels of authentication strength.  We can't automate manual verification.  Automatic verifications, yes.  But, we still want manual verification.  Is manual verification a thing that we need to simplify?  Or do we say, there are only a few people who need it, and we don't need to simplify it for them.

Ben: Falko said anything that we do automatically can be attacked.  There are some people who want more security and we should make it easier for them.  Let's say we're doing it for them.  How do we do it?

Vincent: Let's come up with a base line.  Anything beyond that should justify their added complexity.

Ben: Simple suggestion: take fingerprint of my key and put the fingerprint of the other person below that and that we add some spaces.  Then we agree on the order so that both people see the same thing.

Bart: Use bitcoin library/words.  I think it is much more human readable.

Andrew: We've got too much information already.  The expectation is that you're going to compare.  But why repeat your own key?  Instead xor the bits then it is more compact.  Also, I agree with Bart: hex is not readable.

Vincent: Going with xor means that all implementations have to agree to show xor.  If one client has the fingerprint, can't compare anything.

Ben: If you do that you should also convert to a bitcoin mnenomic.

Vincent: That only works if people speak the same language.

Kai: I agree with Vincent.  What if someone has multiple keys.  If you xor, you can't easily see that you're using the wrong key.

Aron: What if you have a v6 certificate and one v4 certificate?

Stefan: I like Ben's approach that you click in a thread and within this communication there are key pairs.  This avoids Kai's problem with multiple keys.

Daniel: Doesn't that mean you have to repeat this process for each email thread?

Ben: Normally I communicate with you with the same email address and the same key.

Daniel: You need some UI to notify of the key change.

Bart: Are the people using some out of band mechanism to compare?  If two people speak different languages, then this is not actually a problem: if they can't communicate, they can't compare.

Ben: The point is if both speak Japanese, but the words are in english.

Daniel: There are different word lists.  But need to figure out the common language.

Aron: Bip39 code for 256 bits is 24 words, is quite a lot

Aron: Should have a QR Code, is simpler than reading out words

Kai: Do you want to try a mechanism that only works in person or that is optimized for in video calls.

Ben: If you look at signal or whats app, it allows automatic verification, compare safety numbers, and qr codes - all 3 options.

Holger: I've looked at this for 10 years or so and there is something that we call secure join.  Yes it has a qr code, but there is no fingerprint comparison.  The qr code contains everything.  We also have verified groups that only verified people can join.  Then people who join, learn about other people in the group.  This was usable, and people did not have to compare fingerprints.  But it still had problems.  From my perspective, we have two identity systems: the email address and the fingerprint.  So we are managing this binding.  But for users it doesn't work however you do it.  There isn't a coherent user story behind it.  Once it breaks, users don't care.  Even advanced users.  Fingerprints are clearly not the usable solution.

What happens in delta chat is different.  We use the cryptographic keys as identity.  Full stop.  This was a big change.  But out of the user problems, we learned that communication is between two keys, then it is always verified.  If someone has a different key, then it is a different conversation.

Ben: It is about interoperability. In your case, both sides are DeltaChat.

Patrick: This doesn't solve the problem, because I don't know that this key is you.  I communicate with a key, but I want to communicate specifically with you, I don't know it is you if I don't verify it.

Daniel: If you lose your device, and generate a new key, you have to verify again.  Either the app helps, which means that you need a binding with a stable identity or the user has to figure it out themselves.

Jonathan: Delta Chat solves this by using a qr code that contains everything.  Could combine the identity and the key in the qr code.

Ben: 3 proposals: 1. simple algorithm using just the fingerprints (optionally with xor), 2. use words instead of letters (but need to agree with the language), 3. use a qr code (easy with phones, not so easy with desktops and impossible over the phone)

Elio: Academic paper that discusses how to visually compare two things like fingerprints.  Should read it first.  In particular regarding accessibility concerns like color blindness. Link: https://arxiv.org/pdf/2106.01131

Joakim: I like the first suggestion, because it is compatible with what already exists.  If we have a new scheme, then we can still have the manual fingerprint comparison.

Jonathan: I would like to agree on a standardized way of showing the fingerprint.

Kai: If we use xor, then we should show it very differently.  I would like to verify someone else's code that I found on a business card.

Bart: I agree.  It shouldn't be confused with a fingerprint.  It has to look different from the hex.

Ben: I want to implement something that we agree on.

Kai: I doubt we'll find agreement here, today.

Andrew: What points do we need to hit?  Do we want to make it readable?  Language barriers.

Ben: Internationally, in person, over telephone.

Kai: We should use completely different characters (G-Z instead of 0-9A-F)

Bart: I like the idea of drawing, but we need a library that does it consistently.  That's why I come back to the words.  And the library is everywhere.

Nikolai: What about having some service that uses some AI network that generates an image based on the fingerprint?

Ben: I would not want to depend on a central service.

Kai: What if the image looks mostly the same?  Will users be able to spot the differences?

Patrick: I suggest others do another session or write down a proposal.

Daniel: We should also review the literature and try to go with good results.

Andrew: I don't want to tie the xor to any presentation layer.  I'm proposing xor as an information reduction step.

Patrick: Who want to work on this?

Volunteers: Ben, Kai, Daniel, Elio



## JSON

Facilitator: Neal

Neal: Want to be able to serialise openpgp objects in a lossless form for import into other applications. For certificates we just need a schema; for messages we also need to consider compressed artifacts, and partial body length encodings. Starting point is I want to do everything.

Aron: why? debugging? parseability?

Neal: we have a library that exports a machine-readable but also human debuggable output. It would be good to have JSON as a format that is both human and machine readable. Not replacing wire format.

Andrew: In hockeypuck we have a json dump of the certificate objects (internal representation of the internal data format). Implemented in a custom and "quite ugly" way.

Andrew: I am interested in a JSON format for the key representation, not so much a message format.

Nickolay: We would like something similar in RNP, to represent key data in a portable format.

Neal: I would not put in the key parameters explicitly, as they can be derived from the key material.

Nickolay: Right, not that, but for instance the hash-function.

Andrew: Is this meant for batch processing?

Nickolay: it's meant to define profiles for instance containing the subpacket specification.

Aron: OpenPGP.js has already a JSON representation of the key.

Neal: I want that we come up with a schema that is interoperable.

Andrew: We could want to just parse the packets and subpackets, but not the cryptographic layer, so we need to have flexibility.

Aron: OpenPGP.js keeps the wireformats of cryptgraphic artifacts.

Neal: recreating compressed artifacts from decompressed artifacts with the same exact representation will not work reliably. Thus roundtrips will not work.

Falko: We could just include the full compressed version

Neal: it's also possible to have all the packets aside from a streamed, ephemeral literal data - so we can't even keep the uncompressed version around, let alone the compressed one. We would also be doubling the storage just in case we might need the data at some point in the future.

Falko: I'm using a python library that can check a json schema (json-schema) (https://python-jsonschema.readthedocs.io/en/stable/, https://github.com/python-jsonschema/check-jsonschema)

Andrew: we would need to have some knobs: a) layer depth (e.g. only to the packet level) b) keep or omit the raw (sub)packet bytes c) omit literal data. We should be careful to not reinvent the wheel if we are going to use json-ld for future structured-email work.

Bart: Why do we need to standardize this?

Andrew: It would be nice to at least have a standard taxonomy

Bart: Should track the packet structure, how to make codepoints human readable. If I were Neal I'd just do it

Neal will create a JSON dump of the packet structure in sequoia and document it. Will form an informal chat group with group attendees (neal, andrew, aron, falko, nickolay...?) to gather some feedback on the JSON structure and align on some generic taxonomy.


## Second Device and Key Backup

Host: Kai

Patrick: problems are not exactly the same

Kai: there are different ways to backup keys; having a second device might be an easy way

Daniel: you might be able to solve both with one solution

Ben: don't want to require people to store a paper to set up a second device

Daniel: but can both show and print the qr code

Patrick: for second device you could also do DH

Ben: to set up second device, could have a qr code with an IP address, set up a websocket

Patrick: requires a camera

Patrick: if you have an IMAP server, could store stuff there

Ben: but I don't trust the IMAP server yet

Patrick: autocrypt setup message covers a lot of this

Daniel: QR code is better UX, but might need to have a fallback where you enter some digits or so

Kai: want to do automatic backups

Kai: want to be able to recover from losing all devices

Patrick: need to store something somewhere

(Discussing Kai's proposal of automatic backups)

Kai: is autocrypt setup message sufficient? Storing the encrypted key material publicly might be risky

Patrick: autocrypt uses 119 bits of entropy; 36 digits passcode

Daniel: should be fine, even for post-quantum

Joakim: am interested in use cases where you don't have email/IMAP

Daniel: it's the OpenPGP email summit ;)

Kai: don't like the UX of entering digits; to backup automatically it would need to be stored permanently

Stefan: how often do you really need to rotate the backup?

Stefan: Signal asks you to regularly enter the backup secret, maybe it's not bad to ask regularly

Kai: if the phrase is long it's a hassle to enter it regularly

Stefan: don't need to do it often since even with short-lived keys, they're generated deterministically

Daniel: asking the user to prove that they have the passphrase can be done by asking the first few words

Elio: could we use passkeys?

Daniel: can work, but UX challenges because it's not clear that passkeys shouldn't be deleted

Elio: would need to introduce a flag or a new name

Stefan: do you have a backup of passkeys? It's stored in one place and non-exportable

Daniel+Elio: Proton Pass and iOS do sync them

Daniel: should have it as an additional mechanism rather than only rely on passkeys

Kai: want to start with one thing

Patrick: people won't write down a phrase

Daniel: Signal can prompt to store it in the password manager

Patrick: we're moving the problem to the password manager

Daniel: but they/we do have a lot of backup mechanisms already implemented

Elio: needs to be a wizard/guided process

Joakim: is there one backup per account?

Kai: one key pair to encrypt all keys for all accounts  
Encrypted and stored separately for every email address

Stefan: want to sync key material and also public keys

Kai: could also have signing key to sign trust decisions and other data to be synced

Stefan: and prove the authenticity of the backup


## Unobtrusive signatures

Facilitator: Patrick

Kai: we decided on a multipart/mixed wrapper which appears to be handled gracefully by all legacy clients we have tested. Implemented now in TB Daily, some small issues: can increase spam scores, also some MTAs have been seen to modify the multipart/mixed contents.

Patrick: another issue is that some mime apis reorder the signed headers, or present them as a hash, not in raw format

Bart: what if you embedded another multipart/mixed with the signed headers inside it? But this adds a lot of complexity for little benefit, you can still use the raw outer m/m and strip the sig: headers separately, without reimplementing a mime parser.

Vincent: still concerned about legacy compatibility

Bart: this is a clear improvement over attachments, we should do it

Daniel: can we turn this on by default yet?

Kai: you can roundtrip an unobtrusive signature to multipart/signed

Daniel: we already have a preference for pgp/mime vs inline, can reuse/extend. Only remaining reason for not signing by default is deniability, but this is edge case.

Andrew: plausible deniability is bullshit

Kai: june/july should be able to switch TB to unobtrusive by default, will go into monthly release channel. We'll find out then.

Bart: Proton should be able to interpret incoming messages by then. Can implement generation on our own timescale.

Vincent: in openkeychain it's an application concern

Kai: no timeline yet for K9

Vincent: might be better to use pgpainless instead of openkeychain

Bart: once tb and proton support this, should be easy to convince other clients. This is one of the highest ROI things we can do.

Andrew: we could have coordinated blogs on e.g. proton, o.o etc., generate media blitz

Bart: should only do this by default for people who have already enabled signing (at least initially). Can wait a year to work out the bugs before doing it for everyone.

Bart: can we put autocrypt header inside?

Kai: yes, and we could also omit the autocrypt header from the outer headers because it is not rendered to the user.

Daniel: with pqc, we need to consider whether we want to include all the possible keys, because ml-dsa is big.

Bart: alternative methods exist!

Daniel: you can also use key transparency merkle trees to minimise the total number of signatures required

Stefan: can we have a canonical header order to allow the structure to be reconstructed from a parsed header list?

Andrew: but then we need a canonicalisation step because FWS would be significant

Daniel: why not put the sig: headers in the outer part?

Andrew: because of MTA shenanigans, e.g. mangling, size limits

Stefan: would it be easier to sign the entire multipart/mixed and then insert the sig: header? It's strange that the signature is inside the thing that it signs

Bart: it's weird but easy to work around, alternatives are worse



## UX Peer Review Session

Host: Elio

Elio: I've been hearing a lot of talks about how we should do things.  A lot of proposed concepts are not reviewed, or not based on peer-reviewed literature.  I want to propose that we do a UX process with technical proposals.  So, things that are proposed are tested on users.  Goal: recruit a user panel where we can come with proposed concepts and test if the idea holds up in reality.  This is more a governance process.

Elio: Basic usability testing should be part of that as well.

Aron: At Proton, we do a lot of UX work and we have UX people.  We start at the UX and we try to derive something out of it.  We of course have constraints like technical constraints and time.  In general, there are teams that have UX people who have more or less technical / cryptography experience.  This impacts the results a lot.  Especially people who have been at Proton longer, they pick up what is possible.  I think there is a general lack of UX experts that understand our constraints (not only Proton, but also OpenPGP more generally).  I feel like engineers boil the same soup over and over.

Elio: Is the QA process at Proton open/public?

Aron: UX experts conduct the QA, they pass the results to UX leads, and then engineers. There is someone responsible (technical lead) for every process. It is impossible to share everything in detail. After all processes are conducted, the demo is sent to regional people, asking if there are features needed/more to be added. It's hard making the change in the design for designers and engineers. Designers have a different idea on mind, and oftentimes it is missed as a design because in production there are parts of algorithms that cannot be implemeted in the same level as design.

Product designers are using AI to create mockups and that helps with communication a lot, as there are many things that are hard to communicate especially to people who don't speak the same language.  The engineer plays with the mockup.  The engineer can see if some steps are missing (e.g., some crypto step).

ProtonMail starts with product specs first. The customer will click on those buttons, to understand what they do.

Elio: At Ubuntu, we had a bunch of engineers and then had the designers look at it.  So it was the other way around.  With all technical people it works differently. Proton started making it approachable for everyone.

Aron: Designers need to learn about crypto to understand what is necessary.  There are steps, like adding a key to a keyring, which are hard to show to a user.  The designer wants to hide it, but they can't due to the crypto requirements. It is important explaining why these steps are needed. There are adv. & disadv to every process.


Jonathan: What is your approach to user testing?  Like giving something to 10 unsuspecting users and then asking what they think?

Aron: Internal testing: Jessie from accounting. Volunterily basis: Can someone take a look at this. A/B testing: but it means having A & B (sometime it's hard); UX Expert testing. (Mostly, trying it internally)

Elio: How can we get more designers from Proton attend these summits (that might profit them and us as a community)

Aron: In 2019, Bart asked.  Afterwards, I came because I was doing stuff related to OpenPGP.  Same story with Daniel.  To attract designers to such a thing, we need to make it more UX friendly.  This is the first time we've had so many designers here.  I'm very happy to see so many UX people here.  Perhaps we need to rebrand the event.  We come from a technical background so its hard to get UX people in here.

Joakim: Proving that we take UX seriously would be a way to attract more UX people.

Elio: There are people who are already in it.  They should come.  Like from Proton, Delta Chat, even Thunderbird, but it is important to have more people that do UX & Design.

Aron: It would have been easier when we organized the session at Proton HQ.  But getting them to come here is harder.  But let's talk about it.
Elio: How does Delta Chat approach testing?

Jonathan: We have some people who care about UX & talk to users on how to make things easier for users, create a shared value for the project, & design for regular users and not ourselves. This means everything that is too complext to explain to your families, we don't do it. What's interesting is having the key verification used in an easy way. We don't have an official process for user testing. We get feedback from current users. But cannot speak in a broader group like this summit, rather than with Delta Chat internally.


Elio: The baseline can be strenghten across all discussions, like designing for whistleblower platforms/state surveillance platforms. Peer-reviews need to be public. We are not aware of these discussions if they are happening in platforms. These discussions should be open so people can participate.

Neal: Changing the terminology in the platforms, means changing how people interact with the platform. Adding a process where we have to do anything, like happening here in this summit where 2/3 come every year, it is limited. If Sequoia or Delta need more UX, let's do that, maybe creating a hackpot to make these changes.

Elio: Creating a library, might help in reaching out to more projects.


Jonathan: Do you think that the OpenPGP Summit is not talking about UX enough?  Like we talking about the wrong things?  We're talking about key verification, but we don't have usable encryption.  I think it would be cool if Proton could read DeltaChat's vcards.

Aron: I think it works now.

Jonathan: I thought it didn't yet.

Aron: We have rate limiting, which is a problem for delta chat, which sends a lot of emails.

Jonathan: It would be cool if a delta chat user could encrypt to a proton user.  I want encryption to be so easy that my family can encrypt without me explaining it to them.  I also don't think whistleblowers want to spend a lot of time learning how this works.  What I'm saying is that we have the wrong discussions.  We should more discuss how to make this easier and not discuss how to add more things.  But I'm not sure how to do anything about this.

Joakim: I'm thinking about a specific challenge.  We're not building a product, but a spec.  You want a spec that allows a certain product to be built.  I think that makes it a bit more challenging.  If we want to propose something specific, how do we choose what to work on?

Elio: I see Neal's point.  There's not a lot of convergence.  So action has to be on a project level.  There is no consortium.

Joakim: What I like about Neal's suggestion is to just do it and then show that it is useful.  There have been lots of topics presented here.  We could just implement it and show what the experience be like.  Even if people dislike the prototype, it would inspire a discussion.

Elio: That's how I feel about Proton, It would be interesting to know more about the design and UX process. We don't tend to share publicly the processes.

Aron: That's part of the secrecy of the process. Designers want to have that since they believe they have an edge towards others.

Elio: There could be some spearheaded knowledgee shared "thing" we could create, where different OpenPGP players could share their processes. One potential thing could be pattern-gallery on how people are dealing with that. I understand there might not be a lot of touchpoints between the players. But it could start the ball rolling as a process.

I think the concesus is that it would be good to have some more information sharing in our communities, and hopefully by next year, we should have more involvment in these discussions. Especially with European Union focusing more on having one coherent system for everyone, and slowly separating from the US processes.

Neal: Fingerprint verification is different is different projects.

Elio: It depends on interoperability. Can you communicate between Thunderbird & DeltaChat?

Jonathan: You can communicate between Thunderbird and Delta Chat.



## PQC Migration

Host: Aron

Aron: there is v4->v6 migration and traditional->PQC migration. Let's focus on the latter. Proton will bundle both transitions together because PQC is a user-measurable upgrade and selling point. Proton will not by default expose v6/PQC keys to outside users even for internal users who opted in to v6/PQC.

Andrew: We constructed PQC in PGP such that we can do encryption within the v4 format.

Aron: When rotating the primary key, it can also be migrated to v6.

Kai: Will freePG support v6.

Andrew: unlikely, we will be lucky if we get v4 PQC support into freePG. freePG is meant as a temporary solution only. PQC is coming more into the consciousness of technical people. The selling point of GnuPG is that it is PQ-ready and can create ML-KEM-composite.

Aron: GnuPG allows to attach a v5 PQC ML-KEM encryption subkey to a v4 key.With v4 ML-KEM subkeys we provide an alternative that is even compatible with v4. For full PQC compliance signatures are also needed.

Kai: As soon as RNP provides stable v4 PQC encryption, it can be integrated in Thunderbird. I want to see PQC support in Thunderbird ASAP, but I don't think it will come fast. First we need replacement keys mechanism.

Andrew: Repl. keys is needed for v6, not v4 PQC.

Kai: v4 PQC support in Thunderbird could be there maybe end of the year.

Falko: definitely do not recommend coupling v6 and pqc transition

Aron: Proton can roll out v6 PQC keys for internal users easily. Sending modern artifacts to outside users would happen when a corresponding v6 or PQC key is available for that user.

Aron: We found several issues with v6 / PQC testing: Thunderbird choked on v6 signatures. Thus we turned off v6 signatures if we have no indication that the user supports it. When encrypting to v6 we also sign with v6. What's blocking us to export v6 keys is waiting for the replacement key mechanism.

Andrew: Anyone wanting to support v6 should think about the replacement key mechanism.

Vincent: PQC support in RNP?

Kai: MTG contributions are going to be merged by RNP.

Nickolay: Some issues need to be fixed before we can merge.

Kai: What must happen to integrate as non-experimental?

Nickolay: Just depends on technical tasks. Hopefully in the next months.

Kai: That means we should have PQC support in the backend of Thunderbird soon and can then start on the implementation. RNP has 2 different IF-DEFS: one for v6, one for PQC. v4 PQC can be enabled independently from enabling v6. I have experimental code that successfully sent and received v4 PQC-encrypted messages.

Andrew: I start to get the feeling freepg pqc support will be a blocker.

Kai: thunderbird will always have a v4 traditional encryption subkey in addition to pqc

Falko: Most important that implementations do not choke on v4 PQC keys.

Andrew: GnuPG could import a v4 PQC subkey and gracefully ignore it, but only of type 35 (the smallest one).


Aron: Besides Thunderbird older versions also older gocrypto versions failed on unknown subkey algorithms.

Holga: At deltachat we're planning to deploy v6 + PQC + Forward secrecy all at once this year

Andrew: We will need to have signature cleanup for some larger PQC keys

Action item for Andrew: get HKP to work with v6 keys next month.

## Expect Signed

Daniel: There's a draft by dkg from 2024, was brought to SecDispatch at the IETF, then nothing happened

Patrick: need to update the spec, some open issues, a lot of clarifications needed around expiry of signatures and the exiry date in the expected-signed header itself

Daniel: unobtrusive signatures are a prerequisite

If we can sign all outgoing messages, deploying this becomes much easier

But what about autoresponses and other automatically generated messages?

Need to make an exemption for them, but notify the recipient that the message was automatically generated  
Also exempt them from the feedback (notifying the sender that the message was not signed)

Conclusion: wait with work on the draft until unobtrusive signatures are generally implemented and experience is available


## Autocrypt v2

Host: Holger

Holger: dkg is not here.  So based on discussions with a range of people, mostly from delta chat, but not only, came up with this autocrypt 2 specification.  Who has read the draft?  (A few people say yes.)  Autocrypt 2 only takes about certificates.  Autocrypt 1 talks about the binding between user id and email and how to update peer state for the context, etc.  Autocrypt 2 is focused on more than just email encryption, because it is a scheme for reliable deletion ("forward secrecy").  It is also not about the binding, it is how to rotate subkeys so that each subkey is time boxed.  If you want to encrypt to the certificate and there is no subkey, you have to use the fallback key.  This ensures that there is reliable encryption.  Matrix uses message based ratcheting, which leads to many complexities especially when the network has issues.  Clock based ratcheting is much more solid.  You are either in the time range or you use the fallback key.  The second design element was a precise putting down of the algorithms to constrain the size of the certificates.  This is important if you have a large group and transfer 50 or 80 keys.  The selection of algorithms was driven by this, but it is similar to the best practice.  We decided at the last minute that we use Ed25519, because not Ed448, whose implementation is not as well proven.

The sending size is fixed.  But when you process it, you have to do merging, because the sender will distribute new subkeys.  For instance, if a subkey is valid for 10 days, 5 days before, the sender will start sending out a new subkey.  We can still use key servers, but not everyone will check the key servers all of the time.

Daniel: The key that you are distributing will always have a short-lived subkey, right?  If you lookup the key, then you don't have to do any merging, right?

Holger: The key that I send will be valid right now, but the receive still has to do merging.  If I get a key from you today, then another in 7 days, then you have rotated.  So I still have a valid one and I locally merge the new one.  You could drop the old one.  The spec says that you expire keys that are definitely not valid any more.

Kai: So most of the time you distribute two keys, right?

Holger: You always send the short lived key and the fallback key.  But any contact might have multiple subkeys.  But the sender can only send a single short-lived subkey.

Andrew: Only one certificate is sent with two subkeys.

Daniel: Subkeys overlap.

Kai: Where should we discuss how to distribute certificates with a classic subkey or a postquantum subkey?

Andrew: v2 says that only a post-quantum subkey can be used.

Kai: I could send two autocrypt headers: one with the classical and one with the postquantum key?

Holger: Not really, no.  What you do in your local keystore, that's up to you.  Autocrypt 2 doesn't talk about headers at all.  It's up to the client to either send/receive the certificates inline or get them from a keyserver.  The actual network transfer is a separate concern.

Kai: Is the OpenPGP email summit a good place to talk about the headers?

Holger: Sure.

Patrick: Shouldn't we extend the spec to include the header?

Holger: We will use the autocrypt v1 header in delta chat.

Holger: Who can implement this?  PQC is one part.  The other part is the reliable deletion and not every MUA can implement that.

Kai: I need both a classical and a PQC key.  So I need two headers, one for autocrypt v1 and one for autocrypt v2

Holger: PQC is one part.  We do PQC, and v6 at once.  If you are an email client, then you have a hard time getting keys.  You can constrantly forget the short-term subkey.  If you are a database viewer and need the decryption keys, then you can't do the reliably deletion.

Holger: When we do this, then the sender will forget their old decryption subkeys.  If they don't, it misses the point of the spec.

Vincent: I think Kai is asking if he can only send the fallback key without a short-term key.

Holger: Sure, I think that would work with Deltachat.  You just leave this out and you get normal PQC.

Bart: we should call this "Pretty good forward secrecy"

Kai: I want to transfer one ECC, one PQC, and one other key.

Vincent: In v1, we said the certificate structure MUST be this way.  But it should have been a SHOULD.  This blocked a number of people.  This is blocking Kai and it blocked Justus.  We never addressed this.  So we should change this to a SHOULD.

Andrew: An autocrypt v2 certificate follows this structure.  How can you really be sure?  I want this to be explicitly flagged that says this is an autocrypt v2 certificate / subkey.  From the keyserver point of view, I don't want to retain the old subkeys.

Holger: I understand where you are coming from.  But there is a certain beauty is this just being a v6 certificate.  You should already take the short key based on current semantics.  This can be processed by a v6 client that knows nothing about v2 and that is really nice.  Why make this explicit?

Andrew: Because it will fill my database.

Vincent: You can drop the expired subkeys.

Andrew: That would be a change to the entire ecosystem and we should consider this separately.

Kai: Couldn't you use a heuristic?

Andrew: A heuristic is nasty.

Vincent: 50 subkeys that are expired has no valid from anyone.

Andrew: I think we should be able to distribute them in key servers.  They are just certificates.

Holger: Are key servers doing clean up?

Vincent: No.  But for non-PQC keys that's not a problem.

Andrew: I just want a specific mark.

The key holder should apply the rotation algorithm.  In a multi-client scenario, if I import the key material, how do I know how to apply the key rotation algorithm.  There's a separate argument that this notation (on the rotating subkey) should be critical, which dkg says should not be critical.  I could live without the critical bit, but I want a flag.

Daniel: The problem is that someone could not set the flag and then flood the key server.

Vincent: Just delete expired subkeys.

Daniel: I think that having it critical just makes the security flag.  Senders that don't understand the critical flag can't live the short lived subkeys, which is just a net negativity.  I think the key owner could hold the data externally.  There's no need to communicate that to communication partners.

Holger: However you sync your private key to a different device, you need to use the same rotation window and same ratcheting.  How you do this is in the spec.  It's worth a discussion, but I want to look at how this is currently happening.  You have one client that does the ratcheting.  Then you transfer a snapshot to another client.  Then you get desync'ed because the other client doesn't do the ratcheting.  But that is discussed in the spec.  There are different schemes to have an operable second device.  So it's unclear how much you want to encode this in the key.  For instance, you don't just want the ability to decrypt, but you also want the same contacts.  So you need to synchronize that as well.  So what is in the spec is a bit controversial.  The hunch so far is to not specify this too much.

Vincent: Are you using stateful or stateless ratcheting.

Holger: You also need the old private key and the clock.  So it is stateless.  Each device can do this, but they need to agree.

Vincent: The clients need to agree that they will following this scheme.

Andrew: Having an explicitly flag will allow the second client to be sure it is syncing correctly.  This also let's the client show whether the chat will be deletable.

Holger: Your intuition is that this would be good to specify.

Andrew: I think this has no downsides.

Vincent: I think it does.  For multi-device sync, it makes sense.  But the receiver should not depend on this information at all.  No receiver decision should depend on the sender's rotation scheme.

Andrew: I hear that it is not necessary, but not that it is bad.

Daniel: The things that you want to depend on this flag.  Like deleting subkeys should just be done.  You don't need the flag for that.  My feeling is that anything that uses the flag could be inferred from something else.

Andrew: I'm not saying we shouldn't clean up expired subkeys.  The difference is that old expired subkeys can be unexpired.  But these are not going to be revived.  This creates a lot of DB churn.  This new scheme is a committment that the key will be deleted.

Holger: If I understand expired keys, it is useless.

Vincent: You can just reupload it if you extend the expiration.

Andrew: We are committing to deleting subkeys.  Since this is a change in expectations, we should mark it.  You can always say it and not do it, but that is always possible.

Patrick: If you send autocrypt 2 headers, aren't you comitting to that?

Andrew: How do you know it's autocrypt v2 if the key is uploaded to a keyserver?

Holger: We should distinguish between senders and receivers.  Even if someone collects all of the traffic and I delete the subkey, then no one can decrypt it even if they get my device.  That is a guarantee as someone who produces these.  As a recipient how these are ratcheted, I don't know.  The merging allows for flexibility.  For instance, everything will be deletable in 4 days instead of 10 and the receiver doesn't need to know anything.

There is an issue that is larger than this certificate.  How do you ensure that message deletion is synchronized?  For instance, you bring up a device that was off-line for 10 days and then it gets the messages.  The messages are deleted so many days after receipt.  Someone could have a hacked client that doesn't delete the messages even though it says it does.  We don't try to solve this.  We send messages that respecting receivers will actually delete.  That's outside what the PGP spec can mandate or enforce.

Andrew: Say you're sending these messages to someone who uses Thunderbird.  Will gpgme accumulate all of these subkeys?

Holger: Well, gpg can't process v6 certificates.

Andrew: I take Daniel's point that you can do all of this without autocrypt v2.  But what we're doing here is instead of one or two clients doing this, we're potentially putting 1000s of clients out there.  That's a change.  I think it is just polite to mark them.

Daniel: Beside this coordinated deletion, we also need to worry about when deleting subkeys you don't actually need them anymore.  But in the email case, you might have the message stored in an imap server.  So you couldn't read this if the subkeys have been deleted.  We could reencrypt and update the message on the server so you can still decrypt it.  But that raises the question of whether you have achieved the goal written in the spec.

Stephen: The forward secrecy says that if someone gets access to the device later they can't read the message.  So if you reencrypt then you don't have forward secrecy.

Daniel: Right.  This is something that we should think about.  Users may complain if they can't read the old messages.

Holger: You can only implement it if you don't keep your ciphertext.  If you need to read old messages, then you need to keep the subkeys.

Patrick: You can stash session keys.

Holger: There are a few things you can do.  You can stash session keys, you can reencrypt.  But the spec doesn't state this.  The spec states that you forget the encryption keys.  If you can't or don't want this, you just do PQC.

Bart: Symmetric reencryption is different from keeping the subkey forever.

Holger: Whether you have forward secrecy requires something else.

Daniel: If the only thing we're adding is the rotating subkey during transmission, but reencrypting to keep it permanently, then you gain a bit of security.

Holger: I think we're not talking about a magic property, but something concrete: deletion.  If you don't delete the messages on your device, and you don't delete the messages, then you don't need this.

Daniel: I don't think we'll have "universal" deletion in the email world.  But we might have messages marked for deletion in 7 days.

Bart: I'm a bit unoptimistic on this.  People in compliance will be unhappy.  There are businesses that can't do this.  They cannot comply.  The fact that you want them to comply is not their problem.  We could check if a receiver accepts expiring messages.  Then we could show some UI that the user can make an informed decision.  This would require a mark in the key.

Bart: I really like that this is PQC and v6.  I would prefer to not mix versions.  I would keep all classical stuff out of v2.  OpenPGP's original sin is keeping everything.

Holger: We have a financial incentive.  We want to audit everything and we need to limit the surface.

Andrew: I'm being insistant about the mark, but I think this is a really good scheme.

Holger: I think the fallback thing is also important.  This avoids telling users: "do some magic thing to reestablish the connection."  This is an acknowledgement that users want to send messages.

Bart: Marketing suggestion: this helps security.  This is "pretty good forward secrecy" but please don't market it as that because it invites comparisons with "perfect forward secrecy".

Holger: There are some people doing research on how long Signal is actually keeping messages.  For instance, if a device is off line for a few days, then it can't immediately delete all keys.  So it turns out it is not perfect.  Signal keeps the keys.  It is not just well researched.

Holger: There is value in educating users.  Talking to people in Iran, they believe in these magical properties without understanding what these properties are really about.  I think as a community we should educate.  That might not win against certain kinds of marketing things.

Andrew: There is a lot of cryptographic fundamentalism out there and it is exhausting.


## Confidence Levels (UI)

Host: Kai

Kai: In the past and currently, Thunderbird encryption is a yes/no decision in the UI.  The usability of a correspondent's certificate is either we accept it or we don't.  It is currently completely a manual process.  The user has to decide for each certificate.

Alice has a chance to whenever she decides, Bob is offering me to encrypt. Alice can decide if it is necessary whether to verify Bob manually or not critical as it's a more informal thing.  This gives the user the choice to decide what level of assurance they need.

The current thought is how to get away from this manual step.  Can we automate this?  Can we introduce any mechanism that will automate this.  Can we find a way to get away from the requirement method? Finding a baseline to have the same method for everyone in the world? This thinking has been in Kai's mind for a long time.

The new idea is that we don't make it a yes/no decision for the manual verification but rather use the UI to solve that problem and show level of authentication we have for the correspondence key.

When Alice composes an email, Thunderbird can look to see if there is any evidence that the certificate is the correct one.  Based on these checks, the UI can show the degree of confidence.  This allows a trained user to notice that the confidence level is correct for my use case.  For people who don't worry about this, Thunderbird should automatically accept keys with a lower confidence if the base line is reached.

Aron: I think that both Proton and Parula are using the same approach here: using symbols and locks with different shapes and colors.  In Proton we have three levels: 1)not encrypted, 2) key found somewhere, e.g., WKD or KOO, or 3) the user pinned it manually.  You could argue that autocrypt could be used here, but is lower than WKD.

We use colors of different locks and shapes.  I think our system has too many colors and shapes.  If the user hovers over the lock, details are shown about where the key was found.  We still think the UI is too confusing.  The question is whether there is a substantially different UI that we could achieve.

Kai: it is still at the idea level, even at Thunderbird. but before, question: do you think this approach is reasonable.
Neal: this is what Sequoia is doing, so it is reasonable.
Elio: Are we showing all the keys of recipients? There are things that need to be discussed. We show not only the confidence level, but also the threat level?
Kai: It's mostly discussion threads. But I have not thought about that yet.
In the past we had an indicator that this message is signed or encrypted.  In the past we had just one indicator that summarized the global state.  I want to seprate things.  I want one encrypted that says what will happen and what is the confidence level.  We could show one icon in the summary view.  Or we could have one icon for each recipient.  Elio said yesterday that that could result in the user missing 1 bad out of many good markers.
Separating the ui from the confidence levels.

Aron: Different recipients may have different levels at different times too.

Kai: the status should always be dynamically received.

Aron: Imagine I get a signed message from you and a month later your key is compromised.  Is it still valid?
Elio: if you can audit if it was valid when you received, you can see the difference.

Aron: Then you also get to the point that your key expired.

Kai: That's a tough point.  We did the simple thing.  For S/MIME, after a key expires we couldn't check for a revocation.  Because of that, if the old thing is expired, we show that it is not a good signature.

Elio: if you want to audit when the key is expired, you should access it not only from the UI, right?

Aron: Users freak out if they look at an old message and suddenly the signature is no longer considered valid.  Here we have a set of UX issue that we might want to exclude some and focus on some.

Stephan: What time stamp should one use?  When a message was received?  The time in the header?  I think the three levels and wouldn't want more.

Kai: the strongest level: manual key verification. that's what activists need. Level 3.
Level 2: 3rd party verified the keys correctly like a CA, or in an email client (not supported by Thunderbird yet) e.g, I trust Neal therefore I trust them.


Elio: Should using a CA be the same level as manual verification?
Kai: would like to distinguish the case at least in the UI.

Aron: You would distinguish the case between a CA and WKD?

Kai: Someone puts their stamp on it with a CA.  With KOO there is no audit trail.  You can easily make a targetted attack on one person.

Aron: it is easy but as a client, it is hard to trust and know where the key is coming, the authority is the domain, KOO is KOO. If you fetch it from the domain?

Aron: I would like to reduce the states from the user's perspective.

KAi: Example: symbolize the confidence level, maybe with a shield, if someone has verified it, a magnifeying glass; a ribbon or a shield for a reasonable cert.
Neal: I propose 3 levels only, no evidence, some evidence, but not enough, and sufficient evidence.  This abstraction is at a different level: it shows whether the evidence is sufficient, not what evidence was used.  If a user wants to know what evidence went into the calculation, then can drill down by clicking on the icon or the tooltip.

Kai: agreed on the majority of users. there are users who prefer to think on their own.
Stephan: this has to be done to reach each level.
Kai: we could define that we have sufficient evidence to say the shield and the sword, treating verifications as the same level but the users should differentiate between the manual or not.

Elio: Proton shows the information in a tooltip.  You cannot rely on icons, but that should be tested.

Kai: We agree.  That's a detail that we have to ask users about.

Stephan: It only matters in the first part of the conversation.  In the 10th message, I already have in mind that this is secure.

Kai: But the key could have expired and the only new key is weakly authenticated.

Stephan: This is a way other problem.  I don't think users are trained to look at such an icon everytime they send a message.  So if the state changes, then we should warn the user so that the user is aware of the change.  Signal does this.  It shows  a notification that something has changed.

Kai: First you might be using multiple machines.  Second, I know people who are from the US government, and they told us that they have very specific training to always check that a specific icon is present to ensure that they have a secure communication.  I want trained users to be able to immediately see the difference.

Aron: for us it works decent. users look at the look, for more you can hover and see more details. there are discussions to be made for multiple receivers.
There are no statistics for how people hover or not, and how they use it.

Elio: I don't look at the icon anymore.  I only see the color.  I don't think the hovering part is that big a deal.  Like Kai said, I think it is an assumption that needs to be tested. Maybe something we can do might be A/B testing, where we test different prototypes, before and after and see how the users interact.

Kai: I want to complete the picture.  We have two states that should be the same or are mostly the same.  The different states are the base level states.  What is the minimum level for accepting a certificate.  My opinion is that we have at least one piece of third party evidence before we use it.  Either a verifying key server (e.g., KOO), WKD, or a transparency log.  This could evolve over time.  My preference is to treat autocrypt as not sufficient.  There's not third party evidence.  It could be a fake key; an active attack.

We need to know for third parties for the users.

Neal: in Sequoia we use a unified calculus. When I get a certificate from KOO, we have a shadow CA that records that this came from KOO.  Likewise for WKD.  Then users can say how much they are willing to rely on each of the CAs.  This is useful, because some users in a given country might not want to use KOO.

Kai: powerful approach. people need to have the skills to make a decision like this. my alt thinking is "i want to have a place where all these can be accepted."

Neal: We of course have defaults.  And it is true that not many users will customize this, but there are power users like admins who can configure them for their users.

Kai: agree on the users, but the question is, is it suffiecient for the keys (on or off for every source), to allow and exlude?

Neal: we have ways to do this, with evidence to combine.

Kai: we have calculations to make on the background. we could have a trust score, and coming up with the levels, but that is too many states to present them. with fewer states, Thunderbird might do that.

Neal: you don't need to present them, you have above 0 and
Kai: from programmer's perspective, it's about the threshhold. communicating it to the users, is the problem.
Neal: We've been doing this in Sequoia for a while, please take a look for an example.
Kai:



Aron: we have a little lower threshhold then Sequoia. We try to be a bit more mainstream. Any key is a valid key. Wherever we find it (KOO, KDI; pinned) we trust them.
Kai: do you accept the autoproof? key?
Aron: I would change the 3 levels: no confidence or not enough is 0; enough confidence is level 1;

Neal: If we consider it geometrically, the difference between 0 and a tiny bit is infinitely larger, but the difference between two finite values is a constant.  So, the difference between enough evidence and manually verified doesn't matter and needn't be shown.

(Neal and Aron continued discussing about whether unkwnown evidence or a tiny bit evidence is stronger)


Elio: I want to avoid level 1 being considered worse than no encryption.

Kai: I don't want to scare people away.  I don't want people to think that level 1 is bad.  That's why I want to use a neutral icon: an empty shield.  That visualizes that you are protected, but we are not telling you how.  I thought about cutting off a corner of the shield to show that there is some security, but it is not that great, it is tainted.  But, this could be interpretted as being bad.  If it is stronger, then we show a stronger icon.

Elio: for me it's a semantic feeling, it needs to be a visual enhancement from the levels, rather than making one look bad than the other.

Kai: I don't require that every user see that one icon is better.  Only trained users need to be able to distinguish this.

Elio: How the icons look doesn't matter.

Kai: Being explicitly and telling the user what we know is more understand than an abstract level based on a web of trust calculation.

Joakim: A way of think about this is: what does the user have to do?  If we have 3 levels perhaps: 0 is don't send the email, 1 is need to check, and 2 is this is good enough.  Having more levels that that is not so useful.  If we have 4 levels and the middle levels both mean the user still needs to check, then they mean the same thing.

Kai: the weekest level: no key at all, a shield with a dotted outline on it. The user turns on encryption, it is crossed out.
Elio: maybe not show an icon at all? if the state is not encrypted.

Kai: The user has the option to turn encrption on or off.  Then there is a separate icon that says the confidence level.

Kai: Then there are keys that arrive via autocrypt.  That's not good enough for encryption, but its better than no key.  The user can click and decide to use the key.  So I think we need a few more states.  I think your point is good, Joakim.  But we should have a base line, and the user can click and improve it.

Elio: We could use a shield that gets progressively thicker, which is only a positive change.

## openpgp.org governance

Andrew: The KOO board already exists and has a "heavy" governance structure for what there is to do. The idea came up to use the governance structure to also cover openpgp.org (e.g. to create detached mailing lists for research topics).
However, the board has no legal standing, and it would be great to e.g. transfer ownership of openpgp.org domain from Phil Zimmerman.
Vincent: It is possible to create a German "Verein" as legal entity.

Andrew: Phil wants to get rid of individual responsibility, whereas other existing individuals do not want to take on individual responsibility. The KOO board could be incorporated (e.g. as a Verein or Foundation) to take care of this.

Daniel: It has also been discussed to move tests.sequoia-openpgp.org to the OpenPGP.org domain.
There are more board members than active people.
The hopes are that more people will participate if things get more consolidated.

Vincent: We need to collect ideas about which things can be consolidated.

Andrew: The currently involved people are already taking care of the different parts of the existing things that could be consolidated.

David: Creating a Verein is cheap.

Vincent: Doing paperwork for a Verein is something that needs taking care of.

Daniel: Another idea from earlier was to move the responsibility to Wau Holland Foundation.

Vincent: Currently the setup in Wau Holland Foundation may not be a good choice long-term due to responsibilities shifting.

Andrew: The board members could just be taking care of the governance, while Wau Holland takes care of the legal aspects. In the future it could be moved elsewhere.

Vincent: If the Wau Holland Foundation dissolves a trustee must resolve any open matters.

Bart: A contract could be written, so that the asset (e.g. openpgp.org domain) will be transferred elsewhere.

Andrew: A clause can be defined to have the board be in charge of any change to the relevant "assets" in e.g. Wau Holland foundation.

Vincent: The wiki should be consolidated, so that it doesn't only relate to gnupg.org and we could self-host a wiki.

Daniel: Currently this works via merge requests.

David: Also, self-hosting a wiki is painful due to bots.

Vincent: What are the next steps?

Andrew: At the next board meeting we will propose the necessary changes to the constitution: https://gitlab.com/keys.openpgp.org/governance/-/merge_requests/54

Bart: When further legal requirements arise, other legal entities can be evaluated.

David: We had mixed results with SPI with Arch Linux wrt to speed of process. I would recommend a European option if possible.

Andrew: OpenCollective has been considered, but for the current tasks at hand, Wau Holland Foundation is leaner.

Vincent: Moritz Bartel ran a Center for Cultivation of Technology (CCT) which used to offer services like these.

Bart: Focusing on an entity that focuses on this type of work would be good.

Vincent: This can be evaluated when the need arises.

Daniel: If Wau Holland can hold the domain, that'd be great.

Vincent: A local Verein such as the one of my local hacker space may be open to take care of things as well.

Andrew: Nothing other specific things needs to be done now. We can setup with the Wau Holland Foundation now.
Bernd also described a scheme under which e.g. an OpenPGP Foundation (hatched from Wau Holland Foundation) can be founded if needed.


## Key Transparency

Andrew: Publishing of a log to track changes to a certificate.

Daniel: Merkle-Tree based system from the CONIKS paper. WhatsApp has also deployed it. iMessage system is similar to this.
An IETF working group is working on a Key Transparency system.

Patrick: Where would such a system live?

Andrew: Keyservers, as they do certain amount of this work already (especially the old SKS keyserver software).
Each certificate consists of a sequence of packets that are ordered and then hashed.
Needs to be sorted into a prefix tree, which organizes the hashes into buckets.
Hierarchically going up to a top-most hash.
The key transparency working group approach is similar: Time based and space based Merkle tree.

Daniel: I'm in favor of adding this type of functionality to keyservers.
In Proton the certificates are sorted in merkle trees. Periodic hashes of all certificates are released (an epoch).
A time-based Merkle tree is taking care of changes to the epoch releases.
Everyone is supposed to check their own key.

Bart: The idea is that everyone is having the same cryptographic view of all the keys.
We can still have users change their keys (e.g. by changing the password), which is then a public action and is reflected in the next epoch.

Kai: So the hashes are only used for verification?

Andrew: Yes. The idea of key transparency is to audit.

Daniel: Proton distinguishes: Each user can audit their own key. But also global auditors can check the chain of events globally and that if a key is updated the revision ID is increased.
Local users only need to check if their own revision changed between different epochs.
Our system piggy-backs on the TLS certificate transparency system.
Auditors sign every epoch.
A growing system of "witnesses" provide signatures over a transparency log event.

Bart: Witnesses become a liability, but they also provide reliability.
Checks and balances are put in place to ensure reliability.

Andrew: What is the difference between certificate and key transparency?

Daniel: Certificate transparency is an existing thing for TLS.
Key transparency is what we are talking about in our context.
An append only log of changes to sets of certificates.

Andrew: What are we achieving?

Kai: An audit trail.

Bart: If I put my certificate in KOO, I can check it myself.
Key transparency ensures, that everyone has the same view on this.
The key server cannot lie about this change.

Andrew: So this is a consistency guarantee.
Is this only useful for a verifying keyserver?

Daniel: In a way.
If a key is only uploaded once and never checked, this is not yet useful.
Users should upload their own keys and then check them.
This makes sense in the context of a verifying keyserver.

Andrew: In HKPv2 this would be the "canonical bundle".
We are treating it as a "fundamental object", containing one or more certs.
This declares: This bundle is e.g. attached to some User ID.
We need to support v4 and v6. We need the replacement key mechanism to work.
The bundle would go into the transparency logs.

Holger: This ensures that the bindings can be secured.
It ensures that others cannot append other things (an accountability layer).

[quarrels ensue]

Andrew: A key transparency log combines a bundle and a search term (aligning both via a Merkle tree).
Should this be added to the HKPv2 specification (e.g. as a separate endpoint)?

Patrick: How would this work?

Andrew: As a search API for returning these merkle tree.

Daniel: You need a path from a leaf to the root hash to be able to verify.
The existing working group has already defined how this works, so we do not need to worry about this.

Kai: How do I know whether older entries of a key are correct?

Daniel: This is solved via epochs.

*Andrew is drawing a merkle tree

Daniel: To get back to the HKPv2 draft, it's probably worth doing a separate draft to discuss how to apply the output of the Key Transparency working group to OpenPGP.
Only after that it should be an extension to HKPv2.

Andrew: I agree, that it should only eventually extend HKPv2, but not reopen the current draft.

Bart: How does this work for certificates/packets from other sources?

Daniel: This is tricky. We should focus on verifying what a keyserver is doing instead.
We also need to worry about synchronization.

Bart: Verification implies a shared secret.

Andrew: Each individual keyserver attests separately.

Bart: That makes it harder to verify, as you would need to theoretically do this for each synchronizing keyserver.

Andrew: That's true, but it would also be possible to do this stochastically.

*Andrew explains use of merkle tree functionality in SKS based on a graph.

Andrew: The ptree (prefix tree) provides "inclusion proof".

Daniel: The merkle tree inclusion proof consists of a list of neighbors.

Andrew: The ptree represents a point in time. A separate epoch tree references each point in time.
Is this useful in addition to HKPv2 for keyservers?

Daniel: We should rely on the reference implementation of the Key Transparency working group and only specify the output of the API.

Kai: I'm not sure how to use this yet.

Andrew: If you look me up, you will get a bundle of certificates. This can then be hashed and used to look up as an entry in the transparency log.

Kai: Okay, so I could also check an older generation of a bundle.

Andrew: If someone makes a GDPR request, the "canonical object" may be deleted. However, one could still look up the (previous) existence of this object, given that one has stored a VRF of this (now removed) object.

Daniel: You can get a non-inclusion proof (to ensure it is not a proton user) from our setup.
Non-inclusion proofs need to be created on the fly.

Daniel: We also have tombstoning. You get a special response for entries that have once been present.

Kai: How do we deal with disputes? (e.g when the user finds a false claim about their certificate)

Daniel: Yes, we want to also have some form of response, when a change is requested by a user, so that they know in what future epoch their change will be published.

## Dealing with Resource Exhaustion Attacks

Host Neal

Sequoia has received a number of reports about resource exhaustion attacks, for instance, high Argon parameters, decompression bombs.  Let's exchange experiences.

Examples from Proton: reject large RSA exponents, reject RSA keys with more than 32k bits.

What to do about Argon?  Proton has some limits on the parameters.

Sequoia needs to be future safe, e.g., for LTS systems that will be around in 10 or 15 years.  Instead of hard coding limits in the code, could have compile time parameters, or run time parameters that can be configured via a policy file.  Compile time parameters might be tuned by an LTS distribution to be very high.  Using a policy file, the system admin or user could tune it.

Sanity limits should be very high.  We never expect anyone to sanely ever need.

For Argon, a user is likely to be involved.  Then they kill the application and try again.  At most, after the third time, they'll give up.

What about compression bombs?  Look online for possible heuristics to detect bombs.

Certificate canonicalization: O(n^2) for fixing out of place self certifications.  For instance, 100 user IDs and 100 bad self-signatures.  Need to do 100 * 100 trial verifications to realize that none of the signatures are in place.  Putting a limit on the number of trial certifications can also open an attack vector, which allows an attacker to make a certificate unusable.

GopenPGP has a limit on number of self-certifications.

When downloading a certificate, we can:
- Check if the data appears to be a key (in particular, MSB, which no HTML contains)
- Limit on number of bytes (a couple of megabytes)tr
- Limit on time (few seconds).
    - This has caused some issues.
- Other possible heuristics

Proton can afford to be more strict:
- Can easily change parameters
- Missing key is usually not such a big deal


## Revocation Distribution

Host: Andrew

Andrew: If Alice is a CA and certifies a certificate, but it turns out that it was wrong, what do I do?  Well, Alice can revoke her certification signature.  In general, people will have a self certification of their user ID and there will be zero or more third-party certifications.  The point of having a certification revocation is to allow people to change their mind later.  Perhaps someone has lost access to their secret key material and can't issue a revocation certificate.  I can at least revoke my certification.

Andrew: With 1pa3pc, Mallory can refuse my revocation certificate.

Andrew: In X.509, CAs publish CRLs.

Andrew: In PGP we could do something similar.  Instead of attaching my revocation to your certificate, which is not allowed.  I should be able to distribute my revocation certificate with my certificate.

Kai: So CA certificates could get very big.

Andrew: We need to think about where the bloat is.

Kai: Why wouldn't a key server distribute a revocation for a certification that is allowed?

Neal: 1pa3pc doesn't actually verify the certifications, but hashes them.  So we can't assume that the key server can check the cerification or the certification revocation.

Andrew: We could define a new revocation subpacket like an embedded signature subpacket.  That would live in a user attribute.

Neal: Third party certs should live on the certifier's certificate, since it's anyway needed.  This would avoid the flooding problem that we saw in SKS, because I would never download or use an attacker's flooded certificate.  To deal with CAs that make many certifications, we can request certifications that match a filter, or ask the key server for all certificates that certified a particular certificate.

Bernd: But what if I want to know who signed some certificate?

Neal: Why do you want that?  I only care about who certified a certificate if I consider them a trusted introducer in which case I'll have their certificate.

...

Andrew: A direct key revocation is only a public key and the revocation.

Kai: Could that work with third-party certifications?

Andrew: You also need the user ID to verify the signature.

Andrew: If I have multiple user IDs on my public key and I want to redact / revoke a user ID, the user ID has to stay (along with the revocation).  If I could attach the revocation to another component, then the key server could remove the user ID without the revocation certification being unverifiable.

Kai: You could anonymize the user IDs by turning them into their hash and issuing the revocation over the hashed user ID.

Andrew: I worry that would be a very invasive change and a long time to role out.

Neal: Hash prevents invertability, but if it is possible to guess a user ID (which is likely if the certificate has other user IDs), then the anonymization is limited.

Andrew: Putting the revocation in a subpacket means that there are no compatbility problems.

Kai: In X.509, expiration time is immutable and after expiration, it is possible to delete most of the certificate.

Aron: I like the elegance of having the certification on the certifier's certificate.

Kai: We could have short lived certifications.

Andrew: Let's say I've certified a lot of keys.  Do I have to recertify all of those people?

Bernd: I really like the idea of the third party certification goes to the certifier's certificate.  If I now add a reference that, say, Kai signed my certificate, then someone doesn't need to query a service to figure out what certificate's signed a certificate.

Neal: I could live with that.  I'm not yet convinced of the use case.  But assuming the use case, sure, that seem reasonable.

Andrew: How do we deal with people who have certified many certificates?  If we have an end point on a key server that allows querying specific.

Bernd: If we have that type of end point, then we've centralized it again.

Neal: You don't have to use a key server.  You can still get the certifications in the same way that you're getting the certificates now.

Andrew: We want to restrict certifications to prevent spamming.  So putting the certifications on the certifier's key means there is no spam.  The only disadvantage is with a CA that may generate a lot of revocations.

Kai: If we do this, we need to ask for a certificate without any certifications / revocations.

Andrew: Neal's bloom filter idea works well for this.  Bloom filter is better than a straight filter, which leaks more information.



## Key/Certificate terminology

Daniel: Transferable Secret Keys (TSKs) to distinguish from Transferable Public Keys (TPK) is used in the spec.

Patrick: This is terminology used by experts.

Bart: I like that it distinguishes between secret and public.

David: In the OpenPGP for Developers book we used similar terminilogy.

Daniel: Me and Bart dislike the use of certificate (preferred by e.g. dkg and sequoia) for public keys.

David: So you would prefer TPK or plain "public key" over "certificate"?

Daniel: Yes. As this makes the it easier to establish the connection between these two different types of views.

Bart: From examples in the real world, certificates are objects that are given to you by other parties. In OpenPGP you issue them yourself.

Daniel: I have the feeling the use of certificate is pushed over the use of public key.

Holger: Both terms are in use, but it is good to stay consistent.
What is the public part?

Bart: I can post it publicly.
It indicates what the user can do with the item (use it publicly, it is safe to give it to someone).

David: It muddies the water if people start abbreviating the "secret key" or "public key" terms to "key".
Certificate gets around this, with a different term.

Holger: But this is established by context usually.

Jonathan: End users should not have to care about this.

Daniel: Sometimes ambiguity is good actually: Key pair. You use something shared with you and verify it with your secret key.

Holger: We don't have as many keys to track in DeltaChat as Proton has. But we also do not make this distinction to the user.
We don't want to have public information on public keys/certificates to reduce metadata, as we may have hostile operators
The transport layer does not see the public keys and we don't want to expose these things publicly.

Bart: Normally users should not see this and not need to care about this.
Terminology from the X.509 world seems to be better technical terminology.

Daniel: I like the TPK/TSK terms, as they are very specific technical terms.

Bart: On a technical level it is good to be specific for OpenPGP terminology.

David: Kai's recent mail proposed a new terminology for endusers

Jonathan: I would rather like for us to use already established terminology and not use new terms.

Holger: In the autocryptv2 specification 1.2 it is established that "OpenPGP certificate refers to a Transferable Public Key".


Bart: For technical, internally used terms in OpenPGP it makes sense to stick to TPK then.
I would like for us to not use certificate when talking about public key.

Daniel: I just wanted to find out whether the consensus really is that "certificate" is the term to use over "public key".

Bart: The fact that e.g. "public key" is very searchable, is an indication that it is easier for endusers.

Daniel: The OpenPGP book has a specific target (developers). Should we suggest to change the terminilogy from certificate to TPK there?

Bart: It might be useful to establish deemphasizing the use of certificate, unless you're specifically in a context where people are familiar with S/MIME and OpenPGP.

Daniel:

Holger: The concept of self-signed certificates also exists.
In TLS this is very prominent.

Daniel: I agree, for end users we should not make this prominent and instead hide details (e.g. instead refer to "encryption").
only if the user really is interested in details, expose them to terminology.

Bart: If you are not familiar with specific technology, you will not understand this terminology at all anyways.

*Holger asks dkg via chat what his input is and he replies that he has no further info to add for now.

Holger: User studies since many years show that encryption and decryption _number_ has been much easier for people to grasp than _key_.

Bart: For encryption/decryption this is clear, but I guess the ship has sailed on the key terminology.

Holger: Yes, this is more of a simplified thing I sometimes use to explain lower level concepts to endusers if they ask (without deeper understanding of the technology).
I would not use anything beyond "encryption info" for user facing data.

Bart: Yes, a public number is also something what people use to refer to e.g. a phone number to call.

Daniel: Kai referred to tokens in the proposal, but it is also used in the crypto(currency) world.


## Wrap-up Session: Action Items

* Fingerprint Verification or Public Key Verification
    - Review literature & determine best practice (Ben, Kai, Daniel, Elio)

* OpenPGP & JSON
    - Come up with proposal for schemas (Andrew, Neal)

* Second Device and Key Backup
    - Kai will continue to work on it. Daniel to review.

* Unobtrusive signatures
    - start implementing it! (Proton, others)
    - reach out to implementors of MTAs (e.g. mailman) & spam filter providers to ensure support for unobtrusive signatures (Andrew, Kai)

* UX Peer Review Session
    - design process (Elio)

* PQC Migration
    - get Hockeypuck to work with v6 keys (Andrew)
    - roll out v6 PQC at Proton (Proton)
    - roll out PQC with v4 in Thunderbird (Kai)
    - Implement PQC in FreePG (v4) (Aron)

* Expect Signed
    - Wait for experience with unobtrusive signatures

* Autocrypt v2
    - implement it DeltaChat (Holger)
    - revise details based on experience in DeltaChat
    - Relax key requirement in Autocrypt v1 (Vincent)

* Confidence Levels (UI)
    - organize follow-up discussion (Kai)

* openpgp.org governance
    - KOO board to reconstitute itself, voting body to vote (Andrew)

* Key Transparency
    - look into it as extension to HKP v2 (Andrew, Daniel)
    - get in touch with the IETF KT WG (Andrew, Daniel)

* Dealing with Resource Exhaustion Attacks
    - no action items

* Revocation Distribution
    - no clear conclusions

* Key/Certificate terminology
    - Discuss with Heiko about terminology in OpenPGP book
    - continue discussion to reach wider consensus

* Publish minutes (Patrick)

* Next Meeting
    - next summit: around end of April 2027 (Patrick)
    - interim Meeting: 21 October 2026, 18:00 (Daniel)
