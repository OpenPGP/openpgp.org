---
title: "History"
permalink: /about/history/
excerpt: "History of OpenPGP"
modified: 2016-08-15T15:00:00-00:00
---

OpenPGP is a non-proprietary protocol for encrypting email using public key cryptography.
The OpenPGP protocol defines standard formats for encrypted messages, signatures, private keys, and certificates for exchanging public keys.

It is based on the Pretty Good Privacy (PGP) freeware software as originally developed in 1991 by [Phil Zimmermann](http://philzimmermann.com).
For that, he was the target of a three-year criminal investigation, because the US government held that US export restrictions for cryptographic software were violated when PGP spread all around the world following its publication as freeware.

Despite the lack of funding, the lack of any paid staff, the lack of a company to stand behind it, and despite government persecution, PGP became the most widely used email encryption software in the world. After the government dropped its case in early 1996, Zimmermann founded PGP Inc.
That company and its intellectual property were acquired by Network Associates Inc (NAI) in December 1997.
NAI continued to own and develop PGP products for commercial and freeware purposes.
In 2002, NAI discontinued development and sales of PGP, and sold the rights to it to a new company, PGP Corporation.

OpenPGP is the open standards version of NAI's PGP encryption protocol.
The OpenPGP Working Group is seeking the qualification of OpenPGP as an Internet Standard as defined by the IETF.
Each distinct version of an Internet standards-related specification is published as part of the "Request for Comments" (RFC) document series.

OpenPGP is on the Internet Standards Track and is under active development.
Many e-mail clients provide OpenPGP-compliant email security as described in RFC 3156.
The current specification is RFC 9580 (August 2024), the successor to RFC 4880.
RFC 9580 specifies a suite of required algorithms consisting of X25519, Ed25519, AES-OCB, and SHA2-256.
In addition to these algorithms, the standard recommends X448, Ed448, AES-256, SHA2-384, and SHA2-512
Beyond these, many other algorithms are supported.

As far as we know, [intelligence organizations aren't able to break it](http://www.theverge.com/2014/12/28/7458159/encryption-standards-the-nsa-cant-crack-pgp-tor-otr-snowden).

Learn more about the technical specifications of OpenPGP on our [page about the standards](/about/standard/).
