---
title: "Summit 2015-12 Notes - Encrypted Index"
permalink: /community/email-summit/2015-12/minutes/encrypted-index
---

Workshop at [2nd OpenPGP Email Summit, Dec 2015](..) run by dkg.

![Whiteboard_of the Encrypted Indexes session](../Whiteboard_EncryptedIndexes.png)

This are raw notes, they might not be complete and/or too cryptic.

-   mail is base on search
-   3 ways of encidx:
    -   1- dec as you go in your storage
    -   2- index the dec message (index is secure)
    -   3- PIR server side enc queries
-   2 is the only viable
-   How to handle the index:
    -   trusted machine
    -   enc container
        -   separated indx for enc mail
-   you even if the query is secure, but retrieving the emails the
    server could guess it
    -   mixed enc search result retrieval leak
    -   all encrypted search result retrieval leak, too
    -   if you have the whole set of emails locally is fixed
    -   it can solve by fetching more than what you want
-   index could be big, we can accept it
    -   full text index = the size of the mail store
    -   bandwidth is a problem for big syncs
-   3 is expensive in CPU and bandwidth, it can be more leaky to reduce
    that
    -   in the long term the server could guess the content of the
        encrypted index by the relations of emails that are retrieved
    -   we could put the encryted emails in the index, it's not doable
-   single mail
-   lables (tags)
-   free search
-   For a lot of results I don't need to see them, but the MUA loads
    them for when you see it
-   Each client can build the index, less bandwidth more CPU
-   make a bloomfilter for each word, too much computation time
-   the 90s technology solves everything (do anything in the client)
    -   does that work in the smartphone?
-   usability: unlock the secret keys/storage for the whole session
    -   it index when things are fetched
-   We don't need to index encrypted emails, that could be a choice of
    the user
-   clients to think on how to sync and store email storage and index in
    a secure manor
-   the case of separated indx for enc email don't gain much, too hard
    to explain to the user to choose

## about the attacks to on demand fetch {#about_the_attacks_to_on_demand_fetch}

As long as you store emails in the server and you retrieve them on
demand your provider will be able to guess the content of your encrypted
emails. I'll explain it.

Imagine that you have the index in perfectly secure way, or locally
stored or an ideal nifty way in the provider where you can do queries
and the provider can not guess the content of the queries.

Let's first assume that you have your emails stored as they arrive,
your encrypted email is stored encrypted and your decrypted email is
stored decrypted. After each query you retrieve the resulted emails, so
the server sees which decrypted emails are related to which encrypted
ones and in the long term can infer the content of the encrypted ones as
well.

Let's imagine then that you store all the emails encrypted. Then your
provider could send to you crafted emails with the kind of content she
cares about to discover, so it can notice each time you retrieve one of
this crafted emails and what other emails are related to that.

You could minimize this attack by not only fetching the emails that you
care about, but fetch way more. But at the end or you have your whole
set of emails locally or the server will be able to infer data about the
encrypted emails.

## local model {#local_model}

-   store everything in the client side
-   store the entire message archive
-   protect the index
-   pruning strategies (index and messages)
-   protect archive
-   lookaside metadata associated per message, you could store the
    session key of the message so you can decrypt it if you don't have
    the key anymore
