---
title: "Minutes of the 8th OpenPGP Email Summit (2024)"
permalink: /community/email-summit/2024/minutes/
---

{% include toc %}

## software represented

- Enigmail (Seamonkey/Thunderbird forks plugin)
- Hockeypuck keyserver
- r2mail2 MUA
- Proton
- Delta Chat
- [rPGP](https://github.com/rpgp/rpgp)
- PGPy
- Sequoia
- Debian
- Planck Security (was pEp Security)
- RNP
- Thunderbird
- OpenPGP.js
- go-crypto & GopenPGP

## standards referenced

- crypto-refresh
- replacement key
- persistent symmetric keys
- key transparency
- header protection
- post-quantum cryptography
- e2e-mail-guidance
- (webcrypto)

# Reports

## IETF OpenPGP WG Report - dkg

New RFC number has been assigned: 9580

Final stage: auth48

There are no substantive changes being made.  The editors returned a large number of questions.  These need to be answered.  The questions were reasonable, and all could/can be reasonably answered.  The RFC will almost certainly be published this year.

Examples of questions: wording suggestions

From an email perspective: there are no changes in the semantics of what OpenPGP offers.  There is still a session key, the deriviation works similarly, etc.

Some changes to the intended recipient subpacket.  Protection from someone taking a signature and putting it in a different context.

Header Protection: [draft-ietf-lamps-header-protection](https://datatracker.ietf.org/doc/draft-ietf-lamps-header-protection/)

Guidance + Future work in [draft-ietf-lamps-e2e-mail-guidance](https://datatracker.ietf.org/doc/draft-ietf-lamps-e2e-mail-guidance/)

## keys.openpgp.org report - Daniel H.

Proton started looking up certificates from keys.openpgp.org.  Got some complaints including one that got a lot of media attention.  Main complaint: why am I suddenly getting encrypted email?!?  In the end, Proton turned the feature off.  There is now a discussion about what uploading a certificate to keys.openpgp.org means: does it mean that people want encrypted mail or something else?  (This certificate is just for git commit signing.)  Keys.openpgp.org board conducted a survey.  Half of 12 respondents said: some email should be encrypted, but not all; others said everything should be encrypted.  The question now is: should there be some signalling about whether a user wants encrypted mail by default similar to how autocrypt does this.  Daniel H. would like to reach a point where we can send encrypted mail by default, and not inconvenince users.

Bart: we expected that this would go like WKD: almost everyone liked it.  In this case we got a lot more negative feedback.

Daniel: People should become members and vote, and even run for the board (next election is in the Fall).

KOO should make a public mailing list for announcements and updates.

## PQC - Aron

Few minor updates presented at the recent interm meeting.  There are some pressing questions that should be discussed today or tomorrow.  In particular: v4 compatibility for PQC encryption.  Most people seem to be happy.  Will continue with the draft.

## Interoperability Test Suite - Justus

[tests.sequoia-pgp.org](https://tests.sequoia-pgp.org/)

dkg: Are there any updates?

Justus: Some work.  In particular with respect to adding tests, contributions are very welcome.

Daniel H.: Very close to releasing production versions of OpenPGP.js and Gopenpgp with crypto-refresh support.

Justus: Let me know about when test result updates are required.

## PQC - Falko

Splitting out brainpool curves and NIST curves into separate drafts.

dkg: What are the concerns about PQC and email?

Aron: There are different concerns than just email.  Some algorithms (SLH-DSA) have huge artifacts (100s of KB), and signature generation can be very slow (3s on a laptop).  These are more appropriate for software signing.  Other algorithms (ML-DSA) are better for signing mails.  Encryption is so quick, it's not an issue.

Aron: v6 transition.  Someone is not ready to make the transition to v6.  The v4 compatability question is whether to support them.

## Persistent Symmetric Keys - Daniel H.

Draft: [draft-huigens-openpgp-persistent-symmetric-keys](https://datatracker.ietf.org/doc/draft-huigens-openpgp-persistent-symmetric-keys/)

Use symmetric keys instead of asymmetric keys: the latter is much faster.  Examples of where that is useful: PQ secure already; when encrypting to oneself (drafts, sent emails, archive).

There is a call for adoption.  If you have an opinion, please write to the mailing list.

## Replacement Key - Andrew

[draft-gallagher-openpgp-replacementkey](https://datatracker.ietf.org/doc/draft-gallagher-openpgp-replacementkey/)

Revival of a very old draft written by Daphne Shaw (from 2001).  This has been updated and is in call for adoption.

Idea: if someone downloads an old key, they can more easily find the new key.

After discussion on mailing list, it has been clear that there needs to be some automatic transfer of trust.  There are a number of ideas of how to do that.

The draft is still looking for adoption.

dkg: We need to hear on the mailing list that people are interested and even implementing it.

Andrew: I think some confusion is about current practice (ad-hoc transition documents), and the suggestion of having something automated.

## Hockeypuck - Andrew

The SKS key servers are alive!  There were some recent synchronization issues recently, but these have been fixed.  Part of the solution was dropping support for synchronization with the old SKS software, which is abandonned.  Hockeypuck also does normalization and signature checking.

Currently thinking about self sovereignty.  1pa3pc is the goal.  Have been talking to the keys.openpgp.org team.

[HIP-3:-Timestamp-aware-merge-strategy](https://github.com/hockeypuck/hockeypuck/wiki/HIP-3:-Timestamp-aware-merge-strategy)

## Thunderbird - Kai

Biggest change in the past year is adding support for autocrypt gossip (both consuming and producing).

Have implemented automatic encryption of mailing if some conditions are met: the user sent a previous encrypted mail to the recipients, etc.

thunderbird records the origins of keys that it found.

Autocrypt encryption preference is ignored because of the concerns of attack (Autocrypt header may be not DKIM-signed).

## Forwarding Draft - Aron

Draft: [draft-wussler-openpgp-forwarding](https://datatracker.ietf.org/doc/draft-wussler-openpgp-forwarding/)

Proton deplyed an implementation of the forwarding draft internally.  The key complexity is mostly hidden from users.  Users understood how it works and like it.

Bart: The forwarding stuff is now being adapted for groups (mailing lists under the hood).  Scenario: I want to share my drive with this group of identies.  This is done without revealing group membership to recipients of the share.

Andrew: Does this work with PQ?

Aron: Did some research, haven't found out if it is possible with Kyber.  Academia seems to be working on this, but this is cutting edge research.  This means that we should also be careful: we have a huge legacy burden so we should be careful.

## Thunderbird - GnuPG interoperability - Kai

Kai: Thunderbird had support for GnuPG-specific OCB AEAD decryption.  I wanted to be neutral.  I disabled support, but since we shipped it, I'm now considering reenabling decryption support in order to prevent regressions.

FSF has an encryption guide on how to use Thunderbird.  It starts with using GnuPG to create the key, and then importing it into Thunderbird.  This is problematic, because the certificates have feature flags saying that that the implementation supports certain features, which are not actually supported by Thunderbird.

Working with RNP to add a feature flag rewrite function.

Currently, when Thunderbird imports a key, it warns the user if certain feature flags are present, and links to a knowledge base article, which explains how to prepare the certificate in GnuPG so that it is compatible with Thunderbird.

## PQC Test Suite

Justus: Did some work at IETF 118 on a test.  Could send from RNP and receive by Gopenpgp.

Aron: Currently only have positive test vectors, but no negative test vectors.

## Header Protection Draft

dkg: A number of substantive changes in the draft a few days ago.  Thore identified some gaps and there were some good changes to the draft.  This means that there are no implementations that are compatible.  The changes make things simpler on the receiver side.  Currently the only main pending change is some clean up.

## WKD Draft v2

Bart: No progress.  Now convinced that WKDv2 should not exist.  Should instead have a mechanism to point to an HKP server (e.g. delegation via a DNS record).  An issue that Proton has is: if they do WKD for their customers, then they need to have 1000s of certificates, which creates load, and is a trust delegation issue.  Delegating to an HKP server would remove this issue.

Andrew: Keeping the keys at the top-level of .well-known is problematic: not how .well-known is supposed to be used.

[https://gitlab.com/andrewgdotcom/draft-gallagher-openpgp-hkp/-/blob/main/openpgp-key-discovery.md?ref\_type=heads](https://gitlab.com/andrewgdotcom/draft-gallagher-openpgp-hkp/-/blob/main/openpgp-key-discovery.md?ref_type=heads)

## Keyserver Padding - Andrew

Discussion document on how to do a padding scheme.  Suggestion on how to do padding that will survive a round-trip via ASCII armor. [https://gitlab.com/andrewgdotcom/draft-gallagher-openpgp-hkp/-/blob/main/openpgp-conformal-padding.md?ref\_type=heads](https://gitlab.com/andrewgdotcom/draft-gallagher-openpgp-hkp/-/blob/main/openpgp-conformal-padding.md?ref_type=heads)

## Encrypted Email Verification - Daniel H.

For KOO.  Vincent wanted something where users could first test their setup.  Then later consider it for verification.  No work has been done.

## v6 Forward Compatability Ping Implmentations

Justus / Daniel H.: Some work.

dkg: There is a permissive flag in RNP.  Question towards Nickolay: do you want to discuss forward compatibility in RNP and plans there?

- [https://github.com/rnpgp/rnp/issues/2204](https://github.com/rnpgp/rnp/issues/2204)

- [https://github.com/rnpgp/rnp/issues/2223](https://github.com/rnpgp/rnp/issues/2223)

Nickolay: Current policy is to explicitly opt in.  We'll add support for the stuff we don't support, and then it won't be a problem any more.

dkg: What about new versions?

Nickolay: Then we'll have to add support for them.

See [https://bugzilla.mozilla.org/show\_bug.cgi?id=1884337](https://bugzilla.mozilla.org/show_bug.cgi?id=1884337)  for related Thunderbird discussions.

Kai: Thunderbird's current approach is to import the certificate into a temporary space, and check the certificate.

dkg: the idea is similar to TLS-RPT, sender may request reports or to reject mails if they are unsigned

## Shared Libary API for SOP - dkg

The new draft has a C ABI.  It is not complete.  But the whole sopv part is there.  It would be good to see more implementations.  There are some downstreams that would rather use a C ABI rather than a CLI.

## OpenPGP-CA Key Rotation

No progress.

## interop Patching

No progress.

## SOP: sig vs cert timestamps

No progress.

## cleartext copy draft

Daniel H.: There is a personal draft.  LAMPs did a call, we should publish the draft in that space.

# Working groups

## Session #1: Schism (The OpenPGP Schism)

Talking about GnuPG going with LibrePGP ([https://librepgp.org/](https://librepgp.org/)). There is a LibrePGP specification that is being advanced by GnuPG.  There is also the OpenPGP WG, which has produced the crypto-refresh, which will be RFC 9580 soon.

Some differences: packets (e.g., signatures, SEIPDv2)

dkg: Let's talk about where we see the problems coming from.  Problems for types of encrypted data.  Interoperability issues (specifics).

Bart: This is intended to be a political discussion, and less a technical discussion.  We should not assume that we want to support everything.

Kai: What is the goal?  What is the problem?  Ideally: interoperability with GnuPG.  Question: How do we do it? Can we achieve it?

Daniel H.: We should focus on users, and not on GnuPG.  We want people to use e2ee when talking to each other.

dkg: What are some interop issues that have already been seen in the wild / that you see coming?  What are some strategies that you have / are considering to adopt?

Bernd: I'd like to start on a more fundamental level.  Are we preparing for war with GnuPG or do we still believe we can still negotiate with GnuPG.

Aron: I tried to talk to Werner.  His response was: Maybe we can find ways to avoid code point concflicts, but did not seem to be willing to compromise on anything even agreeing on the PQC algorithms behaving similarly.

Holger K.: Delta Chat's position is that we are moving to v6 very soon.  We will have v6 in the summer, and we roll it out soon.  I don't want to talk about GnuPG.  I want to think about collaboration, and working together.

Kai: I have tried very hard to talk to Werner and give him little straws to grab on to.  Werner appears to be unwilling.  He appears very angry.  I don't think that Werner will do anything that we ask him to do.

Bernd: I think all these discussions with Werner have happened between us, and not really in the public.  I would not give up with at least trying to get Werner to commit to his ideas in a more open way.  Perhaps in the context of a conference organized by a neutral third party.  He needs to understand that it is not only about him and the whole world against him.

Andrew: This is fundamentally a political issue.  I have done everything that I can on the list.  I have tried to engage with him on the list.  I gave him an I-D to address the specific issues that he raised (in particular the literal data packet metadata in v6).  There was no traction at all.  He said: don't bother.  Even though this is something that he specified for v4 in the librepgp draft.  I don't see anything else that I can do.  I don't believe that there is anything that can be done technically to bring Werner back to the table.  It is fundamentally about power.

Bart: I made an offer: if we drop GCM, what would that buy us?  Even though that was one of Werner's main gripes, he didn't respond at all.  I object with the characterization that we are going to war with GnuPG.  My preferred path forward is to stop being a hostage to Werner.  We should work together.  I don't think that we can convince Werner.  I think there will be GnuPG for a while, and that will just not be interoperable.  For me, I think we are going to support reading Werner's OCB packet, but we are not going to signal support for reading it.  And we are not going to recognize v5 signatures, etc.

Daniel H.: I want to make a distinction between Werner and GnuPG.  They are very interlinked.  However, Niibe has been very active on the crypto-refresh, and is a co-author, and he works on GnuPG.  My understanding is that he is open to implementing it, if it became politically possible.  Relatedly, we have a GnuPG packager from Debian here (dkg).  Some distributions have patched out the LibrePGP stuff \[Andrew: including Arch\].  As a potential path if we want to keep GnuPG on board would be to convince Niibe to implement the crypto-refresh and then get the distributions to ship that version, if Werner is unwilling to include it.  So, perhaps we have hope of convincing GnuPG even if we can't convince Werner.

Aron: This would force the schism inside GnuPG.

Kai: Perhaps war is not the right word.  We see unwillingness to negociate from the GnuPG side.  Holger said introducing something that is incompatible.  That is actively trying to push the competition forward.  My question: did Werner already do that?  If we go that way, can we predict who will win?

Andrew: GnuPG already did that: they generate v5 subkeys without warning the user.  So that line has been crossed.

Holger K.: The strategy that we and the rPGP developers have discussed is compatibility for our users, and compatible with other players in email encryption do.  And frankly, there is no issue using GnuPG.  Compatability is not very important to us.  Compatibility with Thunderbird and Proton is much more important.  I'm sad that this is the case, but it is not practically for us.

Kai: A consequence is that you would be incompatible with KMail, Evolution, and mutt.

Patrick: The question is: are those the most relevant tools.  And there is a Sequoia replacement of gpg (Chameleon), which users could use to be compatible with v6.

Kai: We should note that this is a possible way forward.

Patrick: If these tools want to be compatible with GnuPG, then they could use this.

Holger K.: Regarding war.  Perhaps we should come to a joint statement on compatibility around v6.  And then just state this.  We are not being hostage.  We remain open to talk.  This is not a war.  This is not being hostage.

Patrick: This is not a war, we are just ignoring what GnuPG does.

Bart: We can split it off.  GnuPG may see any overtures to Evolution as war.  But I think it can be justified as an effort to not fragment the ecosystem.

Bernd: I agree and we have our own history with Werner.  The BSI has a commitment to OpenPGP on their website.  Is that leverage?  Will BSI switch to LibrePGP?

Patrick: BSI discussed this issue internally, and they will support both standards for the time being.

Bart: If the ecosystem looks like it is moving away from GnuPG, then perhaps it will put pressure on the BSI to reconsider this position.  We are moving on.  This is not war.

Kai: I want to come back to the issues.  The first is: issue that some artifacts can't be read.  Second is: group conversations.  Some people have said implement both.  Some people have said only implement v6.  That is a question we should answer.

Justus: My observation dealing with other OpenPGP implementations is that people didn't read the spec, but implemented whatever GnuPG accepted.  So, if -for example- OpenPGP.js is able to consume v5 artifacts, people will interpret that as a sign that producing them is okay.  Perhaps we need to say no.

dkg: I want to point out that there are signalling mechanisms in OpenPGP that can be used.

Andrew: I think it might be useful to draw a line collectively today.  We might disagree on what we will support, but I think it would be useful if we agreed on what we will definitely not support. For example not supporting LibrePGP-PQC would be my preference.  Regarding whether we handle LibrePGP signatures that is another question.

dkg: We have a lot to do with the v4/v6 transition.  That's already a lot of work.

Bart: Do we have enough consensus for v4/v6 transition that we largely try to keep GnuPG out of it?  I worry that without having some agreement we'll inject v5 into every discussion.  I think we should just rule that out of the discussions for now.

Kai: This is a competition.  We should allow that v5 might win.

Stephan: As a MUA, I'm just consuming libraries.  But from my point of view, if you don't stick to some standardization, and only because some application has a market share, does not mean they should dictate the features.  If we have an RFC, but don't stick to this, why do we allow this.

## Session #2a: PQC in v4 session

Note taker: Falko

Aron: Some people for some against.

Kai: still undecided?

Aron: decided ist that we allow v1 SEIPD with PQC encryption, but open is whether we allow v4 PQC encryption keys.
There are interop issues since some implementations choke on unknown algorithms.
Want to touch also v5 PQC.
Has similar algorithms but with generic algorithm combinations. Algorithms can be reused by key derivation is and packet format is different between the two. On the list there were strong opinions about combining PQC with v4 keys.

Andrew: Werner bound it to v5 and things that v4 PQC is not needed. v5 subkeys to v4 primary keys are allowed in LibrePGP.

Bart: There is not going to be any alignment between v4 and v5 PQC code points.

Aron: Unclear whether there is a conflict as the algorithm together with the key version is still unambiguous.

Andrew: v3 PKESK would contain both key version's algorithm IDs but with the knowledge of the key there would not be any lack of information.

Andrew: Pro for v4 PQC is that it is less work to implement.

Bart: Nickolay, would v4 PQC make it sufficiently easier for RNP to get PQC encryption out of the door?

Johannes: There are some minor points  / details of v6 that are not yet implemented in RNP.

Kai: would you implement v4 PQC as specified by the IETF?

Nickolay: would not implement something experimental by default?

Bart: It would be more work for us to implement v4 PQC since we have v6 already.

Kai: The question is whether the application is ready to use v6 keys. I have not made the decision whether to support v6 keys.

Bart: Benefit of v4 PQC encryption keys seems only to benefit RNP, is that correct?

Kai: Is RNP willing to implement v6 IETF?

Nickolay: Once it is widely used we will have to support it. Currently we have a lot of v5 artifacts. My opinion is to support everything and let the user choose.

Kai: Will RNP also support v5 PQC?

Nickolay: yes

Andrew: Argument for v4 PQC is speed. Since no defined migration path to v6, giving users the opportunity to use PQC with makes deployment of PQC easier.

Kai: This means quicker time to market.

Andrew: It won't give you PQC signatures but encryption.
Encryption is more important now.Bart: My concern with Proton hat on is that if we were to do v4 PQC I will not any budget for v6.
There will be only one shot at this.
Second thing is if v6 is mostly done. My worry is that Crypto-Refresh will be dead then.

Justus: It is also about regulartory requirements. Binding PQC to v6 is an incentive for v6.

Kai: it means that if we bind it to v6 it will behind v5 PQC keys.

Bart: Me saying tying PQC to v6 doesn't mean that we don't roll out v6 beforehand. If v6 is more or less done, the main question of speed is whether we ship PQC before the draft is finalized.

Kai: We need to bring a new format into market, introducing a v4 PQC subkey would be simpler than implementing v6.

Andrew: If we had a new distribution system that serves both v4 and v6 keys for the same user, would that be a solution?

Kai: which side do you consider more fragile?

Andrew: the v4 PQC subkey would be more fragile than shipping a v6 PQC key.

Kai: I have not seen this possibility of attaching two keys in one block.

Kai: Autocrypt there can be at most one subkey.

Falko: SLH-DSA keys are too large for mailserver field restrictions

Falko: All such deployments of new technologies will take time.

Aron: Amount of customer tickets for broken encryption is huge already at a 1% error rate. Slower rollout might be more robust.

Bart: Proton would support v6 and all the key servers would serve v4 as the default and v6 only if the caller required it. Does that mean complexity on the side of the callers? I don't expect so.

Andrew: OpenSSH PQC support: If you didn't updrade your client you won't be able to login. Not every person who has an OpenPGP key will also upgrade to v6.

Kai: with v4 PQC I can provide PQC to my users soon. Otherwise no guarantee.

Bart: From Proton's side I think we can ship PQC with v6 as fast as PQC with v4.

Bernd: v4 PQC not being standardized.

Aron: It will be standardized, only that the PQC draft might take longer.

Johannes: From the standard perspective it is not natural to forbid an algorithm.

Bart: It's a combinatoric problem. The question is what you are buying with that complexity. OpenPGP has traditionally allowed more than it should.

Aron: for instance we disallow v3 keys.

Falko: maybe delay the decision until the deployment of v6 is more clear.

Bart: I don't like to postpone the decision.

## Session #2b: Header Protection

Draft: [draft-ietf-lamps-header-protection](https://datatracker.ietf.org/doc/html/draft-ietf-lamps-header-protection)

dkg: Intro and overview of the scheme proposed by the draft.

...: draft is generic to OpenPGP and S/MIME

...: defines MIME structure of a message with header protection

...: copy all the headers into the signed (and potentially encrypted) message

...: minimal Header Confidentiality Policy (HCP) we want for encrypted messages: replace the Subject header with \[...\]

...: for encrypted messages: copy outer headers prefixed with "HP-Outer: " into protected section, to know whether a given header was confidential or not

...: when replying to an encrypted message, avoid leaking headers that were confidential

Daniel H.: does the spec require preserving confidentiality for any given header in replies?

dkg: the draft gives guidance but no strict requirements \[afaiu - note taker\]

...: Problem: how can users of Legacy MUAs still read, e.g., the Subject if the outer Subject is "\[...\]"? Solution: Legacy Display Element to copy the Subject (and other obscured user-facing headers) into the text/plain and text/html body parts. This is optional, but expected to be necessary initially. Other approaches (like separate MIME parts) did not well work with Outlook.

Holger K.: looks fairly complex

dkg: yes, more complex than I'd like it to be, legacy email is a mess

dkg: Walks through the example in Appendix C.

Holger K.: this is not really workable for us

Aleksandr: it's compressed

Neal: is the order of headers defined, or does it matter? Compression is more efficient if the duplicate headers are close together.

Aleksandr: the order matters, someone might add a header, affects DKIM signing

dkg: As far as the draft is concerned, the order does NOT matter. I would be interested to hear of applications where it matters.

Patrick: do we need both the HP-Outer headers and "normal" headers if they are identical?

dkg: We went through different approaches of removing/obscuring/copying headers to the outside, and the HP-Outer is the "KISS" scheme we settled on.

...: The long-term goal is to remove all headers from the outside. Then you don't have duplicated/triplicated headers anymore.

Daniel H.: crypto refresh discourages compression, so that might not be the best solution if the overhead is relevant

dkg: it's not actually that big, but for DeltaChat's use case it might matter indeed

Patrick: we could optimize by saying "equal"

Stefan: If you have a signed and then encrypted structure, where should I put the protected headers?

dkg: root of the cryptographic payload, inside all cryptographic layers

Sylvester: what if you have headers on different layers?

dkg: only look at the cryptographic payload, ignore headers on other layers

...: other MIME structures / errant cryptographic layers are out of scope

dkg: Explains how replies work with the draft.

...: if the MUA understands the encrypted subject but doesn't encrypt it (i.e. understands HP but chooses hp\_no\_confidentiality), there's a risk of leaking the encrypted subject when replying.

...: in that case, the MUA should construct a response using the HP-Outer headers and using the protect headers (both using the default HCP)

...: if they differ, use the one from the outer

Holger K.: why not just say that the MUA is not allowed to use hcp\_no\_confidentiality in that case?

dkg: this also works for a more advanced HCP and different headers. We are using hcp\_no\_confidentiality and Subject as a toy example.

Aleksandr: how would it work if you move a recipient from To to CC

dkg: try the algorithm, it should work

Thore: the respond() algorithm handles the magic of values \*\*the reply action\*\* moving between header fields (From -> To, Message-ID -> In-Reply-To). If the sender manually moves the recipient, or edits the subject line, etc. then this is \*\*not\*\* captured by the algorithm and the value will leak. This is a design decision we currently have, but ideas are welcome.

## Section #3a: Forward Compatibility

Lead: dkg

Note-takers: Neal and Daniel H.

dkg: What do we do with things that aren't yet specified?  (Not the things that are specified and not yet implemented.)  What kind of interactions are possible?  What if you collect a series of packets and the packets don't conform to the grammer.  Do you thow packets away until we get a version that is compatible?  Things to think about: algorithms, packet types, criticality (subpackets), signature types, signature version number, key version, PKESK / SKESK version, certificates generally (binding signatures, subpackets in signatures that bind the subkeys).  Perhaps there is a higher-level thing that we are interested in.  Currently, we have two grammars: messages, and certificates.

Kai: do we need to differentiate between primary key and subkeys?

dkg: if it's an unknown primary key version you can't use the certificate at all, but unknown subkey versions you could potentially handle
...: we should think more generally about the grammars we're interested in
...: main ones: certificates and messages

dkg: Let's consider certificates.  When I collect a certificate and there are two certificates, what do we do? Do we handle each individually? Do we require everything to be valid?

Kai: Example: you get a keyring with two certificates.  If one is not valid, do we reject everything or only the one we don't understand.

Daniel H.: There is another option: we only ever take the first that you like and ignore the rest.

Patrick: You could take any certificate that you like.

dkg: In any case: don't skip the whole certificate block if one of the certificates is valid.

dkg: There are some attacks, like zip bombs and quines.  So we can't be naive about parsing.

dkg: What might cause you to reject a certificate?

dkg: What if get a version we don't understand, we ignore it?

Neal: We can still store it.

Holger K.: It depends whether we would store certificates that we don't understand.  If it is a v17 key, then it is clearly wrong.  So we would ignore it.

dkg: Are there other actions we should be thinking about, besides storing? Encrypting, verifying?

Kai: If it is an application decision, it is hard for the library to make a decision.

Patrick: It has to return the information to the caller for the application to be able to handle it

Kai: Perhaps libraries should have an inspect API that allows them to examine the certificates and decide what to do.

dkg: I think we want something much simpler. E.g.: an API that tells you: can I encrypt with this key, can I verify (in general, or one specific signature), etc.

Holger: We are interested in v4 and v6, but not v17.  So we will start storing v6 certificates, even though we don't implement v6 yet, because we will soon.  v7 we'll drop, because we don't know anything about it.

Nickolay: In situations where you don't know how to parse packets, it should either return an error or ignore it.  There are only two things that make sense.

dkg: If there is an algorithm that you haven't heard of, does that mean you would reject the whole certificate?

Nickolay: Yes, because you don't know how to use the key.  And this would make the applications more complicated.

Daniel H.: That might make sense with secret keys, as the user might not be cause to decrypt some messages.  But, for certificates you can still use part of them.

Patrick: so it depends on the use case

dkg: Perhaps we should unpack this "store" use case. What is the final goal?

...: If the action is store, you might want to know which actions are possible.

dkg: Kai, what does Thunderbird really need to know.  Not you as an OpenPGP nerd, but what information does Thunderbird need?

Kai: I need to know: can I encrypt to it, can it be used for verification. I could also encrypt if it's only for one of those use cases.

dkg: What about if it's only for verifying certifications?

Kai: probably I would require at least certification and revocation

dkg: all keys with a usable primary key should have that

Neal: if you refuse to import something, you can't later tell the user that there's an unusable certificate

...: if I type an email address, I want to be able to distinguish whether there's no key or an unusable key

Kai: If a user intends for a certificate to be used for signing (there is a subkey with the signing-capability), but I don't understand any signing-capable subkeys, then I should reject it.

...: Similarly if there are subkeys for encryption but I don't understand any of them.

Daniel H.: It's not clear to me that the capabilities signal intent.  It's up to the applications to say what they intend.

dkg: There are a range of uses for a certificate.  If you know you want something that can be used for encryption, then it makes sense to discard the certificate if it can't be used for encryption.

Daniel H.: So perhaps you should consider when storing what you want to use the key for later.

dkg: Just because you know today that the certificate is usable for encryption doesn't mean that it will be usable in a year.

Daniel H.: So perhaps we should store everything.

Kai: We should identify the things that are not harmful to implementations and then we should say that all implementations should tolerate those things.

dkg: From a sop perspetive, there is something that we want to do, and we can only do that.  So the intent is clear.

dkg: Do you have an example of what we should reject / consider harmful?

Kai: rnp rejects certain things

dkg: rnp has a flag to allow importing unknown stuff

Kai: But are applications comfortable with that?

Nickolay: if there's an unknown signature subpacket, we should reject it because we don't know what it's intended to do

dkg: There's a criticality flag. Implementers don't need to decide that, the producer should signal that.

Neal: The only risk I know of is flooding the certificate store with junk

...: disk usage and CPU cost

Kai: we shouldn't show unknown things to the user and confuse them

dkg: Can be done at the UI layer

Neal: going back: we should distinguish between no certificate and unknown certificate, to be able to debug problems

Kai: perhaps we need an import API in RNP to say: import this certificate if it's usable for usages X, Y, Z

dkg: or a capability querying API

Nickolay: I could add another flag to allow unparseable packets

Kai: do we agree it's fine for a low-level library to be restrictive, or should it accept everything

dkg: If you don't know exactly what you want, because you are a low-level API, then it's hard to filter.

Nickolay: If RNP encounters a signature that it can't parse, then it rejects just that packet, not the whole certificate.

...: But only if the permissive flag is enabled.

...: By default (if the permissive flag is missing), if one packet fails to be parsed, we reject the entire certificate.

## Section #3b: HKP + WKD

Andrew: Recap of draft status changes, recent changes to the old draft:

- Introducing SKS verbs/paths
- Organize variables vs options
- Allow detached revocations
- v=1 versioning
- Key version in MR output
- MUST ignore unknown fields
- CORS is a MUST

Bart: Why not require HTTPS?

Andrew: To keep the layer separation

Bart: there is no reason not to require HTTPS

Justus: Tor. Hidden services. Hard to get public certs.

Bart: maybe require a generic "encrypted" connection (HTTPS, Hidden service, whatever).

Justus: What's the split machine/human readable?

Andrew: We focus on the machine readable, and leave the human readable as legacy.

Justus: Why not start from a clean sheet?

Andrew: requires reimplementation.

Bart: API versioning is in the path in modern APIs, not in the query parameter. Consider doing that in the draft, then you have more flexibility to change stuff in the future.

Justus: do you plan to keep LIST and SEARCH?

Andrew: Currently yes? Maybe limit SEARCH to user ids, fingerprints (instead of full text search).

Bart: Many things in the spec have aged out of tech?

Andrew: Shall we document what's being done now, since there is no official documentation?

Bart: Do we need 2 separate HTTP APIs to serve keys?

Aron: some users like WKD because they can just put a few files onto a webserver (as much as it is a pain for Proton). So maybe worth keeping as an option. And add a link to well-known (or DNS) that delegates to an HKP server.

Aron: WKD creates a tooling problem with setting up the correct filenames

Bart: is there any advantage not setting up hockeypuck instead of dropping files in a server? Maybe running up a container on AWS is as easy as hosting a file system?

Thore: I use Gitlab Pages to host the WKD alongside my blog. So I find the file system approach convenient ("direct method") because it took 2 minutes to set up with my existing "infra".

Bart: do we just want to design a new API, given that v6 keys are a good opportunity?

Aron: if we use paths, we are compatible with a FS-only solution

Andrew: what about lenght limit and internationalized domains?

Aron: anyone can just fall back to a full HKP implementation, and the FS solution would just be a simplification

Bart: Keeping the API will make the transition easier

Andrew: We could keep the current API as is, and then design a more REST-ful API for the new version, not too far away from it

Andrew: old SKS did request rewriting in Apache for backwards compatibility with the even older PKS. Maybe we can do the same now for this transition?

Justus: This is what Hagrid does between hkp and vks

Bart: I prefer easy adoptability. People will adopt it faster if the API is the same.

Aron: If we put stuff in the path that's a small change, and allows FS systems

Bart: There are only so many things that you can put into the path

Andrew: version tagged fingerprint 1st byte = version + fingerprint -> encoded in b64 urlsafe

Justus: why not hex?

Bart: why not make the version a separate parameter?

Bart: How do we ensure v4 lookup is not broken?

Andrew: when using v1 paths the client is required to not choke on unknown keys, and when not specifying v1 we return only v4

Bart: what about v5?

Andrew: we could decide to return them if gopenpgp can parse them

Stefan: Do I need to setup a WKD policy file just for people to find my HKP server?

Bart: Not needed, we can handle it the modern way: put a DNS record and turn on DNSSEC. Maybe use a DoH gateway that you trust.

Andrew: You can use trusted key servers to look up the keys for you, and this gives you additional privacy. Maybe some form of recursive and authoritative key servers (like DNS)?

Thore: for privacy, you can use proxying (like Oblivious HTTP, or like Proton apps call the Proton server over a custom API). It feels a bit overkill to specify recursive key lookups just for caching.

Decisions:

- Have versioned API in the path
- Keep the changes as minimal to keep the upgrade path as easy as possible
- In V1 many more MUSTs, no legacy compatibility arguments
- WKD will offer a redirection in the policy file to HKP
- Offer a HKP advertising method via DNS

(Hagrids "REST" interface: [https://keys.openpgp.org/about/api](https://keys.openpgp.org/about/api))

## Section 4: Key Distribution Methods

Different key distribution methods:

- HKP
- WKD
- Autocrypt
- "Secure Join"

Ecosystem complexity has a cost.

in-band vs. out-of-band

how do the multiple methods interact?

Overall requirements:

*   avoid metadata leaks
*   deal with constrained network environments
*   avoid SPOF / decentralization
*   zero round trip
*   independent of domain operator
*   cert freshness (avoid FailToDecrypt (FTD) due to wrong key) (permit opting out)
*   we want delegating publication to be easy but not required
*   integrity / abuse resistance for transit
*   minimal work for the user

Bart:

*   avoid keys-in-attachments - they are messy and we don't know how to deal with them cleanly
*   something like autocrypt seems necessary; would be nice for Autocrypt to be able to delegate to a network lookup

Andrew: separate these concepts

  discovery: where do i look this up?

  lookup: how can i get the certificate?  (lookups by e-mail address or by fingerprint?)



|                                                | autocrypt | attachment  | embedded certificate subpacket | URL header | "HKP over email" | HKPS        | WKD         | DANE          | Tor/OHTTP+HKP |
|------------------------------------------------|-----------|-------------|--------------------------------|------------|------------------|-------------|-------------|---------------|---------------|
| transport method                               | inband    | inband      | inband                         | inband     | inband           | out of band | out of band | out of band   | out of band   |
| no leakage                                     | ✓         | ✓           | ✓                              |            |                  |             |             |               | ✓             |
| constrained network                            | ✓         | ✓           | ✓                              |            | ✓                |             |             |               |               |
| no SPOF                                        | ✓         | ✓           | ✓                              |            | ✓                | ?           | ✓           | ✓             | ?             |
| zero roundtrip                                 | ?         |             |                                |            | ✓                | ✓           | ✓           | ✓             | ✓             |
| independent of domain operator<br type="_moz"> | ✓         | ✓           | ✓                              | ✓          | ✓                | ✓           |             |               | ✓             |
| freshness                                      |           |             |                                | ✓          | ✓                | ✓           | ✓           | ✓             | ✓             |
| freshness for opt out                          | ?         |             |                                | ✓          | ✓                | ✓           | ✓           | ✓             | ✓             |
| easy delegation                                |           |             |                                |            |                  |             | ?           | ✓             |               |
| integrity in transit                           |           | ✓ (if DKIM) | ✓ (if DKIM)                    |            | ✓ (if DKIM)      | ✓           | ✓           | ✓ (if DNSSEC) | ✓             |
| minimal work for user                          | ✓         |             | ✓                              | ✓          | ✓                | ✓           | ✓           | ✓             | ✓             |

## Session 5: v4 to v6 migration - Kai

Worries: having to manage both v4 and v6 keys, and interop issues in groups

Solution?: link the v4 key to the v6 key, present them as a pair

MUA could generate v6 key for you and link it

In migration phase, MUA could refuse v6 keys by itself, and require v4+v6

If there's a conversation where everyone has v6 keys, use v6

If one participant only has v4, fall back to v4

If someone adds a participant who only has a v4 key, fall back to v4 keys for everyone;

needs a pointer from the v6 key to the v4 key for everyone

Andrew: this is very close to what the replacementkey draft proposes

Neal: OpenPGP can already do this with a binding signature

Aron: the mechanism that's missing is key superseded without revoked

Bart: the important part is pointing to the fallback key, rather than pointing to the replacement key

Kai: need bidirectional binding

dkg: if we bind two primary keys together, should that work between any keys? or only v4-v6?

...: If we're sending to a group, and using v4/v6, are we talking about encryption or signing?

Aron: it shouldn't be specific to v4-v6, should also work to migrate to PQC, e.g.

Andrew: it should be generic

dkg: we shouldn't give users enough rope to hang themselves

Aron: we shouldn't put v6 certifications on v4 keys

Andrew: the way the current draft says to do it is to put a replacement key subpacket on a self-signature on the v4 key

...: the new key would have a certification by the old key, with a embedded signature subpacket by the new key

Bart: do you need the backsig? is it dangerous

Andrew: for bidirectional we need two signatures

Bart: but they could be independent

dkg: what are the properties we need?

Andrew: it should be (cryptographically, UX, etc) equivalent to a signing subkey binding

dkg: Should they have matching User IDs?

Andrew: for email yes, other use cases no

Patrick: for Autocrypt no

dkg: Autocrypt says that User IDs are decorative

Kai: Thunderbird should only accept the binding if they have identical User IDs

dkg: what about multiple UIDs?

Kai: if they have at least one matching User ID it's fine

Bart: perhaps if they both have the email address that I'm about to use

Neal: if I get a business card with a fingerprint and a user ID, to both keys, then I don't need a cross-binding

Kai: true, but could be confusing if one of the keys doesn't have the email

Aron: v6 keys can have no User IDs

Neal: In Sequoia self-signed UIDs are meaningless, we only care about third-party certifications

dkg: no consensus on UID requirement

Neal: \[for self-signed UIDs\]

Patrick: whether UIDs matter depends on the use case

Aron: we have a use case for catch-all addresses, or aliases/variants of an address; if you import a key with a (slightly) different email address in the UID, we warn the user about it but still let them. Could be a SHOULD or MAY but not a MUST require identical UID

Andrew: should consider the case where only one key is available; don't want to rely on this to get a valid UID binding to the new key

dkg: If I'm installing a secret key in my MUA, and it points to another certificate for which I don't have the private key material, should the MUA complain?

Neal: what if one key is revoked, does it break the binding?

Aron: if the v4 key is revoked or expired, the binding should be ignored

dkg: in general, if one of the keys is revoked or expired, the binding should be ignored

Patrick: the binding is just informational, other than that the keys are independent

dkg: we do need to specify the semantics of the binding

Andrew: semantics should be: one can be used in place of the other

Kai: we can inform the user if the binding is broken

...: If I import a v4 secret key but not v6 secret key, there's no linkage

dkg: But the senders might think there's a linkage

Daniel: this is a general problem to migrations, not specific to such a binding

Bart: if you're doing Autocrypt gossip, you could create third-party User ID certifications so that you don't reqiure self-signed UIDs

Andrew: if you lose the v4 primary key, we should make sure the binding can be revoked unilaterally

dkg: if the binding is bidirectional, both parties should be able to revoke it

Andrew: with the current structure, there's no obvious way for the embedded signature to be revoked

Kai: I'm imagining a signature subpacket in the v6 key that says, here's my replacement key

dkg: let's focus on the properties we want rather than the specific mechanism

Bart: we might want only v4->v6, not bidirectional

Andrew: if I can bind your key, I can claim that your signature was created by me

\[discussion on preference and ordering\]

Andrew: there's currently already a directionality

Daniel: if we care about the threat of claiming someone else's key and signature, we need self-signed UIDs

Aron: can we make the ordering implicit

dkg: yes

dkg: what about chained migrations; what should people do if there's multiple

Aron: you should be able to make a chain but not a tree

dkg: can I make a loop?

Aron: if you lose the last key you're stuck

Stefan: you could replace the binding with a different one

Neal: certificates are append-only

Stefan: later self-signature should replace it

dkg: do we need chains?

Justus: I think we need trees or chains to support v4->v6->v6pqc

Aron: chain is better than tree

Justus: what if you have A->B->C and the implementation doesn't support B

Aron: then you use A

dkg: we should write down clearly the properties we want and what the UX should be

Daniel: if you want to prevent loops you could require that the new key has a later creation time than the old one

### Group 0:

- Link 2 keys

- Consent: both parties have to agree

- Direction (explicit)

- Revocable by either party

- Discoverable in both directions

- Each key has: nothing XOR 1 new key (preferred) XOR n old keys (fallback)

- I.e. no chains, no trees, no loops.

- A new binding pointing away from a key invalidates all bindings pointing towards it.

- Web of Trust can traverse the bindings bidirectional

- Directionality == preference.

- Can have a (v4, v6) binding where v4 is preferred (for now). Can "update" it to prefer v6 by revocing the binding and issuing a new one with inverted direction.

- I.e. preference is independent of key creation timestamp.

### Group 1:

- As transparent to users as using subkeys

- As secure as subkeys

- It should be possible to infer a preference

    Neal: should not be tied to this

    Andrew: we could implement two mechanisms that could be used together or separately

- Following the linkage is optional, and if the linkage is broken, ignore it

- Allow chains but not trees

- Require newer creation time

## User Agent Migration: Sender/Producer Side

Preconditions:

- The current UA can handle the new stuff

- The current UA is reasonable sure that all other UAs who you are sharing secret keys with can handle the new stuff

Migration Steps:

1\. Generate a new key

2\. Link old key (fallback) and new key (preferred) together (with updated preferences)

3\. Publish both keys

Signing: sign with both, fallback key first

Bailout (abort the migration):

- Revoke the preferred new key

Cleanup (fully migrate to the new key):

1\. Revoke fallback key

2\. Republish fallback key

3\. SHOULD destroy signing / auth / .. fallback secret key material

4\. (soft) revoke link in prefered key

5\. republish preferred key

## User Agent Migration: Receiver/Consumer Side

Steps:

1\. Alice has a cert for Bob

2\. Alice finds an update for Bob (finds a new linkage)

3\. If you cannot verify the linkage (e.g., cannot fetch the new key, etc): ignore the new linkage

4\. If you can verify the linkage:

  - Encrypt to preferred key first. If not possible, encrypt to fallback key (in order of fallback key preference).

  - Algorithm selection: use the preference of the cert that you are using (preferred cert vs fallback cert)

## Retrospective

Patrick: was this weekend useful? Was this venue ok? Or somewhere else?

Justus: need better uplink.

Bart: Frankfurt is well connected, convenient to come to from everywhere.

Neal+Stefan: prefer one or two weeks earlier, end of May.

Aron: avoid long/extended weekends, people already take fun holidays there.

Patrick: maybe April or June are better?

Thank you Patrick for organising the Hotel, Kai for organising the local stuff (restaurants), Wau Holland Stiftung for funding.

Where to put the meeting notes (that were taken on Cryptpad)? Copy them over to GnuPG wiki? Mirror them to openpgp.org? Patrick will do it.

Do we want to do a virtual interim meeting? dkg to take an action item to schedule it in the IETF context. An i³ (implementers' interoperability interim). Some time in December.

Can we improve the experience for remote participants? Better microphone for the entire room. Live transcription?

## Mechanism of key migration

Andrew: recap of requirements

...: current draft fulfills part of the requirements, repo state fulfills the rest

Andrew: current draft: replacement key subpacket

...: points to preferred key, but is non authorative since it signs the fingerprint instead of the key, so we also need the other part

    Neal: why?

    dkg: we also need the other part because of bidirectionality

Andrew: in the repo: key equivalence binding signature

...: direct signature packet by the fallback primary key over the preferred key, with a critical issuer fingerprint subpacket, + an embedded signature with a new signature type, equivalent to a primary key binding signature (in a subkey binding signature), placed on the primary key of the preferred key

dkg: might be an issue to embed large signatures (e.g. SLH-DSA)

dkg: should be a separate signature type from direct key signature, doesn't matter if an implementation chokes on the preferred key, they can use the fallback key

Neal: one signature type per purpose is easiest

dkg: embedded signature subpacket needs to be hashed

Andrew: what other kind of statements would you need to make in a direct key signatures

...: the key equivalence should emcompass everything else

...: reusing the signature type makes it easier to distribute

dkg: but it shouldn't matter for new key types

## Multi-Step Migration

Problem statement: how do multiple migrations work? E.g. v4 -> v6 and then v6 -> v6 PQC. How do we ship the second migration?

Proton: probably not migrate to v6 until PQC lands and only migrate once to v6 with PQC sign and enc. I.e. don't do multi-step as a producer. But still relevant as a consumer.

DeltaChat: not super interested in PQC

User Agent Migration (n-th):

- Precondition: Have secret key of already linked key (and all other keys which should be linked to new one) that will be new "fallback" key(s) and is now "prefered" key

1\. Gernerate a new key

2\. Should sync preference between all keys I want to link

3\. invalidate existing links on all new "fallback" key (revocation)

4\. one fallback binding with (multi) fallback keys (order matters for signing)

5\. publish all keys

Should sign with all fallback keys in order of appereance in link

User Agent Cleanup:

same as first migration

Bailout:

- reprefer first priority fallback key (first in order)

- revoke prefered key

## Automatic encryption to published keys (Daniel H)

Proton enabled lookup of keys on KOO to automatically encrypt to people who have published keys, but this generated complaints and bad press. Expectation mismatch re what uploading a key to a keyserver actually means. Does this mean that MUAs may automatically encrypt without user intervention, or whether the sender should have to manually enable encryption for the key owner?

What heuristics can we use as a mail provider? Or should the key owner have to make a statement? Do we agree among ourselves what KOO is for?

dkg: just publishing a policy statement on KOO may not be enough because people who already uploaded keys can not have meaningfully consented

DH: we don't have a button for senders to decide whether to send encrypted email

dkg: maximum acceptable change to user interface is an "Encrypt" button that defaults to on or off according to context. I want the default to eventually be encrypt where possible but the sender should have the ultimate choice.

DH: I want to get to the point where we can encrypt by default. If there is something we can do on KOO I would be very interested.

JW: we could all implement Autocrypt and then there is an existing signalling mechanism we can use

HK: problem is stale keys on server, particularly if key material is lost. We could require that key owners regularly update their published keys. When we (DeltaChat) see a signed message we infer freshness from it.

NW: there are many people who upload keys with encryption subkeys who don't intend to regularly use encrypted mail, maybe only for sensitive mails.

DH: we may need both explicit signalling and freshness heuristics. Signalling should be at the application layer.

dkg: KOO could send periodic reminders to the key owner requiring them to regularly reconfirm their opt-in

abg: am wary of loading even more authority onto KOO when we should be reducing its criticality to the ecosystem

kai: I would like to use thunderbird to regularly publish a statement stating my acceptance of automatically encrypted mail. If a user has configured their account in thunderbird to use openpgp, they should expect to receive encrypted mail. They may also want to separately enable encrypted subjects.

dh: a user may want their MUA to handle all the signalling transparently

kai: I think it's not a big deal to encrypt by default so long as key owners can easily turn it off

ss: do I need to wait for a signalling roundtrip before enabling encryption to a key owner?

dkg: lack of signalling only indicates that we should not automatically encrypt, not that encryption should not be possible manually

kai: there is a difference in scale between individuals using native clients and a large service such as proton, which may need different heuristics. Question is, under which conditions would i as a key owner be comfortable uploading this signalling to KOO?

JW: an owner-uploading solution may be useful for TB but is not a universal solution for all users

dkg: fears that an active probe from KOO may result in blacklisting

NW: I don't see a problem with doing this in an openpgp artifact

kai: a missing key on a keyserver is not a sufficient indication of anything

ss: if we want signalling I believe it should be in the certificate, and no signal means no automatic encryption

JW: so we don't get widespread automatic encryption until all clients support explicit signalling?

ss: in thunderbird it is always possible for a sender to manually disable encryption

NW: I want a new signature type containing a short expiry that indicates freshness and preferences, which is not a normal self signature so it can be garbage collected without side effects. Software can make decision to signal depending on user's recent local behaviour.

dkg: in the KOO spamming model, KOO cannot actually prove anything, just make an assertion

bernd: if people don't want to receive encrypted email, remove the key from the keyserver, rtfm!

pb: why not ask the user when uploading? And for historic users, they can reupload.

Session closed without conclusion.

## Autocrypt 2.0 - Holger K.

Patrick: I would like to find out how to start the process of Autocrypt 2.0, rather than talk about content

Holger K.: I would like to close the issues on the tracker ([https://github.com/autocrypt/autocrypt](https://github.com/autocrypt/autocrypt)), to have a clean slate

Patrick: should we restart the group?

Holger K.: let's talk about topics

...: adding a reference for a network fetch into Autocrypt header

...: could help with freshness and large keys (PQC)

...: and multiple keys

Kai: keep primary key and subkey restraint?

dkg: other big thing would be multi-MUA coordination (device sync)

Daniel H.: should that be part of Autocrypt?

dkg: it already is

Patrick: who's interested?

...: Proton is interested?

Daniel H.: yes

dkg: I'm interested

hpk: we want to identify how can we asymmetrically integrate WKD with Autocrypt, e.g. have a reference in the Autocrypt header

Justus: can provide feedback

Holger K.: what are the next steps?

Kai: what are the goals?
Holger K.: in order to proceed, let's discuss at least one topic \[instead of listing more topics\]

### Reference for a network fetch

dkg: reference can be used as a web bug (to check if recipient opened the mail). I don't want to create a new one.

?: could use oblivious HTTP

Aleksandr: header size shouldn't be an issue inside the cryptographically protected layer

Justus: or split up the headers

dkg: so we don't need the reference

Holger K.: we still need it for freshness

dkg: OpenPGP already has a preferred OpenPGP key server subpacket

Daniel H.: other reason could be multiple keys

Patrick: could allow multiple headers

dkg: current spec says multiple headers is invalid, clients would reject it. so we should call the header Autocrypt-2

Patrick: or we move it into the cryptographically protected layer, then we can put multiple

Holger:

dkg: could also do refresh by fingerprints

Daniel H.: that only works for updates to the key, not for new keys

dkg: have we tested large headers?

Holger: we could do it only for encrypted messages

dkg: what about legacy clients

Holger: header size constraints usually come from MTAs, not MUAs

Aleksandr: some MUAs also have issues with very large MIME headers

dkg: I can make some tests

Holger: so we don't introduce a new fetching mechanism?

dkg: I might not want all my messages to contain huge keys

...: we might want a caching header, saying: please use my cached key, or look up a key here

Holger: for gossiping, we also don't send it all the time if nothing has changed

...: some kind of keep-alive needs to be signalled

...: we should address the v4->v6 transition

## Action Items

- Organize next summit - Patrick
- Organize interim - dkg & Daniel
- Have a session about Autocrypt reference - Holger, Aleksandr, Bart, Daniel
- build an IMAP folder with autocrypt large message tests - dkg
- PQC in v4 summary - Aron
- Header Protection (From): DKIM and Autocrypt - dkg + Alex
- Forward compatibility summary (RNP, OpenPGP.js) - Kai
- HKP + WKD: continue the draft - Andrew
- v4 -> v6 migration create draft (BCP) - dkg + Andrew
- UA migration mechanism (BCP) - Andrew
- Multistep migration - Bart
- Automatic encryption to published keys: announce discussion - Daniel
- Autocrypt 2.0 - Holger
- Copy Pad to web page - Justus
