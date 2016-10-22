# BitDust Crypto Contracts



## Business requirements

BitDust do not have (and do not need) own currency - we count hardware resources, not euros, bucks or BitCoins. However to be able to buy/sell PC resources, off course, necessary to implement some kind of exchange market. There are several important points needs to be considered in this topic:

+ Because of distributed design of whole BitDust eco-system all billings and payments must be fully decentralized. That means there should not exist one single point of interest - nobody should be able to control and manage all billing operations in the network.

+ Imagine a situation when one customer is located in country A and using storage provided from supplier living in country B. This customer able to pay in local currency for country A, but supplier would like to receive money in another currency, because he live in country B where currency A is not available.

+ In some cases it may be not possible at all to transfer money directly from one country to another.

+ Transfer costs can be too high for international payments.

+ One customer can have up to 64 suppliers and paying all of them one by one is not efficient - he will prefer to pay only once for all finished contracts.

+ It must be possible to use BitDust network without spending any real cash - if you donate more resources than you consume all services must be free for you.

Based on these requirements, a distributed online payment system for BitDust was designed. It allows users to get a benefit from providing resources of their PC's for other people.


## The idea

In order to buy/sell hardware resources, nodes in BitDust network must sign some kind of "contract" between each other. This contract will regulate how much resources was allocated, identity of both parties  (consumer and provider), when it was started and basic price for that contract.

All contracts are stored in global distributed storage network - pretty close to well-known blockchain technology introduced in BitCoin currency - this storage is called "contracts-chain".

Bellow you can find more information about that idea and some details about how it is going to be built. 


## Supplier-Customer contracts

When some customer get connected to one of suppliers in the network - both must agree on that relations. In other words they will sign a contract and this contract declares several important points:

+ who provide the storage (ID of supplier),
+ who consume the storage (ID of customer),
+ when this deal was started,
+ how much space was allocated from supplier to customer,
+ a basic price for one megabyte for that contract

At first customer requests from supplier some amount of storage by communicating with him directly. Supplier can do some analysis of this customer and decide about this request based on some trust level. Let's assume that supplier accepts this request and able to provide that amount of storage. Immediately after that contract means to be started and customer should be able to use given amount of storage on provider's machine for own purposes.

Consumer will expect a "contract offer" from provider right after they did a handshake. Within one hour provider must do that by "generating" a first coin in this contract-chain. You can read more about coins mining process bellow on this page.


## Contract-chain

When a new coin will be mined and published consumer should receive it and recognize that provider is expecting a payment from him. But provider must follow his promises and keep doing his job well and provide good quality service in order to satisfy the customer. Now customer have some time to test quality of service and make a final decision.

Every contract have a duration and starting point so expiration moment is known in advance. To be able to complete the contract, customer must generate a second coin to confirm this deal and this coin will be attached to same contract right after the coin previously mined by supplier. At any moment of time before contract became expired customer must add second matching coin to the contract-chain to confirm that he is willing to pay for this service.

If everything went fine and second coin was mined and published by consumer - both parties should receive it and get notified about successful contract finalization. Now supplier and customer will communicate again and decide about contract extension. If they agree to continue - the process will repeat: 2 more coins will be mined and appended to this contract-chain, and so on.

Of course consumer may decide to not pay - this is correct if quality of service by provider was not good enough  during that testing period (after the moment when first coin was mined and published). In this case supplier of course will be disappointed but it was his personal decision and he accepted the risk. So if second coin was not mined before contract became expired, provider will just stop supporting this customer, erase uploaded files from own machine and close all network connections with consumer.

Every next contract in the chain must have twice or more longer "duration". This is needed to prevent polluting the global contracts storage. First contract in chain starts with one hour duration, second should be at least two hours, third at least 4 hours and so on. Longer contracts costs more, but of course have more risk to be failed.

Also "amount" of resources can be changed after every coin mined by customer (every second coin). So if customer at some point decides to increase/decrease amount of storage taken from supplier, he needs to finish current contract first (need to pay for whole duration) and then request next contract with new options.


## Contract details

To mine a new coin provider first need to prepare a compact json-formatted data structure to describe the contract options:

    {
        'type': 'storage'
        'amount': 4096,
        'duration': 3600,
        'customer': 'http://some.id-host.org/alice_customer.xml',
        'supplier': 'http://another-server.com/bob_supplier.xml',
        'started': 1475338187,
        'price': 1.0,
    }
    
This structure clearly describes the deal between customer and supplier on given amount of resources:
    
