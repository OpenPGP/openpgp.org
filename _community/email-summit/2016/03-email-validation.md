---
title: "Summit 2016 Notes - Email Validation"
permalink: /community/email-summit/2016/minutes/email-validation
---

{% include toc %}

This is a summary and outcome of two session of the [3rd Open PGP
Email Summit](..) discussing how to deal with Key/Email Validations.

The topic is a follow-up from
[OpenPGPEmailSummit201512/EmailValidation](/community/email-summit/2015-12/minutes/email-validation).

Some notes about the [Web Key
Service](https://www.ietf.org/id/draft-koch-openpgp-webkey-service-01.txt)
in GnuPG added by aheinecke which could not attend the meeting.

## Terminology {#Terminology}

-   **Key Server**: A server that manages keys
-   **Validating Server**: A server that validates keys
-   **Validated-Keys Server**: A server that only holds validated keys
-   Servers can have multiple roles together
-   **Validation Signature**: A signature that signals a successful
    validation

## Categorizing Key and Validation Servers {#Categorizing_Key_and_Validation_Servers}

Current examples:

|----------------------------------------|-----------------|---------------------------------|------------------------|
|                                        | pure Key Server | both Key- and Validating Server | pure Validating Server |
|----------------------------------------|-----------------|---------------------------------|------------------------|
| doesn't add PGP signatures for signing | SKS             | Mailvelope, Google, WKS         |                        |
| adds PGP signatures for signing        |                 | GMX                             | TNG                    |
|----------------------------------------|-----------------|---------------------------------|------------------------|

Better Table?:

|------------|------------|------------------------------|-------------------|-----------------------------------|
|            | Key Server | only holds keys validated by | Validating Server | adds PGP signature for validation |
|------------|------------|------------------------------|-------------------|-----------------------------------|
| SKS        | yes        |                              |                   |                                   |
| Google     | yes        | itself                       |                   |                                   |
| GMX        | yes        | itself                       | yes               | yes                               |
| Mailvelope | yes        | GMX and ???                  | yes               |                                   |
| TNG        |            |                              | yes               | yes                               |
| WKS        | yes        | itself                       | yes               |                                   |
|------------|------------|------------------------------|-------------------|-----------------------------------|

## Standard Validation Signatures {#Standard_Validation_Signatures}

The discussion went around the topic: **In case** servers validate email
addresses and sign this validation in the key, can we establish an
improved (backward compatible) signature format?

### What informations should standard validation signatures hold? {#What_informations_should_standard_validation_signatures_hold.3F}

So, let's first list what we want to signal with a validation signature
(and see what can we do already with standard
OpenPGP signatures):

|----------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                                  | Currently with OpenPGP                                                                                                                                                                                       Goal                          | How?                                                                                                                                                                                                                                      |
|----------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| What was validated?              | the (person behind a) UID                                                                                                                                                                                                                  | the email address in a UID                                                                                                            new field for the exact email address                                                               |
| How was validated?               | only signature/certification levels ("0: no statement", "1: didn't validate", "2: casual validation", "3: extensive validation")                                                                                                  open lis | of keywords signaling how was validated (e.g. "enc-email-click" for "click on URL after getting an encrypted email")    new field with predefined possible values                                                                         |
| When did the validation happen?  | Currently there is only the timestamp of the signature and an optional expiry date. This can be a problem if the validation happened earlier than adding the signature (e.g. when signing later another key for the same email address).   | A clear statement when exactly the validation happened. An expiry date still makes sense to helkp to filter out expires signatures.   recommendation to always set the expiry date to e.g. 1 year and a new field for the validation date |
| Who validated?                   | defined by the signing key                                                                                                                                                                                                                 | no change here (we still want that trusting a key that represents the validation gives trust to the validated keys)                                                                                                                       |
| Details of the validation policy | Policy URL                                                                                                                                                                                                                                 | no change here (it makes sense to give the ability to add an URL that explains the validation (policy) in details                                                                                                                         |
| ???                              | ???                                                                                                                                                                                                                                        | signed certificate timestamp                                                                                                                                                                                                              |
|----------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

### What general requirements should apply for a standard validation signatures? {#What_general_requirements_should_apply_for_a_standard_validation_signatures.3F}

So, then let's talk about the general requirements for a new format:

-   **Backward Compatibilty:**
    The new format should be backward compatible. That is, we use the
    existing OpenPGP standard for signature
    and just add some supplementary details that would simply be ignored
    by existing clients.
-   **Easy to identify:**
    There should be one common aspect signaling clearly to client that
    this standard extension is used.
-   **Easy to process:**
    It should be as easy as possible to process the additional
    informations.
-   **Easy to extend:**
    Whatever we define in the first version, it should be easy to extend
    the concept without breaking backward compatibility.
-   **KISS:**
    Let's start just with a fist approach, useful for itself and avoid
    to make it too complex by trying to be perfect.

### Initial Proposed Format {#Initial_Proposed_Format}

-   The proposal is to standardize for email validation signatures that
    they
    -   always expire after 1 year (for validation once each year the
        expiry date should be 13 month after validation)
        -   So, setting this expiry date is strongly recommended
    -   always have a certification check level of 2 ("casual
        validation")
    -   use a **signature notation** to provide all missing details

A signature notation is a standard existing (but not so well known)
OpenPGP feature consisting of a key and a
value.
As an example, see among the signatures in
[https://hkps.pool.sks-keyservers.net/pks/lookup?op=vindex&search=0x0B7F8B60E3EDFAE3](https://hkps.pool.sks-keyservers.net/pks/lookup?op=vindex&search=0x0B7F8B60E3EDFAE3):

    sig  exp2  08AB4849 2014-02-08 2015-02-08 __________ Niels Lauken
        Policy URL: http://niels.dest-unreach.be/pgp-key-signing-policy.txt
        Notation data: occasion@niels.dest-unreach.be "Zimmermann–Sassaman based key signing party at FOSDEM2014 on 2014-02-02"

Here the last row is from a signature notation, having

-   the key "occasion@niels.dest-unreach.be" and
-   the value "Zimmermann--Sassaman based key signing party at
    FOSDEM2014 on 2014-02-02"

Has standard signature notation for validated email addresses has:

-   the standard key **validation@openpgp-email.org**
    -   this is what clients would look for to see whether this standard
        is supported
-   as value a Base64 encoded JSON structure with
    all necessary informations
    -   For example:

            {"validation":
             {"validations": [
               { "date": "2014-12-31",
                 "approach": "enc-email-click",
                 "email": "nico@josuttis.de" },
              ]
             }
            }

That is we would standardize the following fields:

| date     | the date of the validation                   | mandatory |
| email    | the email address that was validated         | mandatory |
| approach | approach used for the validation (see below) | mandatory |

For the approach, the following values are defined:

| enc-email-click | sent encrypted email with URL to click on                                                                                                                 |
| enc-email-reply | sent encrypted email, which had to be sent back after decryption with new encryption                                                                      |
| server-owns-key | server owns the email address and the private key (for servers that manage the keys for their users such as company wide key servers for their employees) |
| server-has-key  | server owns email and knows the key because the use uploaded the private key                                                                              |

Open: Something (in combination) with DKIM as
part of the validation?

This is a draft, all is still open for discussion.

## Documents / Links / Resources {#Documents_.2F_Links_.2F_Resources}

-   Whiteboard 3rd OpenPGP Email Summit:
    -   General discussion: Key and Email Validation:
        -   [attachment:EmailAndKeyValidation_20160710_1.png](../EmailAndKeyValidation_20160710_1.png)
        -   [attachment:EmailAndKeyValidation_20160710_2.png](../EmailAndKeyValidation_20160710_2.png)
    -   Standard Validation Signatures:
        -   [attachment:ValidationSignature_20160710.png](../ValidationSignature_20160710.png)
-   WKS:
    -   [Discussion on
        GnuPG-devel](https://lists.gnupg.org/pipermail/gnupg-devel/2016-May/031055.html)
    -   [Draft of the
        service](https://www.ietf.org/id/draft-koch-openpgp-webkey-service-01.txt)
    -   [Some conceptual
        notes](https://wiki.gnupg.org/EasyGpg2016/PubkeyDistributionConcept)

## Feedback {#Feedback}

Please send comments and feedback to Nico Josuttis, nico(at)enigmail.net
(Fingerprint: CFEA 3B9F 9D8E B52D BD3F 7AF6 1C16
A70A F92D 28F5)
