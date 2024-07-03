---
title: "Summit 2018 Notes"
permalink: /community/email-summit/2018/minutes/
---

{% include toc %}

This page documents the notes that were taken during the [4th OpenPGP
Email Summit](..) which took place 2018-10-20/21.

## Session 1: new standard for OpenPGP: TLS 1.3, RFC4880bis - Phil Zimmermann {#Session_1:_new_standard_for_OpenPGP:_TLS_1.3.2C_RFC4880bis_-_Phil_Zimmermann}

-   existing standard:
    [https://tools.ietf.org/html/rfc4880](https://tools.ietf.org/html/rfc4880)
-   new standard draft:
    [https://tools.ietf.org/html/draft-ietf-openpgp-rfc4880bis](https://tools.ietf.org/html/draft-ietf-openpgp-rfc4880bis)
-   working group:
    [https://tools.ietf.org/wg/openpgp/](https://tools.ietf.org/wg/openpgp/)
-   Phil: I\'ve been away from OpenPGP for a
    long time. I am not as well-versed as I have to be to address this.
-   Difficulty to rip out legacy: Block ciphers, 3DES, compression
    algorithms. But TLS1.3 was able to do it.
-   Werner: 3DES is optional in rfc4880bis. Most implementations follow
    rfc4880bis.
-   Phil: TLS group approach to getting rid of old stuff. a lot more
    MUST. less choices. trim down as much as
    possible. get rid of MDC, replace it with authenticated encryption
-   Werner: will not work. glad we could remove non-MDC, but that
    troubled people. can\'t rip out MDC, it works, even though it\'s not
    perfect. Not an online protocol, have to deal with long term
    storage.
-   PGP2 is also dead.
-   Phil: we can have software implementations to pressure users to
    upgrade their key by deprecating their old one. In the old days we
    didn\'t have organic/automatically updating in software. Today
    brwsers and app-us auto-update.
-   Werner: Long-term-support distributions, only slowly support modern
    algos. Redhat. Five years(+).
-   Elliptic-Curve-Cryptography.
-   Bart: Symantec is a problem. It took EFAIL
    to deprecate Tag-9.
-   Vincent: People would have done it earlier, if messages had been
    rejected earlier.
-   Werner: No.
-   Phil: Vendors respond to angry customers. Invisible hand of the free
    market.
-   Phil: The OpenPGP universe is a dumpster
    fire, a mess. I understand Werners argument. But I am not convinced.
-   Werner: Everyone else is using S/MIME, which is totally
    broken.
-   Werner: Everything has been done in the rcf4880bis
    IETF working group already.
-   ilf: small iterations and improvements vs. empty sheet of paper to
    draw a standard of 2018. Think about interoperability and
    backwards-compatibility after.
-   Phil: modernize. or dumpster fire.
-   Thomas: Use Key flags for signalling (new) features, i.e. if
    AEAD flag exists on the key, error should be
    thrown if features don\'t match
-   Phil: software upgrade feature
-   Vincent: symptoms of very slow ecosystem. MDC/ECC take ages to
    manifest and be supported widely. OpenPGP
    is insanely complex to implement and maintain. only possible by
    reverse-engineering GnuPG decisions. faster movement!
-   Phil: that takes ruthless political will. (quick poll: most in
    favor)
-   Bart: Prisoners dilemma. if I\'m the first implementer to to
    something, I will get shit from users. Meetings like this. Two-year
    timeline to deprecate things. Implementations are free to keep
    supporting old stuff, but the community moves on. Coordination. Less
    hate.
-   Phil: takes a lot of political will. Other projects (telephony,
    messaging) were fun. But I\'m getting emberrased about it. I don\'t
    want my original work to fade into eqXxxx. I\'d rather revive it. I
    know about legacy pressures, Werner. But let\'s aggressively drop
    support for legacy and move in the same direction.
-   Werner: OpenPGP.js implemented
    AEAD. I concinced them to keep it read-only
    until we have enough software to handle it. PGP is well documented.
-   Salman: Let\'s set a comon date to make a shift. Move in the right
    direction. Without breaking legacy. But we have to do it.
-   Bart: have to confirm decrypting from CAST5
    after a certain date.
-   Kristian: I maintain GnuPG in Gentoo. Two years is too
    short for deprecation.
-   Phil: I have done a number of products where software checks a
    textfile on a server to check whether it\'s current.
-   Kristian: That breaks the packaging model of Linux and BSD.
-   Werner: proposal create a new self-signature with updated feature
    flags? Interesting idea.
-   BSI: people using OpenPGP for
    End-to-End-encryption know about our issues.
-   Phil: reward of going to newer formats. We\'ll gain more users. new
    users should only use new formats.
-   BSI: now might be a good point to introduce changes.
-   Vincent: rfc4880bis Version5 key format without SHA-1 fingerprints.
    We will have hard breakage with V5 keys.
-   Phil: pressure on people to generate new keys.
-   Werner: had same problem with RSA and ECC. not real hard breakage.
    just a matter of key distribution. but we can\'t use ECC by default
    now.
-   Vincdendenent: V5 keys will not be compatible.we can restrict what
    we expect from clients implementing V5. no reason e e why a
    V5-implementation should use non-AEAD.
-   Werner: thats \'s in rfc4880bis.
-   Phil: let\'s remove the option to generate old keys.
-   Werner: mobile phones.
-   Vincent: let\'s be more aggressive about optimizing the spec we
    have. Shaving off bits here and there. l l l
-   paint fresh, start fresh.
-   Phil: Fit into existing syntactic framework. We can do that.
-   Bart: Protonmiail will probably generate curve25519 keys for all
    users in a few months. We\'ll tell users to update their client. It
    would be better to do that collectively. All implementations
    shoudldlld have ECC support by now
-   That took a decade.
-   Phil: What I\'m proposing that we chance how we think about this. It
    took a decade because we didn\'t think quick.
-   Phil: TLS had to do it. Snowden revelations as a motive.
    IETF dropped a lot of cyphers and algorithms
    after Snowden..
-   Werner: TLS implementations support 1.3 and 1.2 - and even 1.1 and
    1.0. There are 15 year old systems in production.
-   Phil: Sysadmins long felt obligated to support old browsers. After
    Snowden: fuck them, update their browser. All browsers have
    automatic updating now. We should be doing that for all of our
    clients. Through app stores on mobile devices. We are making
    security products. They should update.
-   Phil: Sofware can urge users to actively make new keypair when it
    supports new ciphers.
-   Vincent: I agree. Let\'s switch to ECC. Large partge parts of the
    ecosystem are ready. Let\'s not take another ten years.
-   Phil: I agree. Let\'s use 25519.
-   Vincent: We\'ll update autocrypt.
-   Phil: RSA was obsolete the day it was created.
-   Q: If Phil is advocating for new keys, why doesn\'t he have a new
    key?
-   Phil: PGPTools is nagging me to pay for
    it.

## Session 2: SKS keyserver - Kristian Fiskerstrand {#Session_2:_SKS_keyserver_-_Kristian_Fiskerstrand}

-   keyserver pools:
    \[https://sks-keyservers.net/overview-of-pools.php#pool_hkps
    [https://sks-keyservers.net/overview-of-pools.php\]](https://sks-keyservers.net/overview-of-pools.php%5D)
-   Kristian: want to talk about 3 topics: 1. the new pool
    requirements, 2. stripping usr ids? 3. improving performance of
    keyserver
-   Kristian: in the last few months, to be in the
    hkps.pool.sks-keyservers.net you need to have a clustered instance
-   \[https://sks-keyservers.net/overview-of-pools.php#pool_hkps
    \]Kristian:
    [https://sks-keyservers.net/overview-of-pools.php#pool_hkps](https://sks-keyservers.net/overview-of-pools.php#pool_hkps):
    currently only 5 servers run by 2 operators. want to ask the
    community if that\'s OK or should we go back to lots of keyservers
-   Kristian: privacy of user ids, should we store them?
-   Jenkins makes a request to the pool every time it starts, this
    hammers new keyservers
-   Bart: Web Key Discovery:
    [https://wiki.gnupg.org/WKD](https://wiki.gnupg.org/WKD)
-   Kristian: Would rather avoid debate about key discovery
-   Vincent: we (Patrick from enigmail) whther the keyserver network
    should be the default mechanism for key discovery. feels like a lot
    of responsibility to automatically push keys irrevcably to the
    keyserver network. suggested sending keyss to the mailvelope server,
    which allows removing keys from the keyserve (and validates email
    addresses). If we need to change the defaults we need a drop in
    replacement for the pooI. Specifically I\'d like to have some
    different semantic cahnge anythign about how SKS operates have had
    no success so far. WE\'ve been thinking about having a new keysever
    on keys.openpgp.org and operate that. there are a lot of questios
    about how to do that successfully. but mailveleope\'s success maybe
    something with a more neutral braning, operated closely by the
    software vendors, maybe that\'s a direction that can work better and
    avoid provlems problems the pool is having right now
-   Werner: shall we allow key external signatures on the keyserver? My
    key is 6MB because of third party signatures. It\'s not really
    helpful, if we continue to use key signing, is it better to have a
    separate service for third party signatures? \[Kristian: putting
    this down as under user id stripping, what data should keyservers
    hold\]
-   ?: interested in misbehaving keyservers, particularly echolocate
    keyservers.
-   Phil: what kind of traffic density? K: about 350GB data / month.
    I\'m running on 3 VMs. SKS has problem that it\'s a single instance.
    Instead of making SKS we\'re just using multiple servers. If you
    enable caching on the reverse proxy and if you cluster you can make
    a reliable instance (as long as one of the nodes is working). Want
    to discuss, should we do that failover on the keyserver pool? Or on
    the client? If a client receives an error, should it try again a few
    times? At the moment there\'s no retry in dirmanager, so I put the
    clustered requirement to reduce the number of complaints about
    failures, timeouts. Currently debugging some cache issues on BSD.

## low number of operators {#low_number_of_operators}

-   should we be encouraging more operators to cluster? or ask clients
    to handle errors?
-   ouch i cna\'t keep up with the notes
-   Paul: is there another issue, whatever happened in March? Before
    that, my keyserver was fine, then it wasn\'t
-   Phil: maybe we need an easier mechanism from removing keys from
    keyservers? Should they be in the keyserver forever?
-   Werner: if a they is compromised, there\'s no way to revoke the key
    then
-   Kristian: another option would be that SKS only reply to
    fingerprints
-   Phil: You could handle a removal request by stripping everything
    except the
-   Vincent: user id stripping, don\'t think it\'s possible because if
    you drop the user ids you lose the key preferences
-   K: you could have key preferences in a direct key signature. \[Does
    GnuPG support this?\]
-   V: either way this is a thing the client would have to do. You can
    only do \[user id stripping\] with keys that are generated under
    this new regime
-   You couldn\'t use the keyservers in the scenario \[stripping user
    ids\] where you need to get the full key material
-   the web of trust model would also be completely broken by stripping
    user ids
-   K: my preference would be this is optional, and allow clients to do
    it. At some point in time we might need to, that\'s why i want this
    discussion now.
-   isn\'t it a GDPR issue, that it\'s not just
    \*your\* personal information by the \*signee\*\'s personal
    information?
-   if this becomes a legal problem the server\'s going to be the one on
    the hook
-   possibilty of using other data in the key to specify that this key
    shouldn\'t be stored in the keyserver
-   SKS doesn\'t do cryptographic verifications so someone could still
    trick the keyservers.
-   Sanjana: Why is that? Phil: it should do that, it should verify the
    self signatures.
-   K: 2 points to that: performance. will increase the requirements on
    a keyserver
-   Phil: we\'re suffering from lack of users, we aren\'t going to worry
    about performance
-   K keyservers should not be treated as a trusted entity.
-   Phil: as a joke people upload keys with my email address. Just
    because I \*have to\* check at the client level, it doesn\'t mean
    the keyservers should be wilfully stupid
-   Issue of verification: people will take it as an assertion
-   W: Key discovery can\'t work via keyservers! It\'s not reliable
    anyways -\> remove the feature from sks

**mapping from fingerprint to uid still useful**

-   V: there is positive feedback from Mailvelope that their private
    keyserver does work
-   W: idea is many keyservers that replicate, no single point of
    failure

**openpgp should not use 509\'s centralized model**

-   Andre: I\'m using keyservers for discovery when I have a
    fingerprint. With communication hiscan get trust from this. So
    without user IDs I can\'t do it.
-   W: I\'m not saying you strip user IDs, but remove the \*search\* by
    user id functionality
-   To echo that, all the clients would all be configured with the legit
    ones
-   V: it\'s very hard to remove functionality in a client that breaks
    things because users say \"it still works in the other clients\" so
    you take all the flack
-   K: going to point about development of SKS

**did updates for new key materials at some point**

-   K: I\'m not ot an OCAML programmer, I don\'t
    want to do major changes to the keyase. It\'s easier for me to
    require clustered keyservers than making changes to SKS. I only do
    small changes.

**can\'t do large changes for time and ocaml knowledge contraints**

-   Bart Butler: not everything has to have tls support, e.g. backend
    daemons

**K: Right, that\'s how it is. Can\'t use letsencrypt because custom
cert is used today**

-   Phil: i haven\'t seen this \[sks\] in action, but I know years ago
    we used to use MIT, there was all this vandalism. When PGP
    corporation developed their ownkeyserver, it checked things,

**pgp global directory: checked with confirmation mail**

**pleasure to use: singular mapping, no bogus keys** wouldn\'t it be
nicer to li to live in a world where we don\'t have so much crap on the
keyservers?

-   (pmg): even so putting a barrier to adding a key, that would help
    wouldn\'t it?
-   when you\'re gossiping with other operators, how does the validation
    get synced?

**validation and federation impossible to combine**

-   Paul: Didn\'t know you weren\'t an ocaml developer
    -   elephant in the room: sks is unmaintained?
-   K: talked to casey, very much welcome alternative implementations!
    -   Kristian: I would be very happy for alternative implementations
        of SKS besides
        [https://bitbucket.org/skskeyserver/sks-keyserver](https://bitbucket.org/skskeyserver/sks-keyserver)

**it\'s called sks-keyservers.net, but historically we accepted other
implemenations** need to decide on minimum requirements **definitely
right approach, instead of doing large rewrites on sks**

-   (gnome guy): maybe get rid of keyserver network?
    -   reasons we have them aren\'t compelling anymore, requirements
        have changed
    -   maybe we need just a revocation server
-   rly differntotaltotal

**totally differnet set of problems if we\'re only implementing a
revocation server**

**you can reuse all this stuff for free like Certificate Transparency**

-   V: dropping key discover altogether is a very tough decision to
    make. (email -\> key)
-   K: key discovery on keyservers is misuse
-   V: maybe drop searching on substrings?
-   W: someone will download all the keys and make fake keys

## Session 1: Autocrypt level 2 {#Session_1:_Autocrypt_level_2}

-   will not break Autocrypt level 1

## which features do we want? {#which_features_do_we_want.3F}

-   key sync (public/private)
-   detection of active attack
-   alternate routing
-   ways to integrate with non-autocrypt topics (alternate
    force-encryption, etc)
-   key refresh (ECC? PQ?)
-   Protected headers
-   key rotation
-   workflow for device loss
-   MIME simplification
-   policies for subkey rotation/expiration
-   search of content of encrypted messages

## Organizational process {#Organizational_process}

-   github process
-   regular IRC meetings

Can we do \"level 1 compliant\" badging?

How can we evaluate that a client isn\'t level 1 compatible?

-   propose asking about \"level 1\" compliance on mailing list. if no
    unanswered objections are raised in two months.

potentially try to launch level 2 work before IFF 2019

## easy

-   ECC keys
-   protected headers
-   MIME simplification

## next up {#next_up}

-   multi-device synchronization
-   verified contacts (and their implication of how the state changes)

## next steps {#next_steps}

-   solicit level 1 compliance reviews

## Session 2: MUA state sync {#Session_2:_MUA_state_sync}

-   What we want do sync?
    -   secret key \--\> answer (autocrypt setup message)
    -   Autocrypt state
    -   Address Book
    -   alternative routing
    -   general perferences of MUA (Signature,
        HTML, \...)
    -   rule settings policy
    -   tags, etc
    -   public key ring
    -   filter rules
    -   per message session key
-   Properties to sync
    -   easy to use
    -   authenticated and confidential
    -   ongoing
    -   automatically
    -   more then two devices
-   Ways we could the sync?
    -   kolab protocol an option?
    -   there needs to be a pairing mechanism -\> whats the easiest way
    -   MLS -\> group messages protocol
    -   syching protocol needs to allow message loss
-   Risk and side Effects?
    -   end-up syncing to a device you want to sync to (avoid wire tap
        channel)
    -   deleting, duplication
    -   sync fails (deletetion of keys, \....)
    -   lateral movment after compromise
-   Seperate in multiple Layers
    -   Define mechanism of pairing and sync -\> how to establish an
        auth., conf,\... channel not the syntax to sync
    -   Storage (IMAP,
        NextClout, Gdrive, \...)
    -   Whats to sync

## Session 3: Counter MITM {#Session_3:_Counter_MITM}

\[Unstructured follow-up to the Counter-MITM
paper presentation in the morning.\]

Q: What kind of in-person key verification mechanisms did you envision?
QR? etc?

A: Paper is agnostic, some mechanism for transmitting bootstrap data,
fingerprint + 2 secrets. One (invite token) secret to authenticate
initial message, trigger response with PGP key. Response triggers
encrypted message containing second token, proving verification
completed, also including fingerprint of initator. (Discussion,
whiteboard)

Q: What do \"system messages\" look like?

A: First message is cleartext, the rest encrypted. Using headers inside
the encrypted part to transmit data. Useful for other
MUAs to know, so as to be able to suppress these
messages. Very similar to DSNs, but modified so
as not to be recognized as such, so as not to trigger messages back.

Q: Discussion about time-outs in the verification flow\...?

A: Currently unlimited, policy needs to be defined.

Q: Are separate keys stored for different contexts, groups/vs. 1:1?

A: Yes, the groups use the latest verified key, Autocrypt just uses the
latest received key. (discussion about keys)

Q: What about key change notifications like
Signal/WhatsApp?

A: (discussion)

Q: What does it mean if keys change?

A: Delta is very simple, if any bit of the key changes, it\'s a new key.

## Session 3: Webmail / Autocrypt {#Session_3:_Webmail_.2F_Autocrypt}

-   Mailvelope wants to integrate autocrypt.
-   Some discussion on how to integrate autocrypt into Mailvelope has
    already happend.
-   There is a autocrypt-implementation in
    JavaScript
-   Mailfence thinks about integrating autocrypt into its
    javascript-libraries (OpenPGP.js-based).
-   Startmail looks into moving encryption-operations to the
    client-side, too.
-   Autocrypt doesn\'t tell anything about the techniques for
    implementations
-   Roundcube maintainers have a (not yet) document what would be needed
    to better support autocrypt
-   Mailvelope handles ciphertext, doesn\'t take care of top-level
    mime-headers.
-   It must be helped by server-provided Code to produce
    pgp/mime-messages, or read/set autocrypt-headers.
-   Mailvelope and Gmail don\'t work together in \"MIME-mode\"
-   Some email-providers help autocrypt e.g. by
    DKIM-signing autocrypt-headers
-   autocrypt doesn\'t require signing its headers
-   (Some discussion about DKIM)
-   (Some discussion abpt being attackable/disruptable)
-   Would the autocrypt peer state neout autocryed to be stored in the
    encrypted module, or not?

## Session 4 - Multiple Key Discovery methods {#Session_4_-_Multiple_Key_Discovery_methods}

Session about how MUA\'s that support multiple key discovery methods
handle them and how to handle different answers Collection of existing
key discovery methods (on the right is how you search it): autocrypt -
email WKD - email SKS pool - email \| keyid \| fpr Mailvelope
keyserver - email \| keyid \| fpr LDAP - email \|
keyid \| fpr DNS - email garbage pile - email \| keyid \| fpr keybase
etc. local override (e.g. local signatures on manually imported keys or
the addressbook) Garbage pile: New keyserver by Kai and PEP: only search
for full user id\'s and validates E-Mail addresses. Only after
validation the key is searchable Allows for removal We scope the
discussion to lookup by email address. What is the confidence in the
discovery methods. WKD: In GpgOL and protonmail and Enigmal:
Keys from WKD are used directly for automatic encryption without user
interaction Policy overrides e.g. local signatures are override that
Enigmal and GnuPG have a list in an order where they look for
keys. Concern is that Meta data leaking key sources should not always be
tried. Local sources are preferabble and prefered. Meta data leakage
concerns, each key discovery source has different meta data leakage DNS
is especially problematic WKD only leaks the domain

Ranking and collision handling: There could be the state that different
services report different keys WKD can have multiple keys in a response
There was discussion about this that it might be a bad idea and should
be changed in the future. Mailvelope keyserver and garbage pile both
only return one result.

Strategies when multiple keys are found: Ranking - by validity or other
criteria like last created subkey Encrypt to all of them - has the
advantage that there is the least danger that the recipient can\'t
decrypt the message Escalate the problem to the user

For lookup Start with no meta data leakage and little latency

Sidetrack WKD: A provider can have mutliple canonicalisation methods
esp. with Unicode in the local part WKD does not really has a policy for
this except something simple like lowercasing.

There should be a canonicalisation policy for WKD.

## Session 4 - Signature taking over time {#Session_4_-_Signature_taking_over_time}

DKG: When you recevie a message and it is signed, we have some idea what
that means, and some ideas about how it is presented to the user. When
you look at messages in your archive from a year ago, that are signed,
you might feel differently. Has the key expired since? Has the key been
revoked since then? (or the subkey) .. lost the keys? Or the other way
around, you now have a key and can verify old stuff. It\'s not clear
what a signature means over time, with a store and forward protocol like
e-mail.

Most messaging protocols don\'t have his, they don\'t have per message
non-repudiating signatures.

1\. What are the ways that a valid signature effects my MUA?

2\. What are the ways that an invalid signature effects my MUA?

3\. If I\'m looking at old messages, and status now is different, does
that effect what my MUA is going to do?

\...

OpenPGP.js: Treats expiration and revocation
as different. When a signature is verified, key validity is derived from
signature time.

DKG: The message has many dates, which is used?

ProtonMail: Uses Received headers. Unless
it is very different from the when the message was entered into the
database.

GnuPG: uses timestamp on the signature itself, if the key was
not expired, it is considered valid. Otherwise invalid. If it\'s signed
before key creation time, there\'s a warning but considered valid. If
revoked, if the revocation is due to compromise it is always invalid, if
superceded, revocation time wins. Ignores all the e-mail specific data.

Usually date related failures are caused by bad clocks.

\...

What does your MUA do differently if a signature is valid?

Outlook: Shows a green bar if the signature is valid when it is
displayed. Never show any warnings or error messages, only available
hidden behind the details button. For an expired signature or a revoked
key, there\'s just no green bar and no icon, show as if it was unsigned.
Never show a signed mail as less trustworthy than unsigned mail. Don\'t
think there is much of a use case for looking at old signatures, it\'s
mostly for current mail to prevent spear phishing etc.

Mailpile: Similar. Add delimiters within message display to show what is
signed or not. If historic data indicates that the sender ususally
signs, then anomalies may show a scary red icon, but otherwise the UI is
relatively quiet about it.

ProtonMail: Differs depending on whether
there is a key pinned for that contact. Display \"nothing\", a
checkmark, or an X. (discussion)

Mailfence: If we have a signature, we clearly mark as green. If it\'s
not valid, we show a red bar. And then the third case is we have a
signed mail, but no key to validate, show it\'s signed by someone but we
don\'t tell you if it was a good or a bad signature. Unsigned mails have
no markers.

\...

Q: Did the pros in the room do usability testing?

Mailfence: We launched iteratively, responded to user feedback.

(discussion went elsewhere)

\...

(Whiteboard discussion of different timestamps)

DKG: Points out about 14 different data points that relate to time, that
might be considered input into evaluation of the validity of a signature
and communicating to the user.

MailFence: Talk about how they embed
user-visible artefacts inside the (encrypted/signed) message body that
make it more visible if a message is replayed.

\...

Discussion about how signatures are used in the mail client: - Direct
display - Input into evaluation of sender crypto capabilities - Input
into GnuPG\'s TOFU database - Seeing
signatures is a sign a key is in use, useful to rank keys when importing
(Discussion about caching verification results, vs. evaluating every
time a message is displayed.) Revocation is the main exception from
caching being useful. Discussion of revocation semantics.

\...

Outcome: Signatures and dates are being used in very different ways in
different e-mail apps. Which is interesting! Room for much more
conversations and learning from each-other.

## Session 4 - protected headers {#Session_4_-_protected_headers}

## protected headers (memoryhole) {#protected_headers_.28memoryhole.29}

-   current state: spec was done in 2016, some clients did implement it
-   the spec didn\'t really evolve
-   no website anymore (modernpgp.org)
-   naming of the alternative subject \"Encrypted message\"
-   implementers feedback reg. fallback
-   IETF Internet draft coming up by dkg & Alexey
    wrapping emails in rfc822 messages (LAMB(P?)S
    working group IETF, spasm)

## implementers feedback regarding rfc822 fallback {#implementers_feedback_regarding_rfc822_fallback}

-   fallback mode: a text part MUAs should
    display the user in case the client is not able to understand
    protected headers
-   fallback mode: not optimal, because it adds just another
    MIME part, and increases the spec
-   apple mail does include the fallback mode, mutt needs manual config,
    kmail shows it as well
-   complaints: user get (or got, in the past) garbled message, some
    MUAs didn\'t decrypt these messages (in the
    past, mailfence maybe (?) still unfixed)
-   complaints: threading doesn\'t work if based on the subject
-   discussion about removing the fallback mode: pros and cons about
    keeping vs. removing
-   schleuder: broken in the beginning when enigmail enabled protected
    headers by default; nowadays fixed, schleuder leaves the subject
    \"as is\" and works transparently
-   K9Mail: not released / in the master
    branch, currently only implemented in a devel branch
-   GPG4win: ?
-   was there an effort directed at \"all\" of the
    MUAs asking for implementation, offering
    advice and help etc.: no, there wasn\'t such an effort; one reason
    for it was that there was never a complete spec
-   currently rough consensus and running code: what about finalizing
    the spec and do a reach out to various MUAs?
-   strip the spec down to a minimal level: just start with the subject,
    no References: etc. -\> just encrypting the subject would be a good
    start, and could serve as a base to then do further iterations to
    encrypt more headers
-   dkg starts a process to do an IETF draft
-   feedback regarding the spec: sounds quite complicated because of
    multiple layers; proposal: just use the first MIME part
    inside the encrypted message
-   the new IEFT draft might contain multiple
    layers as well; might make it complicated for
    MUAs what to display when
-   protecting the From: header is complicated, because, depending on
    the MUA, it might be either impossible or pretty hard
-   \"Encrypted Message\" subject: users might think that this serves as
    a security indicator
-   proposal: remove the \"Encrypted\", use \"No Subject\" or \"Subject
    unavailable\" or \"Embedded Subject\" or \"Hidden Subject\" or no
    Subject: header (which are disliked by spam filters etc.)
-   localization of the subject reveals the language
-   fallback mode: adds additional implementation cost
-   fallback mode: doesn\'t really help users of
    MUAs which doesn\'t support the spec
    (INBOX filled with mails with subject
    \"Encrypted Message\", therefore searching for a specific message
    based on the subject is not possible)

## we need a new home {#we_need_a_new_home}

-   modernpgp was the original home
-   there is a repo on github which doesn\'t contain the content of the
    website

## next steps {#next_steps-1}

-   stripping down the spec to a minimal level would be quite easy (TBA:
    this evening, or tomorrow morning, the latest)
-   leave aside the fallback mode, or make it optional (if it\'s just
    optional, maybe leave it out right from the beginning)
-   where to put the new content: depends on the
    IETF draft and what should go in there
    (S/MIME? etc.)
-   we\'re not bound to the IETF draft, so our
    \"new home\" doesn\'t depend on this -\> no consenus / decision
    where this should be hosted

------------------------------------------------------------------------

## Day 2 {#Day_2}

## keys.openpgp.org + GDPR concerns {#keys.openpgp.org_.2B-_GDPR_concerns}

-   Kristian repeated the content of last days session: Will probably
    not accept email validation or other radical changes, but new SKS
    compatible software in the pool is possible
-   Patrick: People ectually try to find keys via email addresses
-   Vincent:
-   Using the pool in OpenKeychain to
    automatically upload keys without asking the user, is making
    OpenKeychain
    GDPR-critical.
-   Patricks original idea was to use the maivelope keyserver as it
    validates email addresses
-   Mailvelope keyserver actually works for people, but we obviously
    drop federation and other requirements we have in the pool
-   Idea: Neutral branding of a keyserver is needed, not use mailvelope
    keyserver in OpenKeychain
-   keys.openpgp.org as a home for this new server
-   New implementation based on Sequoia PGP (Rust) in progress
    validating keys and verifying email addresses
-   Small but stable group that manages the keyserver
-   GDPR: Even a checkbox does not work as a
    consent, as it is not clear to the user that the key is undeletable
-   OpenPGP key is 100% PII
-   Verifying and deletable is required to be 100%
    GDRP compliant
-   Andre:
-   People who wrote the GDRP say that keyservers
    are no problem
-   No keyserver has ever received a complaint
-   Users need to complain to a data protection authority
-   Conclusio: We will most likely not get a problem, we should not
    worry about GDRP, BUT: we can freely think
    about new models
-   Non-exportable flag?!
-   Justus: There is a difference about non-exportable and keyserver
    preferences
-   Andre: Use the flag to specify if the key should be uploaded or not
-   Vincent: Agress with the GDPR, legals issues
    may not be bad, still: move in the right direction
-   Lawyer of Switzerland based provider says that keyserver will not
    have problems. But, they don\'t use the keyserver as it is confusing
    to users. They strip everything except the email addresses
-   Vincent: points of discussion:
-   email addresses
-   third party signature
-   how much of a drop-in-solution do we want?
-   search by substring of user ID? If we drop that we have only lookup
    by IDs, which allows performance
-   Non-self-singed User ID supported by
    OpenPGPjs?
-   Justus: Do we return user ids if we only request by fingerprint?
-   Vincent: No conclusion for now what to do if we lookup
-   Dominik: Being a drop-in replacement, I would return all user IDs,
    because that is what implementations expect
-   Patrick: yes, I agree
-   Gmail and other have certain cleaning algorithms for email address,
    e.g., remove dots etc. Maybe exact matches are not enough
-   Vincent: Move to a 2. iteration as it makes it complex
-   This could also be implemented in the lookup tools
-   Vincent: Maybe meet in the middle using a normalized email
    representaiton
-   Vincent: Another issue: We need to lookup by long key ID (64 bits),
    but there can be collisions
-   Patrick: For now: Don\'t allow long key ID collisions, later drop
    long key IDs, when fingerprints are in signatures
-   Justus: Interface? Do we implement HKP?
-   Vincent: Yep, being a drop-in-replacement
-   Vincent: New point: Governance aspect
-   Ask EFF to run it? or other orgs?
-   Haven\'t talked about federation: SKS just a small number of fed
    nodes currently in the HKPS pool
-   Not opposed to use some kind of replication
-   Data set is no public, so backup, replication etc is more important
-   Use OpenPGP email mailinglist for new
    discussions

## session about unspoofable security indicators {#session_about_unspoofable_security_indicators}

Primary focus: html spoofing of security indicators

we want the chrome to be nearby, but the closer it is the harder it is
for users to distinguish between content and chrome.

should we just get rid of the ability to see html?

what about indicators in the message list?

can we populate the sender line/headers? because those parts can\'t be
manipulated by the body.

kmail has problems where we don\'t have single signature state.

pgp inline is problematic, especially for piecemeal-signed.

dkg suggests that we have only one signature state per message.

rendering mails as text-only, with a button to allow views of
HTML formatting

people receive all kinds of bizarre messages.

pgp partition spec means that mails arrive with multiple statuses per
part. symantec endpoint security, gpg4o both generate this.

stefan says \"if there\'s an inline encrypted blob in a cleartext
message, let the user decrypt it manually\"

dkg proposes limiting cryptographic status to \"cryptographic envelope\"
vs. \"cryptographic payload\" \-- only use the set of layers of
MIME crypto at the very outside of the message.

[https://dkg.fifthhorseman.net/blog/e-mail-cryptography.html](https://dkg.fifthhorseman.net/blog/e-mail-cryptography.html)

if we move to one-status-per-message, Mailing list signatures are going
to be the first fatality.

University of Bochum sent mail to many MUAs about
spoofable UI indicators. we should be prepared to link to that work when
complaints come in about simplified display:

[https://www.golem.de/news/openpgp-gnupg-signaturen-faelschen-mit-html-und-bildern-1809-136738.html](https://www.golem.de/news/openpgp-gnupg-signaturen-faelschen-mit-html-und-bildern-1809-136738.html)

Should we ensure that insecurity indicators take up the same amount of
space as security indicators, so that the space is reserved?

Andre has different security indicator levels in bars above the message,
and also up in the upper right.

Bjarni (not present) is proposing showing insecurity for mails from a
user who has sent all secured mails in the past. Stefan points out that
this doesn\'t work for random spoofing from unusual addresses.

Andre points out that there\'s a marketing issue for plugins \-- they
want very visible indicators to prove that they\'re doing something.

maybe we can consume a lot of space by default, but let users minimize
the space, and when they choose to do that, we have an opportunity to
educate them to look for the smaller indicators.

## Session: Timestamping for Signature validation {#Session:_Timestamping_for_Signature_validation}

-   Problem statement: OpenPGP digital
    signature validation (in most implementations) takes into account
    the present status (revoked/expired) of the signer\'s key, and
    displays an inaccurate/confusing signature validation message if the
    signer\'s key is revoked/expired.
-   Based on the status of signer\'s keypair (valid/invalid) when the
    signature was made (timestamp), if valid - then the digital
    signature remains valid forever and vice versa in the other case.
-   Keep states: Use a trusted third-party to maintain timestamps, and
    provide signature validation information in case of conflict.
-   OR Either use Merkle trees to combine different hash values (using
    the order of nodes) to verify. E.g., the message receiver can hash
    every obtained signature and keeps a record of it (e.g., in a Merkle
    tree based database) which can be used as a verifiable medium that
    can be produced to court.
-   In case of signer\'s key revocation, there\'s always a time between
    when the key was actually compromised (which could be unknown to the
    user) and when it was actually revoked by the user. Any signatures
    made during this time, would be considered as malicious. In case of
    having a trusted authority, the fall back can be made on the last
    verified signature (made by the user when the key was not
    compromised).
-   Further to above point, instead of having a trusted authority, we
    can ask the signer of the message to publish the last verified state
    of the key on some public channel (e.g., public key servers, other
    channels, \...) which will serve as a datapoint for the last
    verified state (that can be used to make a reasonable decision e.g.,
    signing time vs last verified state?).

Session slides:
[https://homes.esat.kuleuven.be/\~decockd/slides/20181021.signature.validation.pdf](https://homes.esat.kuleuven.be/~decockd/slides/20181021.signature.validation.pdf)

## Signature Validity / Display {#Signature_Validity_.2F_Display}

Protonmail: No signature No key Failing signature verification

GnuPG/Outlook Plugin:

-   unsigned state / broken signature
-   only some indication that this key is used by this user, no manually
    signing of the key, you only saw some signed mails of this key
-   valid signature, still no manual interaction with the key. Used many
    times, pulled from WKD
-   full validity, same level as in S/MIME trust, someone has
    certified the identity
-   own keys, direct signature on other keys

Concept of verified sender address: not making an assumption about
identity, only make an assumption about sender address, that it was not
faked.

Enigmail:

-   either message is signed but no key, or signature invalid: signature
    not verified
-   User id matching, Enigmal doesn\'t do it

Mailvelope

-   no signature: nothing is displayed
-   signature but no key: warning
-   invalid signature: red

K9 Mail

-   limited space for showing the signature verification result
-   orange: signed and encrypted but no key, because actionable: the
    user can click on the orange sign and try to fetch a key from a key
    server
-   message with Autocrypt header and signature will verify as valid

Changing behavior can be monitored: if we have a history of that contact
and changing signature information, then we can make assumptions about
the validity of signature.

Signatures are made without context. Intended recipients field: this
message is signed and should be encrypted for this and that
fingerprints.

Mailpile also shows red state for signature verification fails.

Agreement: should be a binary state if a message was valid signed or
not. There could be a second parameter that makes a statement about the
trust on the key.

## Session: Deletable Email {#Session:_Deletable_Email}

-   Draft: Forward Secrecy Extensions for
    OpenPGP -
    [https://tools.ietf.org/html/draft-brown-pgp-pfs](https://tools.ietf.org/html/draft-brown-pgp-pfs)
-   What does \"deletable email\" actually mean? Control the period of
    time in which an email can be read. An attempt to reframe \"Forward
    Secrecy\" and adopt it for an archivable message format like email.
-   Also messaging formats that provide \"Perfect Forward Secrecy\" have
    a window in which the messages are decryptable. Typically those time
    windows are small.
-   OpenPGP can use rotate subkeys frequently
    to achieve the same thing (with a larger time window).
-   Making people using the repeatedly changed key is a challenge.
-   You then can\'t read old email --- do you want that?
-   Should emails be archived at all? That is a contradiction to
    \"Forward Secrecy\".
-   notmuch approach: store the session key, store the message \<-\>
    session-key association. Enables deleting the encryption-key and
    still have acces to the message\'s contents.
-   Another approach: re-encrypt all messages to a local key.
-   There is no data destruction policy in email(-clients). Why is that?
    Some messengers have that (\"delete this message after 1 week\").
-   There could be different options to maybe state a personal
    destruction policy, like email headers, (sub)key annotations.
-   There is no way to enforce such a destruction policy in in for
    email, because that would require bilateral, binding agreements.
-   Email being archival is a feature and one of the reasons that many
    businesses still keep using it: they need to archive their
    communication for compliance reasons.
-   Deleting a message locally is not enough because there\'s always
    other people that (could) have a copy of the message, which could be
    reitrieved and decrypted by the key you retain.
-   There is a paper describing using a new encrypting subkey for each
    correspondent or even per message.
-   New subkeys are a problem in multi-device environments.
-   sequoia thinks about weekly key rotation.
-   Even a semi-yearly time window would be a huge improvement over many
    years or indefinite time.
-   Idea: pre-generate and publish keys for \"heavy rotation\" of keys.
-   Frequent rotation might force people to frequently consult
    keyservers, which can lead to leaking data (which IP wants to send a
    message to which recipient).
-   Requiring out of band transport to get access to (rotated) keys
    requires a well connected online mode (problem for networkdbadly
    connected networks).
-   Why do we are targetting small time windows (days or weeks) for an
    archival format like email? It might already take a day to only
    delivery a message.
-   We need to figure out what an appropriate time window would be ---
    for whom.
-   Justus discusses two approaches how to bring Forward Secrecy to
    OpenPGP:
    [https://sequoia-pgp.org/talks/2018-08-moving-forward/moving-forward.pdf](https://sequoia-pgp.org/talks/2018-08-moving-forward/moving-forward.pdf)
    [https://www.youtube.com/watch?v=an6oYjikAPY](https://www.youtube.com/watch?v=an6oYjikAPY)
