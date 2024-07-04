---
title: "Summit 2016 Notes - Forward Secrecy for Email"
permalink: /community/email-summit/2016/minutes/forward-secrecy
---

DKG:
- no specific proposal, some ideas
- what kind of system is deployable, how do you do discoveries?

Proposal: 
- review how Signal protocol works. Solves the problem well for async messaging.
Proposal:
- forward secure, why do we care? Someone intercepts your messages and later has access to your keys, we don't want them to have access to the content.

DKG:
- in Signal, the two parties generate a shared secret (no asym after communication starts). The shared secret is used to decrypt the current message. When you get a new message, or a suggestion that you should "ratchet" it, then you generate a new key from the old one and then you throw away the old one.

        - S0 -> S1 -> ... (session keys)
           \     \    \
            K0    K1  ... (encryption keys)

- Can't derive S(n-1) from Sn.
- Can't derive S(n) from K(n).
- How can we do Forward secure email?
- Kn keys can be kept without compromising the other keys.

Meskio:
- We already have session keys in OpenPGP.

DKG:
- Your OpenPGP packet has:
        - the Public Key Encyrpted Session Key (that is a SK encrypted with PK)
        - Symmetrically Encrypted Integrity Protected Data.

- Scheme with asym enc (priv/pub key):

        Secret Key---.
        PKESK -------+-- Session Key---.
        SEIPD -------------------------+--- Clear Text.

- Scheme wiht sym enc (passphrase encrypted):

        SESK---...
        SEIPD--...

- Proposal: map forward secrecy scheme to OpenPGP standard.

   - Problem space:
        - Inital handsake
        - multi-device sync
        - per message info
        - multiple people
        - we should think whether the handshake messages should be signed

DKG:
- handshake proposal for OpenPGP+ratcheting FS:
        - first message contains:
            - DHS (diffie-hellman secret)
            - DHP (diffie-hellman public)
        - first response:
            - the other part of the DHP
- after the first email that was not Forward secret the next emails will be forward secretly secured
- disadvantage: the first message is not FS.
- advantage: all other messages are FS.
- If the handshake is compromised, the FS is not compromised because is based on Diffie-Hellman protocol that considers this thread in it's model.

Tankred:
- We could have a key server that stores a bunch of DHP to don't need the first email without FS. The signal approach.

--------------------------------------------------------------------------------------

Dominik Schümann:
- Another proposal: Puncturable encryption
- Interesting scheme, not so much research for now:

           tag=$wid
        A ---------> B
                     sk
                     pk

- for each tag, you do a pk "puncturing", and your pk becomes unable to decrypt messages with the same tag
- your pk grows with time.
- advantage: solves the problem of handshake, in the sense that to implement FS with OpenPGP you need to derive a session key prior to exchange of messages.
- There is the problem of private key growing on each email we care about. You might not need to puncture if it's spam, but that might bring UI complexity.

--------------------------------------------------------------------------------------

Back to the OpenPGP proposal
----------------------------

List of potential UX approaches/problems:
- "opportunistic/parasitic" approach: as you are sending messages, send handshake bits, when you have all handshake bits, start with FS.
- "friend-requests-for email" approach: add two UI features: request private session on one side, accept private session on the other side.

2nd part of discussion started here
-----------------------------------

Multiple parties problems:
- multiple device problem: how to deal with parties that have multiple devices?
      - if using the first message as a handshake, all devices would have to respond to first message before keys are deleted.
      - what is the relation between this problem and the multiple-parties problem?
- in the signal system, they complete the handshake before starting the message exchange.
- when you setup your account yo generate a bunch of pre-keys, and push them to central signal server. When a person wants to send you messages, she gets a pre-key for each of your devices. These pre-keys are not shared with anyone else. When you are running out of keys the server asks you for more keys.

Christoph:
- in the context of email it makes no sense to send automatic email. If it was good, would have been done 20 years ago.
- this would be a silent ping

Moritz:
- there can be other network activity in the context of email (dns, keyserver), but that is different than your mua answering emails automatically.

nico: - I want to able to read all my messages (in a new device)
- there must be a way to read my past messages on old devices
- as long as old stuff is available somewhere that might be ok (in a new device past is convenient, from present to future is a must)
- ongoing communication across different devices, possible? needs to be

- in a single-key per user case, you need to sync the ratchet across devices (but need to sync frequently)
(other case is a key per device, but you risk losing forward secrecy untill all devices are synced).

dkg:
- each peer knows whether theyre initiating FS mode, but starting the ratchet you can signal the user that they wont be able to read the conversation in other devices until theyre synced.

nico:
- what's the target audience for this? needs some understanding that this is something special

dkg:
- parasitic model adds no UX complexity, as long as you dont have multiple devices is ok.

cristoph:
- user is used to not be able to read some mails on some devices.

pre-keys and centralized authority problem. centralized authority has costs:
  1. they can offer the same prekey to multiple people, or
  2. throw it away (and not offer it to anyone).
  3. they can observe who talks to you.

problem:
- adding a new device, make peers know about it.
tankred:
- you're trusting a given provider, it's "accountable".
gary:
- slow mailing is not a great mechanism for signaling.

dkg:
- piggyback the introduction of new device on existing ongoing exchange?

Problem:
  - You either need a pre-key server (different from key server) or frequent synchronization between devices.
  - Which means a new sync per device per contact added.

dkg:
- you have a master device, when that device is not on the network, messages on other devices appear as garbage.
- more or less as whatsapp experience
- seems it is the Facebook approach also.
- better than requiring to go to a public keyserver frequently

moritz:
- signal in your public key, associated with a user id, that if you are communicating with that uid, then i can do a FS exchange.
- only piggyback if you know that they have the capacity.

dkg:
- maybe we can call this Deletable Encrypted Email

meskio:
- is this different than rotating private subkeys every month

dkg:
- there are three approaches:
  - there is the axolotl approach (signal) without a pre-key server.
  - puncturable encryption
  - regularly rotating encryption subkeys
