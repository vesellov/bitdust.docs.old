# Data Storage

* [Introduction](#Intro)
* [Suppliers / Clients](#suppliers-and-clients)
* [Upload in the Network](#upload-in-the-network)
* [Data Redundancy](#data-redundancy)
* [Download from the Network](#download-from-the-network)
* [Hardware Resources](#hardware-resources)



## Intro

BitDust network consists of multiple equal node, whose owners voluntarily give a part of hardware resources of their personal computers to each other. By sharing the resources the network users get more reliable, secured and fully independent storage for their own data.



## Suppliers and Clients 

User data allocation takes place on a fixed combination of nodes chosen beforehand, these nodes are called "suppliers". The user at the same time becomes a "client" for all these nodes – figuratively speaking he "rents" a portion of hard disk drive from each of his suppliers.

Before the user can start the first data upload the BitDust program should run a search and connection to his suppliers and provide available space for his data. By the first run and then in the program settings the user sets the two key parameters, which define the key parameters of the distributed storage:

+ the volume of requested space
+ a desired number of suppliers

Knowing this data you can easily count the value which should be provided from every node and all suppliers can check and provide the needed for his files their hard disk drive space in advance.

The number of suppliers can become one of these values:
`2`, `4`, `7`, `13`, `18`, `26`, `64`. Further you will find a detailed description how the data allocation is done and how the combinations of suppliers are formed.

The number of clients whom each user can support theoretically is not limited. However by having too many of them the possible sessions number can be exceeded – this parameter depends on operation system, which runs the given BitDust node. Apart from this by simultaneous upload/download from user machine the network channel which each client receives will be severely restricted – only nodes with very wide data through-put will be able to support a great number of clients.



## Upload in the Network

Each of the suppliers gets even portions of the total volume of uploaded user data. Each fragment of uploaded data is marked with a number of the supplier from the general combination to whom it is designed. By changing one supplier for another the new node gets exactly those data which correspond to his order number in the combination. 
 
For regular and stable upload input data are at first archived  and divided into blocks of the same size. This phase is practically identical to creation of regular .rar archive from the folder content or a file on the hard disk drive divided in volumes.

Then each block is encrypted with user secret key and is divided into the fragments of the same size, which are temporary saved on local hard disk drive. At the final stage these local files which are ready for sending in data portions are uploaded on the remote suppliers’ nodes. There they are stored in the same form but are fully distributed over the whole combination of suppliers – each of them receives exactly those fragments which were created for his position in the combination. 

Here is the general sequence of actions by creating a distributed data copy in summary:

+ reading input data from the folder or file on user’s local hard disk drive 
+ data archivation and optional compression by one of the methods: gzip or bzip2 
+ division of unitary array of binary data into the blocks of the same size 
+ encryption of each block with user’s secret key
+ starting RAID-procedures for creation of fragment combination from each block
+ forming data portions from fragments and temporary file recording on the local disk drive 
+ upload of all portions on the assigned suppliers’ nodes
+ deleting temporary files from the local disk drive (optional)

In program settings the user can state the maximum and desired block size by data backupping – this will influence the final portion size, which one by one will be uploaded and stored at suppliers’. By very big block size the value of loss by upload increases critically, as by connection fault current portion upload will be interrupted and should begin from the start. On the other hand by very small block size the total number of portions increases and overall program performance and volume of consumable random access memory decreases critically.



## Data Redundancy

In the section [Automatic Data Rebuilding](rebuilding.md) the method of converting the input data before allocating them on suppliers’ nodes is explained more in detail. Uploaded in the network data are stored with double redundancy and organized in a RAID array for ensuring a possibility of their recovery in the case of loss. 

two parallel layers, Data and Parity, have the same size, but different content:

+ Data layer completely consists of input data 
+ Parity layer has modified content, built with the help of a RAID procedure

For generating Parity layer, at the moment of backup copy creation, data are byte-wise taken and the operation XOR between Data fragments designed for two other suppliers is done.
RAID array is organized in a way that each Parity fragment allows restoring corresponding Data fragment on the machine of a new supplier, which swiftly changed the lost one.

By building a RAID array so-called EEC codes are used – this are the combinations of Data and Parity allocation on suppliers’ machines. For each of the possible suppliers combinations the optimal EEC code was calculated – it defines the framework of the mutual bracing of the Data and Parity fragments in the layers and maximum quantity of simultaneous errors, which may occur without block sustainability loss.



## Download from the Network

For downloading allocated in the BitDust network data back on user’s machine you need to: 

+ request and download the previously allocated at suppliers data portions
+ restore each block from the reassembled together fragments 
+ decrypt each restored block and check its sustainability by e-signature
+ assemble all restored blocks in a single archive
+ extract data from the archive to the user’s hard disk drive
+ delete temporary files and archive file

In case some fragments are lost, for example, due to the fault in connection to some of suppliers, the mechanism of lost data recovery in the Data layer from the on hand fragments of Parity layer will be started.



## Hardware Resources 

All nodes in the BitDust network are absolutely equal. There are no nodes of the higher order, having special authority, managing global processes and network structure, doing routing or data acquisition etc. All users voluntarily start BitDust program on their machines and have a chance to use hardware resources of other nodes and give part of their personal computer resources in the network: 

+ space on the hard disk drive
+ process time
+ Internet connection network channel

In the program settings user sets the following key data:

+ volume of requested from the network space for files upload
+ volume on the hard disk drive which the user is ready to provide to other nodes
+ desired number of suppliers on whose machine the storage of uploaded data will be distributed
+ network channel usage limit
+ number of process cores which he is ready to load with calculations useful for other nodes

At the moment BitDust program does not have a mechanism of praising the users and provision of personal computer resources for other users is done on a non-repayable basis. However one of the key points in our development plan is the design of such a methodic in order to give users a chance to make profit from providing part of their PC resources to others.