+ type of resources is HDD space
+ amount: 4 Gigabytes
+ deal started at 2016-10-01 16:09:47 in UTC time zone
+ provider is : http://another-server.com/bob_supplier.xml
+ consumer is : http://some.id-host.org/alice_customer.xml
+ basic price will not be changed 
    
Combining such data for all coins in given contract-chain let us calculate a total amount of consumed resources and the final price of the contract.


## Digital signature

Second step will be to protect this info during transmitting over the network. A common way to do that is to put digital signature on target data before sending it to remote node. So provider will have to use own private key to generate electronic signature and append some extra data to the output json-structure.

In example bellow signature was generated based on all fields from "payload" plus "pubkey" and "creator" fields.


    {
        'payload': {
            'type': 'storage'
            'amount': 4096,
            'duration': 3600,
            'customer': 'http://some.id-host.org/alice_customer.xml',
            'supplier': 'http://another-server.com/bob_supplier.xml',
            'started': 1475338187,
            'price': 1.0,
        },
        'creator': 'http://another-server.com/bob_supplier.xml'
        'pubkey': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPqJ1iCcC3KDeiOqIFkzdIOFgc6I7q0K66PBmleazi1i8McKBQtubzXJ1RLkS2GYhFbhTp4oGooJ89VXn+iiR4/MYDLfrdMSCCirnZRWk4dbIQfAz+YhVcnVEijpy3XUuLu3i1KVuhTAglVdiFKdQI69ymXGaoE3vXEDsDZxkYQkDw+aHP32gK+I1We9jFMIKbZ0ZG433YY3iU2OWvhg+0AlzGbTGql5LHPcaWYAAPrMMc0cb++WAAE4Wu9f/mj7GbRGN5EMyUkw9Rgqjhq6bfRAySOb2eoZ2R5iULMf7RK8dPE2BlDERpWu3O6HdzGiv6TjdJud41itH8MGQV4aoH',
        'signature': '11509633152462210145810836897427076014256778993195432760466639226544332599947159471602019395002280090912255429461315119534924788851391594040931514489193023827369988510316421480811620239538176418433670156374564900842654384239855787294174050418690384225561009520395965736998243113590591582885594951775728633639051159558667514349109671715438742302865884551311338785699743757231628233258879865827026680699628244877542512697383773604285828378207896675157226028632277150843284951962345040687027752013552946115190188388379943783081109955913996415677750978438878761330089339854381391620990622541349315954552989042250508324415',
    }

## Hash value

The next step for provider will be to send this info to one of miners (can be picked randomly from the network) and let him work on this data to generate a special "hash value" matching this json-formatted data. Mining is based on fields inside "payload" structure, "signature", "creator" and "pubkey" fields are only needed to protect the coin during network transfer, they will not be included in the final contract-chain structure. 

Early or later miner will find the matching "hash" and prepare another json-formatted structure containing data received from provider and extra info added by "miner":
    
    {
        'hash': '00011bd267c65d430a8c94837ffe5673adb29bf6',
        'prev': '10111730b478d2657e903c82120da8b30b2f41ca',
        'starter': 'CC1WnfhRX4_52790'
        'miner': 'http://third-server.net/carl_miner.xml',
        'mined': 1475339122,
        'payload': {
            'type': 'storage'
            'amount': 4096,
            'duration': 3600,
            'customer': 'http://some.id-host.org/alice_customer.xml',
            'supplier': 'http://another-server.com/bob_supplier.xml',
            'started': 1475338187,
            'price': 1.0,
        },
        'creator': 'http://another-server.com/bob_supplier.xml'
        'pubkey': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPqJ1iCcC3KDeiOqIFkzdIOFgc6I7q0K66PBmleazi1i8McKBQtubzXJ1RLkS2GYhFbhTp4oGooJ89VXn+iiR4/MYDLfrdMSCCirnZRWk4dbIQfAz+YhVcnVEijpy3XUuLu3i1KVuhTAglVdiFKdQI69ymXGaoE3vXEDsDZxkYQkDw+aHP32gK+I1We9jFMIKbZ0ZG433YY3iU2OWvhg+0AlzGbTGql5LHPcaWYAAPrMMc0cb++WAAE4Wu9f/mj7GbRGN5EMyUkw9Rgqjhq6bfRAySOb2eoZ2R5iULMf7RK8dPE2BlDERpWu3O6HdzGiv6TjdJud41itH8MGQV4aoH',
        'signature': '11509633152462210145810836897427076014256778993195432760466639226544332599947159471602019395002280090912255429461315119534924788851391594040931514489193023827369988510316421480811620239538176418433670156374564900842654384239855787294174050418690384225561009520395965736998243113590591582885594951775728633639051159558667514349109671715438742302865884551311338785699743757231628233258879865827026680699628244877542512697383773604285828378207896675157226028632277150843284951962345040687027752013552946115190188388379943783081109955913996415677750978438878761330089339854381391620990622541349315954552989042250508324415',
    }

