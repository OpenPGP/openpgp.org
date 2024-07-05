---
title: "Summit 2016 Notes - Memory Hole"
permalink: /community/email-summit/2016/minutes/memory-hole
---

{% include toc %}

# Memoryhole Discussion {#Memoryhole_Discussion}

*Memory Hole spec and documentation:
[https://github.com/autocrypt/memoryhole/](https://github.com/autocrypt/memoryhole/)*
*Follow up session to the [Workshop at 2nd OpenPGP Email Summit, Dec
2015](/community/email-summit/2015-12/minutes/memory-hole)*

complex structures signalling acceptance alternate interpretations?

Proposal: discuss state of implementations and problems we've been
having.

## Actions {#Actions}

-   update the corpus (patrick)
-   update the spec (dkg) (kali proofreads)
-   map the implementations (meskio)
-   test implementations against each other (meskio)

further discussion will happen on openpgp-email@enigmail.net

## Agreements {#Agreements}

-   The first non-protection-layer MIME-part after a protection
    layer can have MIMEpart headers.
-   And the text/rfc822-headers is valid only if it is the first part in
    the multipart/mixed after the protection.
-   The innermost legitimate/valid header is the one that should bubble
    out.
-   the advantage oOnly the headers that have the same protection level
    as the body
-   The content-type parameter 'protected-headers'
    MUST appear in every memory hole part - the
    header block which contains the memory hole headers or the force
    display block (text/rfc822-headers, mutlitpart/mix, ...)
    -   current implementations MUST set the
        value of the protected-headers parameter to "v1".
    -   implementations should accept any version.
    -   implementations that identify a prospective memory hole part
        should not accept it if it lacks a protected-headers parameter
-   From, To, Date and Subject should be always in a memory hole part.

## Session {#Session}

meskio:

-   meskio and kali been implementing for leap, in python, general lib.
    Mostly done.
-   [https://0xacab.org/leap/pymemoryhole](https://0xacab.org/leap/pymemoryhole)

stefan:

-   mostly finished
-   don't know how to do with minor details
-   what to do if i find different memoryholes in different parts
-   r2mail2, written in Java.
-   not public yet.

Patrick:

-   in enigmail it is working, not yet enabled by default.
-   basic funcionality is there.
-   displays the correct subject.
-   idea is to have it working if people want to start using.

dkg:

-   notmuch: almost done.
-   not currently doing any generation, only parsing/receiving.
-   "is there a lowbar threshold for MUA developers to implement?"

Dominik:

-   k9 doesn't do any, have more difficult problems like pgp mime.

Meskio:

-   there is a collection of messages attached to specification: chorpus
-   should be more clear which of them are the minimum.

Patrick:

-   problem with chorpus is that is still the same as last year's
    summit, has not been updated.

Meskio:

-   headers might happen in different parts

dkg:

-   there are names for that in the spec:
    -   external header block - "the first thing you see"
    -   mime-part header block
    -   text/rfc822-headers

Meskio:

-   there are possible actions with headers: strip, stub, keep.
-   the header block from which a certain header comes is independent of
    what is actually done with the header.

dkg:

-   replacement is only useful for encryption, for signing you don't
    need it.
-   dkg draws examples of standard (example), signed and encrypted
    messages
-   standard (example-message):
    -   multipart/alternative
        -   text/plain
        -   text/html
-   signed:
    -   multipart/signed
        -   multipart/alternative
            -   text/plain
            -   text/html
        -   application/octet-stream
-   encrypted (after decryption):
    -   multipart/encrypted:
        -   multipart/mixed
            -   text/rfc822-headers
            -   multipart/alternative
                -   text/plain
                -   text/html

Patrick:

-   if you forward an encrypted mail as attachemnt, then you have a
    sub-mime tree.
-   if you try to display the forwarded message, you have to treat it as
    a completelly new message.

dkg:

-   headers can be moved to one of 3 places:
    -   when signing:
        -   as a header in the first protected
            MIMEpart
    -   when encrypting:
        -   as a header in the first protected
            MIMEpart
        -   as a force display MIME that has to be the first
            MIME block after the multipart/mixed
-   Let's talk about complicated corners for interpretation:
    -   what if the headers don't match up? that is, same header name
        in diferent parts with different contents.
    -   what to do when some headers appear in one place and others
        appear in other place? example: there might be headers that are
        signed and encrypted, and some that are only signed. That is,
        when some headers have one level of protection and others have
        another level of protection.
-   Proposal: innermost legitimate/valid header is the one that should
    bubble out.
-   The only headers that really matter are the ones that come
    immediatelly after the protection layers.
-   There is a problem with S-MIME:

#### Agreed rules to bubble headers {#Agreed_rules_to_bubble_headers}

-   The first MIMEpart after each protection
    layer can have MIMEpart headers.
-   And the text/rfc822-headers is valid only if it is the first part in
    the multipart/mixed after the protection.
-   The innermost legitimate/valid header is the one that should bubble
    out.
-   Only the headers that have the same protection level than the body
    will be taking into account.
-   The content-type parameter 'protected-headers="v1"'
    MUST appear in every memory hole part - the
    header block which contains the memory hole headers or the force
    display block (text/rfc8222-headers, mutlitpart/mix, ...)

#### Multi wrapping example {#Multi_wrapping_example}

Arrows mark where can be headers

-   multipart/encrypted
-   ------------------------
    -   multipart/signed
        -   multipart/encrypted
        -   ---------------------
            -   multipart/mixed <-
                -   text/rfc822-headers <-
                -   multipart/alternative
                    -   text/plain
                    -   text/html
    -   application/octet

Only the last two will be taken into account.

#### Force display versioning {#Force_display_versioning}

Agreement:

-   add a flag saying that the headers are protected headers. That
    should force display.
-   Content-Type: text/rfc822-headers; protected-headers="v1"
-   implementations should accept any version.
-   Rationale: In case of delivery status notifications we can add a
    flag to avoid interpreting the headers wrongly. Not sure if it's
    needed as in the wild don't seem to be this MIME part as
    the first thing.

#### UX about different security levels per header {#UX_about_different_security_levels_per_header}

What about headers with different protections? Should they be replacing
the external headers? Should only headers with the same protection as
the body be taken into account?

Only the ones with the same protection than de body are taken into
account.

How do you represent the different levels of security of each header?
Should be a binary thing where the headers are encrypted it's secured
only if the headers are stripped or stubbed?

What about a warning sign for each header that is not protected?

#### Specific headers {#Specific_headers}

-   From, To, CC, Date and Subject should be always in a memory hole
    part.
