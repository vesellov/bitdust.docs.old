# Automatic Rebuilding

* [Data Redundancy](#data-redundancy)
* [RAID Transformation](#raid-transformation)
* [ECC codes](#ecc-codes)
* [Reassembly](#rebuilding)
* [Local Data Copies](#local-data-copies)
* [Supplier Change](#supplier-change)
* [Supplier Search](#suppliers-search)


## Data Redundancy 

In the section [Data Storage](storage) we described a mechanism of creating distributed user data copies in BitDust network. Here we will talk about a method of data partitioning into separate fragments, which enables dynamic recovery of lost data by their loss at one or several suppliers.

Data uploaded on user machines are stored there with double redundancy and are organized into RAID array for enabling a possibility of their recovery in case of loss.

The storage is organized in the following way: 

+ the first layer contains input data and is called Data 
+ the second layer has the same size but modified content and is called Parity


## RAID Transformation 

Different combinations of Parity fragments enable Data fragment recovery on the machine of a new supplier, which swiftly replaced the lost one. Parity fragment for each block is created by conducting a byte operation XOR between several Data fragments of this block designed for other suppliers. 

By losing one or few suppliers this allows restoring Data fragments from the fragments downloaded from other suppliers. For doing this one should do byte operation XOR between on hand Parity fragments once again.

The so-called iterative algorithm continues the work until it can restore at least one lost fragment in one cycle. For example, Data fragment recovery in one position on the first iteration allows restoring Parity parts in other positions in the next cycle, and then Data fragments will be restored in third positions etc. 


## ECC Codes

When building RAID array so-called EEC codes are used – these are combinations of locations of Data and Parity fragments on suppliers machines.


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


Thus percentage of possible losses makes 50% for 2 suppliers and up to 15% for 64 suppliers. However the greater the number of possible errors is, the more time the user has to reassemble the lost fragments and the more stable the data storage is.


### ATTENTION!
    By exceeding the number of possible errors, expect complete loss of uploaded data. 
    The mechanism of automatic recovery allows swiftly fixing encountered errors and 
    enables new distribution of data on suppliers’ nodes. At the moment for this you 
    need a BitDust program continuous running on the data owner machine and stable 
    Internet connection.


## Rebuilding

Algorithm of dynamic data recovery cyclically runs a sequence of actions aimed at constant maintenance of a state in which data can be downloaded from the network.

In each algorithm iteration a decision making about change of this or that supplier based on the previously collected statistic data and current connection status takes place. The least "reliable" supplier can be fired and another node can be found in the BitDust network instead of him.

After changing supplier, those fragments which were allocated on the old node are lost and the process of reassembly of these fragments on user computer and further sending them to the new node start. For this the fragments will be beforehand downloaded from other suppliers which are available at the moment. 

At each iteration of recovery algorithm there is a reassembly by blocks of each distributed in the BitDust network user data copy. The order of data assembly is organized by the time of creation of each copy – first will be restored the most recently uploaded data. 

Here is a short representation of the common sequence of actions at each iteration:

1. decision on supplier change is made – the least "reliable" node in the current combination is found
2. search for a new node which is ready to become a new supplier for the user is done in the global network
3. process of downloading already allocated data fragments from other suppliers is launched
4. for each block a RAID procedure for recovery of the lost fragments on the older node is done
5. restored fragments are uploaded to computer of the new supplier 
6. after successful upload the restored fragments are deleted from the local disk drive (optional)


## Local Data Copies

By backup, data recovery from suppliers’ nodes and reassembly of lost fragments, the files for Data and Parity layers are "buffered" on the user local disk drive in the folder `.bitdust/backups/`.
In BitDust program settings you can find an option allowing you to keep on file these files after they have been uploaded on computers of remote suppliers or the recovery process is finished. In this case the space of the hard disk drive is used, but the level of reliability of information storage reaches the maximum.

While algorithm of automatic recovery runs, the download and further upload of data to ne remote nodes is done. In the worst possible case for changing one supplier you will need to download the whole uploaded in the BitDust network data. Enabling in the program settings an option responsible for storing local Data and Parity layers allows significantly decreasing the volume of used network traffic and process time. 

Steps `3.`, `4.` and `6.` at each iteration of the algorithm of automatic recovery will be overjumped.

So this key adjustment lets the user choose between consumable computer resources: 

+ to use bigger space of local disk drive and get more reliable storage option 
+ or to use more network traffic and process resources


## Supplier Change

The key moment in all the mechanism of automatic data recovery is the method of decision making on changing this or that user supplier. 

Chosen EEC code influences the amount of possible mistakes in RAID array. In other words the quantity of possible lost fragments in each block having which you still can reassemble the whole block. 

At each iteration of the algorithm of automatic recovery the estimation of number of connected at the moment suppliers is done, as well as the matching of it to the possible number of losses for the given EEC method. If the number of inactive suppliers is critically great, then the momentary change of one or several suppliers will be done and reassembly of all uploaded data and their transfer to the new nodes is underway.

At the moment this functional in the BitDust program is realized on the basic level and needs further development for optimal decision making. However this requires a real environment for testing its working efficiency – we need greater number of real users, which dynamically log on and out of the network. 

In the future we plan to boost this functional so that it could "predict" beforehand the change of this or that supplier in the general combination by previously collected day statistics. This will allow downloading those fragments of Data and Parity layers which are located on the node of supposedly "unreliable" supplier and then afterwards changing it. This approach will contribute to significant decrease in consumable resources of the data owner personal computer: namely network channel and process time.

It bears mentioning that to our forecasts the change of suppliers will be done rare enough as statistically the more reliable nodes will not be exposed to change. After formation of the first suppliers combination their combined reliability will steadily increase. After reaching particular state the changes will take place in very rare cases and can be easily predicted which allows using the minimum PC resources for reassembly.

In the future we plan to create conditions for external praising of users who give resources of their personal computers to the network as this will stimulate the more reliable another’s data storage.


## Suppliers Search

By supplier change the search of a new node in the BitDust network is done under present parameters:

+ the volume of requested from the network space
+ the number of suppliers in the combination – it depends on the chosen EEC method

For this the distributed hash-table is addressed and the random node is chosen. Then this node is connected and sent a request for giving a service of storing data for the user. By acceptance the chosen node becomes a new users supplier. In the event of a refusal the algorithm of search goes backwards and does a new try – chooses a random node from the hash-table and starts connection.

Statistically random suppliers search method allows increasing the level of data storage security to some extent as the possible attacker would not guess which node will be the new supplier of the given user and accordingly would not be able to change it with the node under his control.

BitDust network does not create and use centralized suppliers or clients ratings or other global network nodes lists. However quite possibly these kind of lists could be useful at a certain stage of project development (for example, for testing, debugging and optimization) and the decision in favor of their use will be adopted. In this case each user will be given a right of free choice whether to become a part of a global centralized list.




[table of contents](toc.md)