Переводчик
Отключить моментальный перевод
# DusTalk - Distributed chat / messenger AV / conferencing


* [Introduction] (# Introduction)
* [Features] (FEATURES)
* [Authentication and Authorization] (#-Identification and Authorization)
* [Data Transfer] (# Transfer data)
* [Network Resources] (# Resources Network)
* [On-line store] (# On-line-store)
* [Contact List] (# contacts list)
* [Access to personal data] (# access-to-personal-data)
* [Access Group] (# Access Group)
* [Availability] (# Availability)


<a class=hlnk id="Vvedenie"> </a>
## Introduction

At the moment, there is a wide range of programs for instant messaging, live connection with streaming audio and video, as well as the entire organization of videoconferences, simultaneously for many participants. The vast majority of these solutions using classical methods of user authentication and dedicated servers for the organization of these services.

Architecture [project BitDust] (toc.md) allows for a fundamentally different solution for the organization of communication between people via the Internet. Thanks to a fully distributed network structure BitDust may implement a more secure, private and anonymous communication.

Fully distributed on-line messenger DusTalk will have a number of benefits and features that can not be realized on the basis of a centralized or partially distributed architecture - they arise precisely because of the design and architecture of the entire network BitDust, on the basis of which the product will be realized.


<a class=hlnk id="Osobennosti"> </a>
## Features

+ Entrance to the network without a password
+ Authentication with a secret key
+ Electronic signature protects your identity on the net
+ Encrypt all outgoing data
+ Protection against eavesdropping - flow distribution at many sites
+ Obfuscation traffic
+ Decentralized storage of correspondence history, contact list, avatars, etc.
+ Secure transfer of files / folders directly between devices
+ Possibility of separating the single data stream into many nodes
+ Decentralized storage and exchange of shared files
+ Keychain, access to personal data with many devices
+ Group work, individual secret key to protect all members of the group
+ Fully decentralized search for public information
+ Distributed in source code in Python
+ Cross-platform software - run nearly any device


<a class=hlnk id="Identifikatsiya-i-avtorizatsiya"> </a>
## Identification and Authorization

The project BitDust used the so-called [identity] (identities.md) files to identify users in the network and store key performance information. It's public files that are freely available over the Internet and can be placed in the clear on many sources.

To create and change the identity file, the user must be in possession of [private key] (glossary.md # Private Key), which protects its identity on the network, and all the personal data. This key is generated when you first start the program BitDust on this unit and never leave.

Other members of the network, with which contact was established, will always check user identity file during data transmission - it is protected by a digital signature, which eliminates the possibility of forgery or substitution of identity.

Quite often when communicating people do not want to be recognized and recorded in the central services under false names and addresses. This allows you to hide your personal information from other users, but not from the creators of service - they usually have access to the correspondence history, list of contacts, can monitor network status, IP address, the user's machine, etc.

To enter and identify BitDust network, the user is not required to provide any personal data, email etc and phone numbers, etc. When you first start the program BitDust and generate a secret key only need to specify a shorter nickname (his nickname), which may contain only Latin characters, numbers and symbols "-" and "_". Your global identifier in the network BitDust will be drawn from this alias and overhead information - is the global address of your personal identity files on the Internet.

The mechanism of self-signed identity file creates a more reliable and secure authorization and identification of users than the classic access to the personal account on a dedicated server through a secret password. Methods of protection of personal user data used in BitDust project provides complete independence from any companies, organizations or structures that usually take on this responsibility.


<a class=hlnk id="Peredacha-dannyh"> </a>
## Data transfer

Quite often, in the process of live communication over the Internet, it becomes necessary to quickly send a file or folder to your interlocutor. This feature can be easily added to DusTalk, because BitDust kernel already has all the necessary functions for streaming via secure channels.

Can be simply drag the file to the interlocutor of the system conductor avatar and then begin transmitting data. The caller will be able to save the file on your local disk and open it from the data transfer is complete.

BitDust network consists of a plurality of peer nodes that communicate directly with each other on the [encrypted and protected] (security.md) channels. Before the transfer of useful data, both nodes produce digital signature verification and exchange keys for encryption channel. Thereafter, data is transmitted via [network transports] (transports.md), which use standard TCP / IP protocol means: TCP connections and UDP packets.

In some cases, the data can not do without the use of intermediate nodes - where users' computers are behind symmetric NAT with a complex scheme of allocation of port numbers. With this data transmission mode, the intermediate nodes that "retransmit" traffic still does not have any access to the data channel, since it is encrypted. Such intermediate nodes are called "bystanders" and matched statistically randomly and constantly, with random time intervals, made them change - this allows you to negate the probability of "wiretapping" channel.

Advanced software module for hiding the real IP address of the node in the network can be switched on. This will be done similar to "bulbous" encryption in the network [Tor] (https://www.torproject.org/), which uses random intermediate nodes to mask the true address. In fact, the user can be identified only by impersonal "nickname" and calculate its real location will be extremely time-consuming task.

To protect against external "wiretapping" when intermediate nodes are analyzed and statistics collection encrypted traffic can be enabled "obfuscation" of outgoing traffic. In this state, the payload will be "mixed" with a random binary stream and will be visible from a continuous stream of encrypted data, without any possibility of analyzing and evaluating its content.

Another interesting possibility, which can very easily be added to BitDust core, is the separation of data flow between you and your interlocutor into several parallel streams, which are transmitted through different "bystanders" - intermediate nodes forwards traffic like a Proxy-server. At the final assembly of your interlocutor all parallel streams will be combined again into a single data channel, which when deciphered will recreate on the local disk file that you transferred.

Each of "passers" will receive only a single part of the encrypted data stream, and even being "infected" node will not be able to benefit from it or what critical information: to collect statistics or analyze the flow itself.

Due to the security of all communication channels, which are transmitted in the useful data BitDust network, each transfer will be completely safe. In the settings you additional services for traffic obfuscation and anonymization of all the connections within the network BitDust can be included, so that you and your partner get the most secure and private channel for communication.


<a class=hlnk id="Resursy-seti"> </a>
## Network Resources

Each device that is running BitDust program, is a full member of the network and acts in two directions:

+ Receives resources from the network and use other sites for their needs,
+ A portion of their resources and supports BitDust other network participants.

In the program settings, each user has a flexible configuration [network service] (\ services.md), which govern the provision and consumption of network resources:

+ Hard disk space,
+ Processing power,
+ Network channel.

When you first start the program on your device, you are prompted to use the automatic setting depending on the device type and user preferences. This makes it possible to optimize the whole network and identify specific roles for nodes:

+ Consumers
+ [Keepers] (storage.md),
+ [Cleaners] (rebuilding.md),
+ Passers-by.

For example, it will allow mobile devices to easily start the program only in the mode of consumption and work to a minimum. While the PC and server machines often operate on the "idle" and can be configured to transmit part of its resources to the network continuously.

At this stage, the participation in the network is completely free and takes place entirely on the goodwill of the users themselves. But in our plans is to build on the basis of its own cryptocurrency, a mechanism for direct benefit to those sites that give the network more resources than they consume. For example, the user's computer will produce more kriptomonet if it is significantly involved in the network and supports multiple nodes:

+ Store their data,
+ Helps recover lost blocks,
+ Relays encrypted traffic to other nodes.


<a class=hlnk id="On-line-hranilische"> </a>
## On-line store

Each user can use the other members of the network to accommodate the devices on their personal data, such as:

+ List of contacts,
+ History of correspondence,
+ Users avatars,
+ Personal settings,
+ Downloaded files in a network,
+ Files received from other users,
+ And other information.

Units that hold other people's files called [the guardians] (glossary.md # Guardian). At their hard drives keepers allocate a fixed quota that can be used by other members of the network BitDust. This quota is called [given away space] (glossary.md # Suggested as space-keeper) - it specifies the maximum total size of all files that can be uploaded to the computer of the other nodes in the network, and is installed in BitDust program settings.

Those users who use the services of custodians, called [clients] (glossary.md # client) or consumers. the client node determines in advance the amount of space that he wanted to stay at your personal data and makes the selection of guardians, using this value. BitDust allows you to dynamically change the size of the [space needed] (glossary.md # requested space-client) and produces a reconnection with the new custodians.

During the initial setup of the list [keepers] (storage.md), created and maintained by open networked data links with each of these nodes. It allows you to instantly begin receiving / transmitting information and significantly speeds up the overall process of interaction between nodes in the network BitDust.

All customer keepers are organized in a special way - they are organized in a structure like [the RAID array] (rebuilding.md # RAID-conversion) and use the [self-correcting code] (rebuilding.md # ECC-code) with [double redundancy] (storage.md # The redundancy of data). Those keepers, with whom, for whatever reasons, a permanent connection is lost, replaced by fresh, and started the process [Automatic Data Recovery] (rebuilding.md). Fragments of encrypted data blocks available allow keepers to restore the lost fragments and recreate them on the new guardian - all BitDust program executes automatically and protects the data downloaded to a distributed repository.

Each keeper holds only a fraction of the total volume of data uploaded and hosts the files that were previously encrypted on the client machine - it does not have access to them. All nodes are constantly checking the digital signature in communication. Keeper "give" the stored files only to the owner or user of the data, which has access to the group.

In fact, in BitDust downloaded data network, completely lose their integrity, we call this process of "disintegration" of the data, and can restore them only by the user using his private key - there is no other way to read or modify the data.


<a class=hlnk id="Spisok-kontaktov"> </a>
## Contact list

The project uses BitDust [distributed hash table] (dht.md) for data storage, which should be accessible to all network members. Each device that is running BitDust program may be a node in a DHT network and service store data about other users in the form of pairs (key, value). Due to such characteristics as the distribution of DHT, scalability and fault tolerance access to the hash table is quick enough and weakly depends on the size of the entire network.

There are already working the search engines that use DHT network to store global search index and provide convenient service to search for information, for example [YaCy] (http://yacy.net/) and [FAROO] (http: //www.faroo. com /). Currently this technology already has a variety of uses and there are many implementations of the most DHT network. BitDust core includes a software module that implements the DHT network library resources [Entangled] (http://entangled.sourceforge.net/) - the source code is incorporated into the source code BitDust and distributed together.

At the moment, through the distributed hash table, BitDust program enables simple search users across the network, which indicated his nickname (pseudonym) in the application settings on your device. The whole process is almost identical to the search for contacts in any other messenger - you just need to drive into the search bar nickname of another user and click on the search button. A DHT network will request to the global index, and will obtain a unique device identifier of the desired user, which indicates its identity file.

After receiving the official information of the identity of file necessary to create a secure data channel, creates a constant connection between the user and can immediately be initiated their communication. The program BitDust constantly maintained an open TCP connection or UDP active session with each user from contact list. This allows for instant launch of video / audio streaming, messaging, file transfer, etc. - Without any delay for the initial setup.

User Keepers are used for secure storage and access to the contact list, chat history, avatars, personal settings, loaded into a distributed storage files and other private information. Due to the architecture BitDust network, the data is fully protected and accessible only to the user. Once downloaded on the device keepers, they lose their integrity and do not exist physically - only the owner, with a valid private key in hand, can download all of the pieces and restore them to their original form.


<a class=hlnk id="Dostup-k-lichnym-dannym"> </a>
## Access to personal data

Quite often it is convenient to have access to personal data stored in on-line services from different devices. For example, uploading to the network of the working documents from the office computer, you want to make some changes already out of the house, with your personal computer.

In BitDust network each device has its own [unique ID] (identities.md # IDURL-address) and is protected by a secret key that was generated and made available only on that device. Only the secret key to protect access to personal user data loaded into the device with BitDust network - it must be protected as much as possible and should not leave this unit under any circumstances.

However, the owner of the device can make a backup copy of your private key and store it in a safe place. In this case, it will be able to regain access to your personal data in case of damage or loss of the device.

A self-signed identity files in a project can be implemented BitDust access their personal data from various devices - with each of them will be protected by its own private key and will enter with its own unique identifier of the network. The so-called "keychain", will bring together in a single group of several devices. All other members of the network are properly authorize any of them, and provide access to the data, even though they will be identified separately.

For example, consider the case where you need to combine access to personal data from your home PC and the tablet:
















































Переводчик Google для бизнеса –Инструменты переводчикаПереводчик сайтовСлужба "Анализ рынков"
О Переводчике GoogleСообществаМобильная версия
О GoogleПравила и принципыСправкаОтправить отзыв
