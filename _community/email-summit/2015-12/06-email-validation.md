---
title: "Summit 2015-12 Notes - Email Validation"
permalink: /community/email-summit/2015-12/minutes/email-validation
---

Workshop at [2nd OpenPGP Email Summit, Dec 2015](..) run by Nicolai
Josuttis. Follow-Up:
[OpenPGPEmailSummit201607/EmailValidation](/community/email-summit/2016/minutes/email-validation).

## Approach {#Approach}

With this approach we want to establish a quick backward compatible
solution to validate email addresses of UIDs of OpenPGP keys.

This would help to **solve two major problems** we have:

-   People can currently easily upload faked keys (and they do)
-   We have a lot of "moldered" keys (old keys not for any usage
    anymore)

The **key approach** is:

-   Define a **standard signature format** to signal successfull email
    validation
    -   The standard format would require to:
        -   let the signature expire after 1 year
        -   having a "signature notation" defining when/how/what was
            validated as JSON value
        -   having a link to the validation policy of the validation
            server
    -   The standard format allows email clients to process them
        accordingly
        -   E.g.:
            -   Prefer or highlight keys that hav any such signature
            -   In the UI show a list of who validated the email address
            -   Signal trust for a UID if it is signed by one or more
                (specific) validating servers
    -   But even existing email clients can benefit from them:
        -   According to the WebOfTrust a user can grant
            trust (and therefore priority) to emails with specific
            signatures
-   Establish some **initial validation servers** to perform that
    validations on request
    -   To validate: Sends email to email address in UID encrypted with
        the key to ensure that the one who confirms has the private key
    -   Request might be implicitly triggered by email clients or
        explicitly triggered by sending an email
        -   request shall be an email
            -   to ensure that the request is signed by the owner
        -   part of the email can be two hints:
            -   "upload to key server"
            -   "revoke signatures on old keys"
    -   Validation can be done asynchonously (not hindering immediate
        use of a new key)

**Key properties of the approach** are:

-   No change of existing key server infrastructure or protocol
-   Existing email clients can use it
-   Fast establishment possible when email clients (e.,g. enigmail)
    support this in a new version
-   The standard format might also be used by email providers, who
    provide both email address and keys (e.g. Google)
-   Yes, this is a CA-like approach
    -   Careful selection of initial CAs
    -   Options: Current SMime CAs, trusted organizations, ... ?
-   This is **no perfect solution**, but it makes faking keys a lot
    harder and easier to detect
    -   Solution against trolls not against secret services
    -   But very important for the acceptance of
        OpenPGP because the naive user does
        not understand, why emails are not validated

**Open issues:**

-   How to ensure that the validation request is triggered by the owner
    of the key?
    -   To avoid spam DOS
    -   Answer: explicit request by email client that supports this
        approach or by user sending a specific email.
-   Who runs a first validation server?

## Documents / Links / Resources {#Documents_.2F_Links_.2F_Resources}

Initial Proposal:
[https://lists.gnupg.org/pipermail/gnupg-users/2015-July/053971.html](https://lists.gnupg.org/pipermail/gnupg-users/2015-July/053971.html)

Slides: [EmailValidation20151207.pdf](../EmailValidation20151207.pdf)

Whiteboard 2nd OpenPGP Email Summit:
![Whiteboard_of the Email Validation session](../Whiteboard_EmailValidation.png)

## Feedback {#Feedback}

Please send comments and feedback to Nico Josuttis, nico(at)enigmail.net
(Fingerprint: CFEA 3B9F 9D8E B52D BD3F 7AF6 1C16 A70A F92D 28F5)
