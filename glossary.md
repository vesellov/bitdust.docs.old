<a class=hlnk id="Glossary"></a>
# Glossary


<a class=hlnk id="BitDust"></a>
##### BitDust
global network for distributed data storage, sharing, publishing, etc.  


<a class=hlnk id="BitDust-Program"></a>
##### BitDust Program
software delivered and distributed by [BitDust Team](http://bitdust.io)
under private [license](http://bitdust.io/license.html) with nominally-open source code – available for free download and review (we are still deciding about the license type ...)


<a class=hlnk id="Node"></a>
##### Node
computer connected to the Internet, which has [BitDust Software](#BitDust-Program) installed  


<a class=hlnk id="BitDust-Network"></a>
##### BitDust Network
voluntary association of people using their personal computers as independent interacting with each other [BitDust Nodes](#Node)


<a class=hlnk id="Data"></a>
##### Data
any information which can be stored on HDD as a single file or folder


<a class=hlnk id="Backup-Copy"></a>
##### Backup Copy
exact copy of [data](#Data) belonging to specified user, which was created at some point of time


<a class=hlnk id="Folder-Backup-Copy"></a>
##### Folder Backup Copy
[backup copy](#Backup-Copy) of data, which was obtained from archiving all files stored in the given folder on computer hard disk drive, including also (by user choice) all sub-folders


<a class=hlnk id="Distributed-Copy"></a>
##### Distributed Copy
a [backup copy](#Backup-Copy), which is stored on different [nodes](#Node) in [BitDust network](#BitDust-Network)


<a class=hlnk id="Block"></a>
##### Block
file on a hard disk drive containing only a part of [backup copy](#Backup-Copy) and having an order number, assigned at the moment of block creation


<a class=hlnk id="Fragment"></a>
##### Fragment
a part of [block](#Block), prepared in the process of a [backup copy](#Backup-Copy) creation and having an order number – position in the block, also may be called as sector


<a class=hlnk id="Size-of-Backup-Copy"></a>
##### Size of Backup Copy
total size of all [blocks](#Block) related to given [backup copy](#Backup-Copy)


<a class=hlnk id="Packet"></a>
##### Packet
<a class=hlnk id="Service-Packet"></a>
##### Service Packet
useful information transferred from one [node](#Node) to another in the [BitDust network](#BitDust-Network)
and containing [digital-signature](#Digital-Signature) of the sender


<a class=hlnk id="Data-Packet"></a>
##### Data Packet
<a class=hlnk id="Data-Portion"></a>
##### Data Portion
a [packet](#Packet), containing [encrypted](#Encryption) [fragment](#Fragment) of [data](#Data) 


<a class=hlnk id="BitDust-Data-Storage"></a>
##### BitDust Data Storage
a method of information processing which implies source data [encryption](#Encryption),
[archivation](#Archivation) and location on different [nodes](#Node),
divided into [blocks](#Block) and [fragments](#Fragment)


<a class=hlnk id="Recovery"></a>
##### Recovery
a process of inverse transformation of [data](#Data) from divided [fragments](#Fragment) and source data reconstruction from existing [backup copy](#Backup-Copy)


<a class=hlnk id="Upload-to-the-BitDust-Network"></a>
##### Upload to the BitDust Network
a process of creation of [distributed copy](#Distributed-Copy) of given [data](#Data),
[portions](#Data-Portion) of which are located at [suppliers](#Supplier) machines


<a class=hlnk id="Download-from-the-BitDust-Network"></a>
##### Download from the BitDust Network
a process of [data](#Data) [recovery](#Recovery) from 
[distributed copy](#Distributed-Copy),
which was initially located at the [suppliers](#Supplier) machines


<a class=hlnk id="Supplier"></a>
##### Supplier
a [node](#Node) in the [BitDust network](#BitDust-Network), whose owner voluntary agreed to store other user's [data](#Data) on the hard disk drive of his personal computer


<a class=hlnk id="Client"></a>
##### Client
a [node](#Node) in the [BitDust network](#BitDust-Network), whose owner uses the space on the HDD's of other [nodes](#Node) for storing his own [data](#Data)


<a class=hlnk id="Clients-Folder"></a>
##### Clients Folder
a local folder on the hard disk drive of the [supplier](#Supplier) machine, 
where [data](#Data) of his [clients](#Client) are stored


<a class=hlnk id="Shared-Supplier-Space"></a>
##### Shared Supplier Space
maximum possible volume reached by [clients folder](#Clients-Folder)


<a class=hlnk id="Used-Supplier-Space"></a>
##### Used Supplier Space
current volume of [clients folder](#Clients-Folder)


<a class=hlnk id="Allocated-Client-Space"></a>
##### Allocated Client Space
a byte value previously agreed upon with the user, which states the maximum total volume of all [data](#Data), that the [client](#Client) can locate at the given [node](#Node)


<a class=hlnk id="Free-Supplier-Space-"></a>
##### Free Supplier Space 
a difference between [shared supplier space](#Shared-Supplier-Space) and total volume of [allocated client space](#Allocated-Client-Space) for all the [clients](#Client) of the user


<a class=hlnk id="Used-Client-Space"></a>
##### Used Client Space
total volume of all already created [distributed copies](#Distributed-Copy) of the given user


<a class=hlnk id="Requested-Client-Space"></a>
##### Requested Client Space
an upper bound of [used client space](#Used-Client-Space)
for given user – in other words a maximum total volume of [data](#Data), which can be allocated at the [suppliers](#Supplier)


<a class=hlnk id="Free-Client-Space"></a>
##### Free Client Space
a difference between [requestd](#Requested-Client-Space) and 
[used](#Used-Client-Space) [clients](#Client) space


<a class=hlnk id="Command"></a>
##### Command
a [packet](#Packet) of [data](#Data) containing only code phrase, a [message](#Message) or any other information, used for interaction between [nodes](#Node) in the [BitDust network](#BitDust-Network)


<a class=hlnk id="Message"></a>
##### Message
[encrypted](#Encryption) text message addressed at exact user 


<a class=hlnk id="Encryption"></a>
##### Encryption
some [data](#Data) transform for the purpose of its protection


<a class=hlnk id="Archivation"></a>
##### Archivation
[data](#Data) transform for the purpose of creating a unified stream and decreasing the total size of the stored information 


<a class=hlnk id="Public-Key"></a>
##### Public Key
<a class=hlnk id="Private-Key"></a>
##### Private Key
<a class=hlnk id="Digital-signature"></a>
##### Digital signature
secret key is used for personal data protection, you are welcome to read 
[detailed article](http://ru.wikipedia.org/wiki/%D0%9A%D1%80%D0%B8%D0%BF%D1%82%D0%BE%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D0%B0_%D1%81_%D0%BE%D1%82%D0%BA%D1%80%D1%8B%D1%82%D1%8B%D0%BC_%D0%BA%D0%BB%D1%8E%D1%87%D0%BE%D0%BC)
on Wikipedia


<a class=hlnk id="Identity"></a>
##### Identity
a publicly readable file containing an [public key](#Public-Key), 
[digital-signature](#Digital-Signature), contact details and other information belonging to exact user


<a class=hlnk id="ID-server"></a>
##### ID-server
<a class=hlnk id="Identity-server"></a>
##### Identity server
a single [node](#Node) in the [BitDust network](#BitDust-Network) which acts as a server receiving and storing [identity](#Identity) files for other nodes


<a class=hlnk id="Identity-URL"></a>
##### Identity URL
<a class=hlnk id="IDURL"></a>
##### IDURL
<a class=hlnk id="User-Identifier"></a>
##### User Identifier
unique address of the exact [identity](#Identity) file in the Internet and [BitDust network](#BitDust-Network)


<a class=hlnk id="Network-Logon"></a>
##### Network Logon
a process of creating a new [identity](#Identity) file, its sending to several [id-servers](#ID-server) and receiving unique [IDURL](#IDURL) address for given user


<a class=hlnk id="Identity-Recovery"></a>
##### Identity Recovery
a process of downloading of [identity](#Identity) file from one of the [id-servers](#ID-server) ( via known [IDURL](#IDURL) ) and further conformance check of file content and user [private key](#Private-Key) 


<a class=hlnk id="Automation"></a>
##### Automation
<a class=hlnk id="Finite-State-Machine"></a>
##### Finite State Machine
a mathematical model designed for specification of any algorithm in which all possible [states](#State) of the prototype process are salient and transitions between states are specified


<a class=hlnk id="State"></a>
##### State
one of the stages of the algorithm, which were allocated logically reasonable analysis of the simulated process


<a class=hlnk id="Transition-Graph"></a>
##### Transition Graph
visual framework of the [finite state machine](#Finite-State-Machine) which displays: states, transitions, events, conditions, actions and text descriptions.


<div style="text-align: center;" markdown="1"> <br>
[\[table of contents\]](toc)
</div>
