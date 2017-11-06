# Data Storage

* [Introduction](#intro)
* [Suppliers / Customers](#suppliers-and-customers)
* [Upload in the Network](#upload-in-the-network)
* [Data Redundancy](#data-redundancy)
* [Download from the Network](#download-from-the-network)
* [Hardware Resources](#hardware-resources)



## Intro

BitDust network consists of many equal and self-governed nodes, whose owners voluntarily give a part of hardware resources of their personal computers to each other. By consuming hardware resources from BitDust network, users get access to more private, secure and fully independent storage to protect own data and private on-line communicaion, because all data stored in BitDust network is allways encrypted.



## Suppliers and Customers 

User data allocation takes place on a fixed combination of nodes chosen beforehand, these nodes are called "suppliers". The user at the same time becomes a "customer" for all these nodes – figuratively speaking he "rents" a portion of hard disk drive from each of his suppliers. However at any moment customer is free to "fire" any of his suppliers, find another user in BitDust and "hire" him to be able to store his files on his device.

Before the user can start the first data upload, the BitDust program on his device has to search and connect to his suppliers and request "needed space" for his data. At any time, in the program settings, user can adjust two key parameters of his distributed storage environment:

+ a volume of "needed" space
+ a desired number of suppliers

Knowing this data you we can count the amount of space that should be provided by every node:

    <supplier quota> = ( <needed space> / <number of suppliers> ) * 2

In the formula we have to multiply final quota by 2 because of redundancy. Data, stored on supplier machine, takes twice more space than original file, but might be less, because file can be compressed before it will be encrypted.

The number of suppliers you can use can be one of these values:
`2`, `4`, `7`, `13`, `18`, `26`, `64`. Further you will find a detailed description how the data allocation is done and how the combinations of suppliers are formed.

The number of customers whom each user can support theoretically is not limited. However by supporting too many nodes the possible sessions number can be exceeded – this parameter depends on operation system, which runs the given BitDust node and local network limitations.

Apart from this by simultaneous upload/download from user machine the network channel which each customer receives will be severely restricted – only nodes with very high bandwidth will be able to support a great number of nodes.



## Upload to the Network

Each of the suppliers receives equal portions of the total volume of uploaded user data. Each fragment of uploaded data is marked with a number of the supplier from the general combination to whom it is designed. By changing one supplier for another the new node gets exactly those data which correspond to his order number in the combination. 
 
For regular and stable upload input data are archived and divided into blocks. This phase is practically identical to creation of regular archive from the folder content or a file on the hard disk drive and divided by volumes.

Then each block is encrypted with one of the user's private keys. Yyou can use different keys to encrypt your data - this way you can share given piece of data with another user, more information about group access you can find in [Data Security](security.md) section. 

Further, your encrypted data will be divided into fragments of equal size, which are temporary saved on local hard disk drive. At the final stage these local files which are ready for sending are uploaded on the remote suppliers’ nodes. There they are stored as it is (in encrypted state), but are fully distributed over the whole combination of suppliers – each supplier receives exactly those fragments which were prepared for his position in the combination. 

Here is the general sequence of actions to run a new distributed data copy of your data:

1. reading input data from the folder or file on user’s local hard disk drive 
2. data archivation and optional compression with `gzip`
3. division of unitary array of binary data into the blocks of the same size 
4. encryption of each block with one of user’s secret keys
5. starting RAID-procedures for creation of fragment combination from each block
6. forming data portions from fragments and storing temporary on the local disk drive
7. upload of all portions on the assigned suppliers’ nodes
8. deleting temporary files from the local disk drive (optional)

In the settings user can state maximum and desired block size for data backups – this will influence the final portion size, which one by one will be uploaded and stored at suppliers’.

For data uploads made of big blocks the amount of loss increases critically and it can lead to low data reliability. On the other hand in case of very small block size the total number of fragments increases and this creates influence on overall program performance and amount of required memory on customer machine.


## Data Redundancy

In the section [Automatic Data Rebuilding](rebuilding.md) the method of converting the input data before allocating them on suppliers’ nodes is explained more in detail. Uploaded in the network data are stored with double redundancy and organized in a RAID array for ensuring a possibility of their recovery in the case of loss. 

Two parallel layers, Data and Parity, have the same size, but different content:

+ Data layer completely consists of input data 
+ Parity layer has modified content, built with the help of a RAID procedure

For generating Parity layer during backup processing data are byte-wise taken and XOR operation is applied between Data fragments of other suppliers. Final RAID array is organized in a way that each Parity fragment allows restoring corresponding Data fragment on the machine of a new supplier, which replaces the lost one.

By building a RAID array so-called EEC codes are used – this are the combinations of Data and Parity allocation on suppliers’ machines. For each of the possible suppliers combinations the optimal EEC code was calculated – it defines the framework of the mutual bracing of the Data and Parity fragments in the layers and maximum quantity of simultaneous errors, which may occur without block sustainability loss.



## Download from the Network

For downloading already existing data from the BitDust network software performs following steps: 

1. sending requests to download already existing data fragments from suppliers
2. restore each block from the reassembled together fragments of data
3. decrypt each restored block and check its sustainability by e-signature
4. assemble all restored blocks in a single archive
5. extract data from the archive to the user’s hard disk drive
6. delete temporary files and archive file

In case some fragments are lost, for example, due to the fault in connection to some of suppliers, the mechanism of [data recovery](rebuilding.md) in the Data layer from the on hand fragments of Parity layer will be started - see point 2. above.


## Hardware Resources 

All nodes in BitDust network are absolutely equal in thir possible roles and self-governed. There are no dedicated servers of the higher order, having special authority, managing global processes and network structure, doing global routing, monitoring or data acquisition etc.

Each and every user always voluntarily start BitDust program on own device and posses full control over BitDust software process. So everyone have an opportunity to consume hardware resources of other nodes from one side and also donate part of own PC resources to other users in the network. BitDust software should take care about all operations going on on your device and all processes are fully automated.

Finally such hardware resources can be requested and consumed from other users by you:

+ space on the hard disk drive of your "suppliers"
+ CPU time of your "scrubbers"
+ network bandwith of your "routers"

In the program settings user sets the following key data:

+ storage quota requested from others for own purposses
+ storage quota on local drive which user is ready to provide to other nodes
+ desired number of suppliers for your distributed storage
+ network bandwith limit of data uploading / downloading
+ number of CPU cores which he is ready to load with calculations useful for other nodes

At the moment BitDust program does not have a mechanism of sponsoring users and provision of personal computer resources for other users is done on a non-repayable basis. However one of the key points in our development plan is the design of such a methodic in order to give users a chance to make profit from providing part of their PC resources to others.



<div class=fbcomments markdown="1">
</div>
