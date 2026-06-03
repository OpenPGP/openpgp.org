---
title: "GnuPG"
permalink: /about/gnupg/
excerpt: "GnuPG and OpenPGP"
---

On 6th September 2022, [the OpenPGP schism](https://mailarchive.ietf.org/arch/msg/openpgp/PWp3ZcZ_qnDNLhuT-zR7gA2ddeg/) was triggered by GnuPG's announcement that it would implement an earlier version of the draft specification that would eventually become [RFC 9580](https://www.rfc-editor.org/rfc/rfc9580.html), and not the version that was agreed by the rest of the OpenPGP Working Group.
In order to minimise the damage to the ecosystem, RFC 9580 incremented several version numbers from 5 to 6, and changed some other code points to avoid conflicting definitions.

As a result, GnuPG only implements some parts of the current OpenPGP specification:

* [RFC 4880](https://www.rfc-editor.org/rfc/rfc4880.html), the previous major revision of OpenPGP.
* [RFC 5581](https://www.rfc-editor.org/rfc/rfc5581.html), which specifies the Camellia cipher in OpenPGP.
* [RFC 6637](https://www.rfc-editor.org/rfc/rfc6637.html), which specifies elliptic curve cryptography in OpenPGP.
* [Brainpool and 25519Legacy curves](https://www.rfc-editor.org/rfc/rfc9580.html#name-ecc-curves-for-openpgp), which are also included in RFC 9580.

Instead of the remainder of RFC 9580 however, it implements several novel formats that do not correspond to any OpenPGP specification, most of which are not supported by any other software.

GnuPG does not make clear in its UI where it diverges from OpenPGP, and many of its users are unaware that recent versions produce non-standard formats by default.
Several efforts are underway to work around the resulting incompatibilities.
For example, most Linux distributions ship GnuPG with the [FreePG patch set](https://freepg.org) that disables non-OpenPGP formats by default.
Many of them are also actively migrating away from GnuPG to OpenPGP-compliant software in their packaging systems.

## Further Info

* [A Critique on "A Critique on the OpenPGP Updates"](https://blog.pgpkeys.eu/critique-critique.html)
* [Changes between rfc4880bis and crypto refresh](https://mailarchive.ietf.org/arch/msg/openpgp/aqBy97lj2P4DVxTds0eKZDVdmms/)
