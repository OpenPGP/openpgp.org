---
title: "Summit 2016 Notes - Key Discovery Comparison"
permalink: /community/email-summit/2016/minutes/key-discovery
---

{% include toc %}

# Key Discovery Comparison {#Key_Discovery_Comparison}

dkg:

-   would like to have a chart with:
    -   different mechanisms for key discovery
    -   different problems/use-cases/advantages/concerns that might be
        relevant
-   start with listing?

## Properties {#Properties}

-   Passive versus active discovery: whether the lookup is initiated by
    the person who discovers the key. (Passive or Active)
-   Talks to a third party: whether it is divulging the email address to
    a third party (No, Provider or Yes)
-   Central authority: are there centralized authorities for queries?
    (No, Federated or Yes)
-   Network protocols
-   User invisibility: can you hide the look up from the user? (Yes, No)
-   User interaction: is user interaction required? <--- ignored for
    now
-   Delay: how long is the delay
-   Ambiguity: whether it is possible to get more than one key upon
    lookup.
-   Revocation discovery: can the sender see if a key has been revoked?
-   Append-only: property of the mechanism
-   Consistent global view
-   Cacheability: can you get the same trust properties over a proxy?

## Mechanisms {#Mechanisms}

-   Key in email as attachment
-   .well_known HTTPS lookup (standardized
    transformation to get lookup address) by email address
-   DANE
-   Keyserver lookup (SKS pool)
-   Mailvelope Keyserver
-   Symantec Global Directory
-   Keybase
-   Google's Key Transparency (CONIKS)

## Comparison chart {#Comparison_chart}

| Properties Mechanisms | key-in-email | well-known | DANE  | keyserver | mailvelope | symantic | keybase | CONIKS |
|-----------------------|--------------|------------|-------|-----------|------------|----------|---------|--------|
| passive/active        | P            | A          | A     | A         | A          | A        | A       | A      |
| talks to 3rd party    | No           | Provider   | Pr    | Y         | Y          | Y        | Y       | Pr     |
| central authority     | No           | No         | No    | No        | Y          | Y        | Y       | N      |
| network protocols     | SMTP         | HTTPS      | DNSec | hkp/hkps  | https/hkps | LDAP     | HTTPS   | HTTPS  |
| user invisibility     | Y            | Y          | Y     | Y         | Y          | Y        | Y       | Y      |
| user interaction      |              |            |       |           |            |          |         |        |
| delay                 | 1 round trip | TCP        | UDP   | TCP       | TCP        | TCP      | TCP     | TCP    |
| ambiguity             | N            | N          | N     | Y         | N          | N        | N       | N      |
| revocation discovery  | ?????        | Y          | ?     | Y         | N          | Y        | ?       | ?      |
| append-only           | Y            | Y/N        | N     | Y         | N          | N        | ?       | Y      |
| consistent-globalview | N            | N          | N     | N         | N          | N        | N       | Y      |
| cacheability          | N            | Y          | Y     | Y         | N          | Y        | ?       | Y      |

