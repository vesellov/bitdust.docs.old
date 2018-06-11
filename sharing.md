# Shared data

* [Intro](#intro)
* [Master Key](#master-key)
* [Shared keys](#shared-keys)
* [Grant access](#grant-access)
* [Audit access](#audit-access)
* [Receiving shared keys](#receiving-shared-keys)
* [Reading shared data](#reading-shared-data)


## Intro

The main goal of the BitDust project is to create such an environment for the user, in which he would have full control over his own data and communication channels.

However, in a world where people talk to each other via "black mirrors" more and more often, it is impossible to remain completely isolated in a such digital environment. In other words, we simply need to be able to work not only with our own data, but also with data coming to us from outside.

So another very important goal of BitDust project is to create alternative ways to exchange digital data between users that will enable a higher level of privacy and control over such "common" or "shared" data.

This article contains detailed information on how to control and provide access to your own data to other users of BitDust software.


## Master Key

Since every piece of your personal data in BitDust network is stored on the machines of other users, it is always encrypted before leaving your computer - the method of protection is described in detail in the article [Data Security](security.md). Your main private key, here and below, we will refer to it as a "Master Key", used to encrypt and decrypt your personal data for storing on supplier machines.

For your personal safety, you should make a backup copy of the Master Key in a safe place immediately after installing BitDust on your device. In any other cases, the Master Key should never leave your device and under no circumstances should be transferred to anyone else. Only Master Key protects your personal data and access to the BitDust network.


## Shared keys

In addition to the Master key, there are other private keys in BitDust that you can use to work with the data. BitDust software implements extra logic to use same cryptographic methods but to make it possible to work with many different keys, which the user can use at any time by his own choice and completely under full own control.

Using additional private and public keys in BitDust is very similar to real life actually - how you use a regular keychain that you lock/open the doors in your house. For example, if a new guest, your good firend, visited your place and you would like to settle him in one of your rooms, you will probably give him a copy of the key you have on the chain to be ably to unlock this room. but you will also leave the original key for yourself. Thus, both you and him will have access to the common space of the guest room. However, in your house, for example there may be another safe place for storing family documents or valuable things or a "private" room, and you never give the key to that place to anyone.

In BitDust software you can at any time create a new additional private key and use it to encrypt some data that will be uploaded to your suppliers's machines. The data is stored in a distributed way, just as it happens when you encrypt it with your Master Key - this is described in detail in the article [Data Storage](storage.md), but you just switched from Master Key to the additional key when you are doing encryption.

Later, you can transfer this additional key to another user who you trust and he will have the ability to download this particular piece of data and decrypt it on his own device. Thus, we can exchange personal data with each other and at the same time our suppliers only helps us during this process, but do not have access to data directly. Finally it makes our digital life depend on the "crowd" instead of single "service" provider. 

With BitDust software, you can perform the following actions with your additional keys:


* create a new key by giving it a name and store locally
* create a new key with a randomly generated name
* delete an existing private key
* backup and store the keys on your suppliers - will be encrypted with your Master Key
* send the public part of given key to another "un-trusted" user
* send the private part of given key to another "trusted" user
* view a list of all keys: created by you or received from other users
* perform "audit" process of given public key and verify that another user also posses exactly same copy of that public key
* perform "audit" of given private key and verify that another user also posses exactly same copy of that private key
* use a private key to encrypt data downloaded to the BitDust network
* use a private key to decrypt data downloaded from the network


You will find your additional private keys in the `.bitdust/keys` folder,
currently BitDust software is using [RSA algorithm](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) which is widely used in the World.
Those methods was implemented using [PyCrypto](https://pypi.org/project/pycrypto/) library.



## Grant access

When transferring an additional key from one user to another, one of the text files from the `.bitdust/keys` folder is actually sent to the remote recipient's machine. The key is not transmitted in plaintext but it is encrypted using the public part of Master Key of the recipient before sending - only "trusted" user will be able to decrypt this text file and get a copy of the transmitted additional key. The BitDust program on his machine will receive the key and save it in the new text file in the `.bitdust/keys` folder. Then the user will be able to use it to work with the "shared" files.

It is important to understand that this action is "irreversible"! You can not "take" the key back after you handed it to your friend, because only he controls his operating system and BitDust software running on his device. In fact, after you have passed the key to another user - both of you are almost completely are "fully equal" owners of the data that was encrypted with that additional key.

We say you both posses "almost equal" ownership because the data is stored on your suppliers, but not his suppliers. So you have always "more rights" inside your own distributed storage than anyone else. For example, at any time you can requst your suppliers to delete this piece of data and by default they will do it for you.



## Audit access

The most important role of the supplier is to store and provide access to the files to you and other users, in fact it must be siad that way: "to make possible to download the fragments of the file at any time by authorized request". To acheive this, each supplier must have specific instructions and well-defined order of actions that he must perform at the time of the request to the distributed "shared" data on his device from you or a "trusted" user. Since all data that the supplier stores is encrypted, even if he is an "intruder" and "gives away" pieces of your data to everyone in a row without any control, you can still be calm - only those who posses the right key will be able to "read" your files.

However, the BitDust software implements methods for filtering and validating such "access requests" to all data uploaded to the network - by default the supplier will "check" that the one who requests the piece of data does have the right additional key to decrypt the data. He must "audit" the user's key, which refers to it. To do this, he must keep the public part of the key, which was used to encrypt the data. This public key is usually received from you, exactly at the moment when you grant access to the data to the "trusted" user.

To keep it short, below is the general plan implemented in BitDust software which executes on your device when you transfer one of your additional keys to another user:


1. checking the connection status of the trusted user's computer
2. audit of the master key of the trusted user
3. sending the public part of the additional key to all your suppliers
4. forwarding the private part of the additional key to a trusted user
5. forwarding a list of file names that have already been encrypted with this additional key to a trusted user



## Receiving shared keys

In the previous paragraphs, we described a methods for transferring access rights to your data to another user who you trust. Next, you will find a detailed info about what happens on his device and how he can use the additional key he received from you to download "shared" data to his device.

It is assumed that the BitDust program  on both devices is already running and connected to other nodes of the BitDust network at the time of the transfer of an additional key was started. In case when "donor" or "recipient" was not connected to the network and did not have the opportunity to directly exchange service packages via BitDust "channels", the process will fail and no access will be granted at all.

BitDust on the machine of the "trusted" user is constantly in a waiting state to receive incoming service data packets and is always ready to accept a new incoming access keys. After receiving and decrypting the file with the own Master Key, it will be stored in the `.bitdust/keys` folder. You can always find out the full list of all access keys have been passed to you from other users - each key has a unique global identifier that looks like that:

        share_0780f0d64b017303a0d81865eee009f1$veselin_penev@some-id-hostname.net


The initial part of the identifier before the character `$` is called "key alias" and serves to identify a particular key among a set of additional keys created by this user. The second part after the `$` character is the unique global identifier of the user who first generated the key. For more details about the identification of users in the BitDust network, you can read in the article [User Identification](identities.md).

This method of identifying access keys always uniquely defines who is the creator of the data and on whose suppliers the encrypted fragments of files in the BitDust network are actually stored. In other words, having received a new access key from someone, you always know where the "shared" files are located.



## Reading shared data

So to access the "foreign" files, you need to use the key identifier to determine the "location" of the data. We use the word "location" in a figurative sense, since all data is stored completely distributed on the suppliers' machines. For downloading fragments of files and decryption, it is necessary to determine the current active suppliers, connect to them and request all the fragments of data related to that given "common" file.

In BitDust, the list of your suppliers is stored and maintained not only on your own device, but also in a distributed hash table - your suppliers automatically support and periodically update these "globally distributed" records. Thanks to this, any user always has the ability to "scan" the list of your suppliers and find out where he needs to go to download those files to which you "opened access to him." The process of "scanning" that list takes some time, depending on the number of your suppliers. In more detail, you can see how BitDust uses these service records in the article [Distributed Hash-table](dht.md).

After connecting with the "foreign" suppliers, you can request them the necessary pieces of data related to a particular "shared" file. If the access key you received from the "donor" is valid, "external" suppliers will accept your request and BitDust software on your device will receive needed fragments, decrypt, combine into one chunk and create exactly same copy of "shared" file which "donor" granted you access.



<div class=fbcomments markdown="1">
</div
