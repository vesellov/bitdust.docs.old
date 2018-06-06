# Distributed Hash-table


## Description

[Distributed hash-table]( https://en.wikipedia.org/wiki/Distributed_hash_table),
or `DHT`, provides an interface close to associative array or dictionary with key/value pair where storage of all pairs (key, value) is distributed into multiple nodes.

Because of such useful DHT’s characteristics as decentralization, scalability and fault-tolerance it is possible to creates an integrated space for service information storage. This means switching to absolutely different approach to organization of network infrastructure rather than common centralized client-server solutions.

Each computer running a BitDust program can be a node in DHT network and stores key/value pairs created by other users.

BitDust software runs DHT network based on implementation from [Entangled](http://entangled.sourceforge.net/) library – its source code is wholly included in the source code of BitDust and is distributed together.



## Data types

Each user node uses different types of service data to interact with other computers in the network. Integrated space lets other users request any key/value pairs, which were previously written by the user in the DHT network, and get actual service information.

The following table has a list of command boxes, which can be written to the hash-table by each node:

* `[IDURL]` 
    user identity file source

* `[username]@[id-server]:address`
    external net address in [IP]:[PORT] format for receiving incoming connections

* `[username]@[id-server]:incoming`
    list of nodes trying to connect to the user at the moment

* `customer_supplier:[index]:[prefix]:[version]`
    list of relations for given customer with other suppliers 
        

## Support BitDust network

If you wish to support BitDust project, willing to support other nodes when they are connecting to the netowork and be sure your machine will work reliable - you can become a part of BitDust "proto-netowork". BitDust will be running constantly ony your device and re-route incoming DHT requests from other nodes.

Contact with BitDust team to notify about this new DHT node was started by you and we will add your IP:port in the list of [known_nodes.py](https://github.com/bitdust-io/public/blob/fd536b01983f419030fa070b95d18c11da502b46/dht/known_nodes.py#L36).


<div class=fbcomments markdown="1">
</div>