Here, extra fields: "hash", "starter", "prev", "miner" and "mined" was added by "miner" and turn this structure into valid coin.

Every miner will have to spent own CPU time to found matching "hash" and "starter" fields. The whole process was designed in a such way: difficulty (complexity) of the "mining" process will rise for every next coin generated in the contract-chain. More info about this you can find in next topic....


## Coin verification

On fourth step "miner" will send a fresh json-formatted data to several "accountants", randomly picked from the network. Those guys actually store all such coins on own computers. They do several verification tests on every incoming coin before write to own local HDD:

    + verify digital signature
    + verify creator ID
    + check "hash" and "starter" fields, must match to "coin" structure
    + verify "miner" ID
    + verify "consumer" and "provider" ID
    + verify "mined", "started", "duration" values
    + look at previous coin in the contract-chain and verify "prev" field
    + compare other coins in the contract-chain against this new coin

Accountant may not accept the coin for some reason. In this case he will reply back to "miner" instead of remember and broadcast this coin to others.

For example if hash of newly mined coin do not have enough "difficulty" this coin will be rejected, you can read more about that here ...  In that situation "miner" will have to work again on that coin to find another ("hash", "starter") combination which will have higher "difficulty".

Other possible scenario when coin can be rejected is when given customer and supplier already have an opened contract which is not expired yet and mined coin did not match to this contract.

It must be stated that "signature", "pubkey" and "creator" will not be stored in the contracts-chain. Those fields are needed to protect coin during transfer, storing them in the global database will produce huge overload on DB and this is not required. So final structure to be written into "accountant" local db will be like this: 

    {
        'hash': '00011bd267c65d430a8c94837ffe5673adb29bf6',
        'prev': '10111730b478d2657e903c82120da8b30b2f41ca',
        'starter': 'CC1WnfhRX4_52790'
        'miner': 'http://third-server.net/carl_miner.xml',
        'mined': 1475339122,
        'payload': {
            'type': 'storage'
            'amount': 4096,
            'duration': 3600,
            'customer': 'http://some.id-host.org/alice_customer.xml',
            'supplier': 'http://another-server.com/bob_supplier.xml',
            'started': 1475338187,
            'price': 1.0,
        }
    }


## Broadcasting

Once "accountant" validate and verify incoming coin and decides to accept it he will first put this coin into own local storage database stored on his HDD. Further he sends a broadcast message to all other "accountants" in the network to propagate this coin to all nodes. So every "accountant" node finally should receive this coin, verify and remember.

Broadcasting model designed in a such way so every new coin first gets delivered to "accountants" only and only after that may be translated further to some other nodes who really need it. All "accountants", in fact, forms some kind of "sub-network" specifically designed to hold the contracts-chain data. Other nodes do not receive coins directly from "miners" but can subscribe and listen for new coins from one of accountants. This way we prevent network overloading and optimize service data flows.

As you can see accountant nodes will store all existing coins in the network - this is sort of blockchain, but I would like to call that "contracts-chain". Finally, consumer should receive coin generated by provider (or vice versa) from one of accountants and able to proceed with current contract. 

Because process is the same for every node in the network and every new coin we expect to have a fully synchronized and distributed global contracts storage. So every user in the network should be able to declare how much he consume/donate from/to others. And every other user should be able to check and verify every existing contract (no mater of its current condition: started, finished or failed) - nodes able to send a "search queries" to "accountants" and they will reply with a list of coins found in contracts-chain. 


## Linked coins

As we stated above, every coin is linked to previous one in the chain via "hash" and "prev" fields, only first coin have empty "prev" value. Every accountant must validate this rule before accept any new coin to contract-chain.

Here is an example of next linked coin in the contract-chain, generated by customer to continue with current contract options:

    {
        'hash': '00011bd267c65d430a8c94837ffe5673adb29bf6',
        'prev': '10111730b478d2657e903c82120da8b30b2f41ca',
        'starter': 'ee24Xywona_4084'
        'miner': 'http://some-another-host.net/dave_miner.xml',
        'mined': 1475301212,
        'payload': {
            'extended': 1475301187,
            'status': 'ok',
            'customer': 'http://some.id-host.org/alice_customer.xml',
        }
    }

As you can see, "hash" value of previous coin equals to "prev" value of this coin and that defines its position in the chain. Because every accountant verify every incoming coin there is no way to put something in between, modify or append some "cheating" coins. 

