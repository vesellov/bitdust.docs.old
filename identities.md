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


## IDURL address

Each BitDust user is identified by IDURL key – this is an address of his identity file in the global Internet network. This identifier is related to device running BitDust software, but not to person who managing this device. Only by using Private Key stored on that device you can change your identity in the network.


IDURL looks like this:

    http://first-machine.com/alice.xml

 
And the identity file itself has the following look:

    <identity>
    <contacts>
      <contact>tcp://123.45.67.89:7771</contact>
      <contact>udp://alice@first-machine.com</contact>
    </contacts>
    <sources>
      <source>http://first-machine.com/alice.xml</source>
      <source>http://server-two.net/alice.xml</source>
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


It is preferably that machines running ID-servers had correctly adjusted domain names. Then IDURL identifiers of the users, whose identity files are stored there, will look more attractive.
    
But it is not mandatory to buy a domain name to run your own ID-server. In that case ID files on your host may look like that:
   
    http://123.45.67.89/id.xml

    
For some reasons this may be preferable - if you do not wish to depend on global DNS providers.

The system is designed in such a way that even in case of failure of one or more servers that store your Identity file, other users can download it from other ID-servers and able to connect with you. The program continuously monitors your ID-servers and in case of failure triggers automatic distribution of your Identity file on another available ID-servers, and notifies your active nodes immediately.


## Hosts rotation

Periodically software will trigger a methods to check and propagate your identity file to other nodes. Before it starts it can switch your current "primary" ID-server to another one - another ID server will be found and your identity file will be sent to that host. Your main global IDURL address will be changed because new server will be placed on first position under `<sources>` tag, for example:

    <identity>
    <contacts>
      <contact>tcp://123.45.67.89:7771</contact>
      <contact>udp://alice@host3.org</contact>
    </contacts>
    <sources>
      <source>http://host3.org/alice.xml</source>
      <source>http://first-machine.com/alice.xml</source>
      <source>http://server-two.net/alice.xml</source>
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


Final IDURL will be updated:

    http://host3.org/alice.xml


Both IDURLs are pointing to same device now, but we only switch the main location of your identiy file - to be used by all other nodes who is talking to you. To do that software will "propagate" your new identity file to all of your currently active contacts. Also it will update copies on ID-servers you are using already: "first-machine.com" and "server-two.net".

Software will try to keep you "nickname" unchanged, for example if "host3.org" server already stores another "alice.xml" file signed with another public key it can not be used by you, because this name is already taken.

We expect regular BitDust user to be able to spawn own ID-server easily - we need a lot of "hosters" in the network to be able to operate in the network in reliable, private and safe way.

BitDust software running on your machine will automatically "migrate" or "anonymous" your identity in the network and so it will be almost imposible to "block" or "attack" your presence in the network.



## Global unique entity ID

In BitDust we support a global unique ID for any existing object (file, group, user, etc.).
This is an example of full remote path to file "cat.png" in BitDust network:

    alice@first-machine.com:group_abc:animals/cat.png#F20160313043757PM


Full identifier here consists of several parts, here they are:

* identity server host (DNS name or IP address): first-machine.com
* user identity filename (without ".xml"): alice
* key ID: group_abc
* backup ID: animals/cat.png
* version name: F20160313043757PM


This approach have something similar with "remotes" and "branches" in Git. For example a full remote file path in Git can be like that:

    https://github.com/vesellov/bitdust.devel/blob/master/automats/automat.py


Looking more deeply we can split this URL by several parts:

* server host: github.com
* user account ID: vesellov
* repository ID: bitdust.devel
* branch ID: master
* file path: automats/automat.py



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


<div class=fbcomments markdown="1">
</div>