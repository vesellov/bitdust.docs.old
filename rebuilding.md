# Automatic Rebuilding

* [Data Redundancy](#data-redundancy)
* [RAID Transformation](#raid-transformation)
* [ECC codes](#ecc-codes)
* [Reassembly](#rebuilding)
* [Local Data Copies](#local-data-copies)
* [Supplier Change](#supplier-change)
* [Supplier Search](#suppliers-search)


## Data Redundancy 

In the section [Data Storage](storage) we described a mechanism of creating distributed user data copies in BitDust network. Here we will talk about a method of data partitioning into separate fragments, which enables dynamic recovery of lost data and further redistribution to more reliable nodes in the network.

Data uploaded on user machines are stored there with double redundancy and are organized into RAID array for enabling a possibility of their recovery in case of loss.

The storage is organized in the following way: 

+ the first layer contains input data and is called "Data" 
+ the second layer has the same size but modified content and is called "Parity"


## RAID Transformation 

Different combinations of Parity fragments enable Data fragment recovery on the machine of a new supplier, who was recently replaced the lost one. Parity fragment for each block is created by conducting a XOR operation on each byte between several Data fragments of this block prepared for other suppliers. 

When one or few suppliers got lost we still can restore missing Data fragments from the fragments downloaded from other suppliers. For doing this one should do XOR operation on each byte between available Parity and Data fragments once again.

So-called iterative algorithm continues the work until it can restore at least one lost fragment in one cycle. For example, Data fragment recovery in one position on the first iteration allows restoring Parity parts in other positions in the next cycle, and then Data fragments will be restored in third position etc.  


## ECC Codes

When building RAID array so-called EEC codes are used – these are combinations of best positions of Data and Parity fragments in the suppliers set. Here "position" defines which fragments must be kept by given supplier.

For each of the possible combinations of suppliers the optimal EEC code was calculated – it defines the framework of mutual bracing of Data and Parity fragments in the layers and maximum quantity of simultaneous errors, which may occur not leading to the block sustainability loss. Here you can see the allowable number of possible losses for each of the possible combinations of suppliers:


| **ecc code**              | **number of suppliers**       | **maximum errors**        |
|---:|:---:|:---:|
| ecc/64x64                 | 64                            | 10                        | 
| ecc/26x26                 | 26                            | 6                         |
| ecc/18x18                 | 18                            | 5                         |
| ecc/13x13                 | 13                            | 4                         |
| ecc/7x7                   | 7                             | 3                         |
| ecc/4x4                   | 4                             | 2                         |
| ecc2x2                    | 2                             | 1                         |


Thus percentage of possible losses makes 50% for 2 suppliers and up to 15% for 64 suppliers. The greater the number of possible errors you can do, the more time you have to reassemble the lost fragments and the more stable the data storage is. Shortly saying more suppliers should theoretically give you more reliable storage space. But the greater number of suppliers you use, the more memory and network connections will be allocated from your local operating system.


### ATTENTION!

    By exceeding the number of possible errors, you should expect complete
    loss of uploaded data. The mechanism of automatic data recovery
    allows swiftly fixing encountered errors and enables
    new distribution of data on reliable suppliers’ nodes.

    At the moment you have to continuously running  BitDust program 
    on your machine with stable Internet connection in order to keep
    your uploaded files stored reliable. BitDust software will monitor
    your suppliers, replace "dead" nodes with fresh one and rebuild your data.



## Rebuilding

Algorithm of dynamic data recovery cyclically runs a sequence of actions aimed at constant maintenance of a state in which data can be downloaded from the network.

In each algorithm iteration BitDust software will make a decision about your suppliers based on the previously collected statistic data and current connection status. The least "reliable" supplier can be fired and another random node can be found in the BitDust network to replace him.

After changing the supplier, those fragments which were allocated on the old node are lost. Right away the "rebuilding" process will be started to reassembly of these fragments on local computer and further sending them to the new node. Based on your ECC mode and number of suppliers a set of data fragments will be beforehand downloaded from other suppliers which are available at the moment.

At each iteration of recovery algorithm there is a reassembly of one single block of your data on your local machine, software will put it in a temporary folder on your disk to arrange network delivery to remote supplier node and removes those fragments after all.

To rebuild one lost fragment you need go combine Data and Parity fragments from reliable nodes together and run RAID process on that set. This takes some CPU time, because you doing huge amounts of XOR'ing in total - multiple times per each and every byte of your data. 

The order of data assembly is organized by the time of creation of each copy – first will be restored the most recently uploaded data and sent to reliable suppliers.  BitDust software keeps track of all running uploads and downloads and also "remembers" a pending requests. 

Rebuilding process can take a time depend on total size of your uploads, CPU frequency and network bandwidth limit.
Currently implemented a very basic scenario when only one active upload/download process is running and all jobs are organized in a queue.

Here is a short representation of the common sequence of actions at each iteration:


1. decision on supplier change was made – the least "reliable" node in the current supplier set identified
2. global network lookup found a node which is ready to become a new supplier for the user
3. process of downloading already allocated data fragments from other suppliers is launched
4. for each block a RAID procedure for recovery of the lost fragments on the older node is done
5. restored fragments are uploaded to computer of the new supplier 
6. after successful upload the restored fragments are deleted from the local disk drive (optional)
7. rebuilding loop restarted from step 3. - next uploaded file will be taken from the queue to be recovered


## Local Data Copies

During backup/restore/rebuilding process from/to your suppliers the files for Data and Parity fragments are "buffered" on your local disk drive in the folder `.bitdust/backups/`. In BitDust program settings you can find an option allowing you to keep these files after they have been uploaded on computers of remote suppliers. In that case the space of the hard disk drive is consumed, but the level of reliability of stored information is much higher.

While algorithm of automatic recovery runs it will download and then upload data to the remote nodes. In the worst possible case to change one supplier you will have to download all uploaded files from the BitDust network. Turning on the option responsible for storing local Data and Parity fragments on local drive allows significantly decreasing the volume of used network traffic and CPU time - simply you need to rebuild less data, because you already store it locally. Downside here is that you need to spent extra disk space. Steps `3.`, `4.` and `6.` at each iteration of the algorithm of automatic recovery will be overjumped.

So this key adjustment lets the user choose between consumable computer resources: 

+ to use bigger space of local disk drive and get more reliable storage option 
+ or to use more network traffic and process resources


## Supplier Change

The key pint in mechanism of automatic data recovery is the method of making a decision about identifying and changing the bad supplier. 

Chosen EEC code influences the amount of possible mistakes in RAID array you can handle. In other words the amount of possible missed fragments in each block when you still can reassemble the whole block. 

At each iteration of the algorithm of automatic recovery the estimation of number of connected at the moment suppliers is done, as well as the matching of it to the possible number of losses for the given EEC method. If the number of inactive suppliers is critically great, then the momentary change of one or several suppliers will be done and reassembly of all uploaded data and their transfer to the new nodes is underway.

At the moment those methods was implemented on the basic level and needs further development for optimal decision making. However this requires a real environment for testing – we need greater number of real users, which dynamically log on and out of the network. 

In the future we plan to boost this functional so that it could "predict" beforehand the change of this or that supplier in the general combination by previously collected daily/weekly statistics. This will allow downloading those fragments of Data and Parity layers which are located on the node of supposedly "unreliable" supplier and then afterwards replacing him. This approach will contribute to significant decrease in consumable resources of the data owner personal computer: namely network channel and CPU time.

It bears mentioning that to our forecasts the change of suppliers will be done rare enough as statistically the more reliable nodes will not be exposed to change. After formation of the initial supplier set their combined reliability will steadily increase. After reaching particular state the changes will take place in very rare cases and can be easily predicted which allows using the minimum PC resources for reassembly.

In the future we plan to create conditions for external praising of users who give resources of their personal computers to the network as this will stimulate the more reliable data storage.


## Suppliers Search

By supplier change the search of a new node in the BitDust network is done under present parameters:

+ the volume of requested from the network space
+ the number of suppliers in the combination – it depends on the chosen EEC method

For this the distributed hash-table is addressed and the random node is chosen. Then this node is connected and sent a request to provide a service of storing data for the user. By acceptance the chosen node becomes a new supplier for that user. In case of refusal the algorithm of supplier search goes backwards and does a new attempt – chooses a random node from the distributed hash-table and starts connection.

Theoretically randomization of suppliers search method allows increasing the level of data storage security to some extent as the possible attacker would not guess which node will be the next supplier of the given user and accordingly would not be able to change it with the node under his control.

BitDust project does not maintain any hardware infrastructure - every supplier in the network is a device owned by an independent person. So we do not have even a chance to keep track of your personal data.


<div class=fbcomments markdown="1">
</div>