Let's see how those guys can proceed further with current contract. Right after the second coin was mined and published, supplier and customer will have to decide about contract extension. In general case customer suppose to check the quality of service he received from provider during last contract and make a final decision.

Lets assume both sides agree to continue with current contract without any changes. That means next iteration of contract starts up and provider's turn begins now again. He must generate third coin and attach it to the contract-chain like this:

    {
        'hash': '111014204e5849fd819d447bf7fe4a4571060539',
        'prev': '00011bd267c65d430a8c94837ffe5673adb29bf6',
        'starter': 'nGmlfoRoNV_9731'
        'miner': 'http://third-server.net/carl_miner.xml',
        'mined': 1475301212,
        'payload': {
            'started': 1475301187,
            'duration': 7200,
            'supplier': 'http://another-server.com/bob_supplier.xml',
        }
    }

Every opened contract must be closed early or later so let's imagine those two guys decided to stop after second iteration of the contract. In this case fourth coin in the contract-chain should be generated again by customer to finish current contract:

    {
        'hash': '101005ce203ff32694ca678c5de416ecb7d90636',
        'prev': '111014204e5849fd819d447bf7fe4a4571060539',
        'starter': 'nGmlfoRoNV_9731'
        'miner': 'http://third-server.net/carl_miner.xml',
        'mined': 1475301212,
        'payload': {
            'finished': 1475306305,
            'status': 'ok',
            'customer': 'http://some.id-host.org/alice_customer.xml',
        }
    }


## Prepaid/postpaid contracts

Imagine a very common case: you wish to use the storage space for own purposes, but do not want to keep your PC always connected to the network. All you want is just to backup some files for very long time. In other words consumer may not be able to finish the opened contract at right moment of time and correctly proceed with contract extension because he is just offline.

No problem, this confused situation can be solved by using "prepaid" contracts. Based on solution described above it is possible to open a contract with longer duration. Right after the first coin, mined by provider, consumer will generate a final coin to pay for whole duration in advance:

    {
        'hash': '00011bd267c65d430a8c94837ffe5673adb29bf6',
        'prev': '10111730b478d2657e903c82120da8b30b2f41ca',
        'starter': 'wOSNZbcsvP_1887'
        'miner': 'http://some-another-host.net/dave_miner.xml',
        'mined': 1475301212,
        'payload': {
            'paid': 1475301187,
            'status': 'ok',
            'customer': 'http://some.id-host.org/alice_customer.xml',
        }
    }

As you can see, contract was not "finished", but it was "paid" in advance and closed. Of course, this have much more value for provider than consumer. Because if quality of service will be not good enough consumer definitely would like to switch to another provider, but he still need to pay for whole contract duration. So consumer will have to trust so much to provider and agree on this situation.

Luckily, all contracts was saved in global distributed publicly accessible storage and consumer able to check all past contracts for this given provider. Based on this info and some level-of-trust method he can decide to trust or not to this provider. For example he can check in how much "long and prepaid" contracts he was already involved.


## Calculate costs

At some point supplier may decide to get some refund from customer because he did a good job and provided customer with a good quality service. He also did a good work for other customers and would like to get refund from them. In BitDust every node can support a lot of connections and one single supplier can serve a lot of customers. So it is not feasible to process payments for every single contract.

Instead of dealing with every single contract BitDust software will calculate total amount of resources consumed by given customer during some period of time and charge him only one time. Same method can be used to calculate amount of donated storage provided by given supplier and find how much he earned during given period.

As described above, every contract have a fixed "price" - this coefficient ...

Total cost of any single contract can be calculated with such simple expression:

    value = amount * duration * price  ( in Megabytes * Seconds )

Now we can look at how this value can be used to calculate service costs in real currency. For example let's take euros as current local currency. Also need to set a price for the storage: let's assume someone agreed to pay 10 euros for 10Gb storage space per one month, for example.

    

As soon as contract was finished it is possible to calculate the total value from it and finally the real price in some currency.


## Cashiers

Every user can act as a trade agent (or cashier) and help other users to change real money (in local currency) for PC resources and vice versa. Any cashier able to take obligations for all contracts belongs to any particular supplier and pays him in local currency by his request. He can also take all obligations for any single customer and receive money from him in order to get paid for all resources was consumed by this customer...

... later customer will have to pay to one of "cashiers" according to amount of mined coins belongs to him (for all his suppliers). From other side, supplier can go to one of "cashiers" and request for refund - accountant will check how much crypto coins belongs to this supplier and calculate total amount in US $, euro, rubles, etc…

... to be continue









