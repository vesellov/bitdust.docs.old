# User Indentification


* [Identity files](#identity-files)
* [ID-servers](#id-servers)
* [IDURL address](#idurl-address)
* [Digital-signature](#digital-signature)
* [Private key](#private-key)


## Identity files

For other nodes to connect to the user machine they have to know the address of his computer in the Internet. These contacts are stored in XML file, which is called __Identity__. By connecting to other nodes the download of identity files preliminarily takes place and then received information is used for direct transfer of service packets. 

In the user identity file the following information is stored:

* contact data of network protocols for connection with his machine 
* open part of user personal key 
* digital-signature for protection from modifications of file content
* a list of IDURL addresses in the Internet by which the file is available
* date of file creation
* version of BitDust software run on users computer

For BitDust network logon each user needs to create a personal identity file – this happens automatically whem the BitDust program starts first time.


## ID-servers

In theory the location of user identity file can be of any kind, important about it is to be easily accessed for all other nodes in the network. For example, user can allocate the given file on his personal website. By doing so he needs to assure the possibility of easy update of the given copy from the original, which is stored on the machine of the user himself. For guaranteeing a more secure and fault tolerant interaction between nodes in the network you can store multiple copies of your identity in several places. 

This kind of storage is done with the use of multiple machines also called ID-servers or Identity servers, where copies of all identity files are kept. These servers can be started on the machines belonging to BitDust LLC, as well as in those of the network users themselves or third parties of their own free will. 

ID-server functional is the part of BitDust program, but by default is turned off in the program settings. If required each user can turn on this option himself and start such a server on his computer – it will be automatically initiated by BitDust program start. Server launch will influence the computer resources consumption insignificantly, but will allow you to support other nodes and increase total fault-tolerance of whole BitDust network. 

It is preferably that machines running ID-servers had correctly adjusted domain names. Then users’ IDURL, whose identity files are stored there, will look attractive. Bellow you can read more about that.
 

## IDURL address

Each BitDust user is identified by IDURL key – this is an address of his identity file in the global Internet network. One can draw an analogy: identity file is kind of a regular passport and IDURL is his last, first and middle names.

IDURL looks like this:

    http://p2p-id.ru/alice.xml
 
And the identity file itself has the following look:

    <identity>
    <contacts>
      <contact>tcp://123.45.67.89:7771</contact>
      <contact>udp://alice@p2p-id.ru</contact>
    </contacts>
    <sources>
      <source>http://p2p-id.ru/alice.xml</source>
      <source>http://megafaq.ru/alice.xml</source>
    </sources>
    <certificates/>
    <scrubbers/>
    <postage>1</postage>
    <date>Sat Dec 13 14:08:36 2014</date>
    <version>
      sources Linux-3.11.0-15-generic-i686-with-Ubuntu-12.04-precise
    </version>
    <publickey>
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgGcYwhNipj6yJyEaD77qLNrJ ...
    </publickey>
    <signature>
      1557824826897671730886854628410961132377100189021332866347553795 ...
    </signature>
    </identity>

Each identity file can have several copies, stored on different servers – for ensuring fault-tolerance of users identification in the BitDust network. Thus each node can have several IDURL addresses, identifying it.

User has a chance to create an authentic identifier in the BitDust network – for example, starting an ID-server at the hosting of his site and allocating there his personal identity file. For instance: 

    http://veselin-penev.com/id.xml
    
It is not necessary to have a domain name to run an ID-server. In that case your id may looks like that:
   
    http://123.45.67.89/id.xml
    
For some reasons this may be preferable - if you do not wish to depend on global DNS providers.

The system is designed in such a way that even in case of failure of one or more servers that store your Identity file, other users can download it from other ID-servers and able to connect with you. The program continuously monitors your ID-servers and in case of failure triggers automatic distribution of your Identity file on another available ID-servers, and notifies your active nodes immediately.


## Digital signature

By creating or adjusting users identity the generation of digital-signature takes place – it is connected to the file content and serves for protection from evil modifications from third side. Digital-signature is calculated from the file content via Hash-function and for its creation you need a Private Key, which is stored only on his machine.

The general principle of security of user identity from adjustment is based on the fact that all other nodes necessarily check the digital-signature and file content accordance each time they get a new copy of its identity – this is a standard method in cryptography called `VerifySignature`.

This framework helps absolutely safely store and distribute user identity files through any sources, which include also ID-servers. Machine owner, who started an ID-server, does not have any possibility to substitute content of stored there files. But he can easily delete them or turn off the server – for loss prevention identity file of each user is stored on several servers all over the world. 


## Private Key

By first start of BitDust program the private key is generated, this key protects identity file and your personal  data. Only having this key one can get an access to the personal user data or make adjustments to the identity file.

In BitDust you cannot find any common schemes or methods of user authorization:
 
* not using the password
* not via email address
* no account recovery through answering secret question
* no calling support team
* no centralized storages of member accounts

#### ATTENTION!!!
    In case of losing private key the user completely loses access to all uploaded files. 
    It is highly recommended to make two or three copies of secret key on reliable and 
    compact media just after the program set up and hide them in secure places.

The user is individually responsible for security of his private key. Secret key should NEVER leave the computer on which it was generated – this directly influences the security of your data.

We recommend using modern anti-virus software, extra defence from network attacks and other methods of increasing security level of your personal computer. In addition to this, we advise you to look through useful information resources on this topic in order to raise your awareness. 


===

[Table of contents](https://github.com/vesellov/bitdust.docs#bidust)