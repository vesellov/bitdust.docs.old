# BitPie.NET


## Table Of Contents
* [Introduction](#Introduction)
* [Download](download)
* [Setup](install)
* [Commands](cmdline)
* [Settings](settings)
* How it works
  * [Glossary](glossary)
  * [User Authentication](identities)
  * [Distributed storage](storage)
  * [Data protection](security)
  * [Automatic data recovery](rebuilding)
  * [Distributed hash-table](dht)
  * [Transport protocols](transports)
* Development
  * [Finite Automata](automats)
  * [Network Services](map.html)
  * [API interface](api)
  * [Changes log](changelog)
  * [Development plans](roadmap)
* [About Us](about_us)


## Introduction

BitPie.NET is the decentralized and protected online storage constructed in such a way
that only the owner of data has access to it.

Imagine that you and two your friends agree to store data for each other.
On your personal computer you store data which both of your friends uploaded to you through the Internet,
and you in turn have opportunity to use space on their computers. This method creates redundancy,
but allows storing important information more reliably. It is the fair deal because
all three are interested in the maximum reliability and availability of the stored information.

The BitPie.NET network is a voluntary association of people for the purpose of sharing resources
their personal computers. Identical copies of the BitPie.NET software are started
on computers of all users - this provides interaction of nodes with each other through the Internet.
This is a fully peer-to-peer network - all data are transferred directly from one node to another
and stored on the local hard drives. 

When data are loading into the network the source files are archived and divided into blocks and fragments.
All blocks are encrypted and digitally signed with user's private key  - all data transferred
over the BitPie.NET network is absolutely secured.
The system is designed in such a way that will constantly monitoring of each node which stores your data.

The BitPie.NET program constantly supports a state at which you at any time can download your data back.
The mechanism of automatic data rebuilding allows to dynamically reconstruct the missing fragments
of data downloaded in the network on new nodes without any actions from user.

The BitPie.NET software is written in [Python](http://python.org) using pure
[Twisted Framework](http://twistedmatrix.com) and distributed in open source under a
[proprietary license](http://bitpie.net/license.html).

