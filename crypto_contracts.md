# BitDust Crypto Contracts

(in progress)

* [Business requirements](#business-requirements)
* [The idea](#the-idea)
* [Supplier-Customer contracts](#supplier-customer-contracts)
* [Breach of contract](#breach-of-contract)
* [Contract details](#contract-details)
* [Digital signature](#digital-signature)
* [Hash value](#hash-value)
* [Coin verification](#coin-verification)
* [Broadcasting](#broadcasting)
* [Linked coins](#linked-coins)
* [Prepaid/postpaid contracts](#prepaid/postpaid-contracts)
* [Contracts trustee](#contracts-trustee)
* [Calculate costs](#calculate-costs)
* [Supplier profits](#supplier-profits)


## Business requirements

BitDust do not have (and do not need) own currency - we count hardware resources, not euros, bucks or BitCoins. However to be able to buy/sell PC resources, of course, necessary to implement some "coins". There are several important points needs to be considered in this topic:

+ Because of distributed design of whole BitDust eco-system all billings and payments must be fully decentralized/distributed as well. That means there should not exist one single point of interest - nobody should be able to control and manage all billing operations in the network and be able to dictate some rules.

+ Imagine a situation when one customer is located in country A and using storage provided from supplier living in country B. This customer able to pay in local currency for country A, but supplier would like to receive money in another currency, because he live in country B where currency A is not available. So the method must be independent and generic.

+ Transfer costs for single small transaction can be too high, need to reduce amount of regular transactions as much as possible. One customer can have up to 64 suppliers and paying all of them one by one is not efficient - he will prefer to pay only once for all finished contracts.

+ It must be possible to use BitDust network without spending any real cash - if you donate more resources than you consume all services must be free for you.

Based on these requirements we started desiging and developing a distributed online payment system for BitDust project. The goal is to allow users to gain some "coins" and benefit from providing resources of own PC's to other people.


## The idea

In order to buy/sell hardware resources, nodes in BitDust network must sign some kind of "contract" between each other. This contract will regulate how much resources was allocated, define time period, identity of both parties (consumer and provider), basic price for that service and other related info.

All contracts are stored in global distributed storage network - pretty close to well-known blockchain technology introduced in well-known BitCoin currency. But this storage is called "contracts-chain" and will store not "coins" and "transactions" but only "contracts".

Basicaly the purpose of "Crypto-contract" is to support the deal between two nodes to provide and consume PC resources.
Bellow you can find more information about that idea and some details about how it is going to be built. 


## Supplier-Customer contracts

When some customer get connected to one of suppliers in the network - both must agree to start those relations and make a deal. In other words they will sign a contract and this contract declares several important points:

+ who provide the storage (ID of supplier),
+ who consume the storage (ID of customer),
+ when this deal was started,
+ how much space was allocated from supplier to customer,
+ a basic price for one megabyte for that contract

At first customer requests from supplier some amount of storage by communicating with him directly. Supplier can do some analysis of this customer and decide about this request based on some trust level. Let's assume supplier accepted this customer and decided to provide that amount of storage for requested period of time.

Supplier will prepare a "contract offer" to customer and send back in response to initial request. If customer agree on those conditions he will sign the contract and it back to supplier to indicate that deal actually was started. It is very simillar to real life - when you need a service from some organization you typically sign a paper contract and give them back a signed copy, but also keep another signed copy with you. 

Immediately after supplier received signed crypto-contract the deal means to be started and customer should be able to use given amount of storage on provider's machine for own purposes. 

Consumer will now expect a publishing of the "crypto-contract" from supplier - right after they did a handshake. Within one hour provider must do that by "generating" a first coin in that given "contract-chain". You can read more about coins mining process bellow on this page.


## Contract-chain

When a new coin will be mined and published consumer should receive it via global "contract-chains" database and recognize that provider is expecting a payment from him. But provider must follow his promises and keep doing his job well and provide good quality service in order to satisfy the customer, so first iteration of any contract always sponsored by provider.

Now customer have one hour to test quality of the service and decide about further extension. The contract is just started and duration of the first iteration is only one hour. So if quality of service is not good enough, customer may decide to choose another provider, but he still need to pay for that hour because the deal was already signed by both parties.

Every contract have a duration and starting point so expiration moment is known in advance. To be able to complete the contract, customer must generate a second coin to confirm this deal and this coin will be attached to same contract right after the coin previously mined by supplier. At any moment of time before contract became expired customer must add second matching coin to the contract-chain to confirm that he is willing to pay for this service.

In the "contract-chain" every next contract must have twice or more longer "duration". This is needed to prevent polluting in the global contracts storage. First contract in chain starts with one hour duration, second should be at least two hours, third at least 4 hours and so on. Longer contracts costs more, but of course have more risk to be failed.

+ supplier offer (1 hour duration),
+ customer accept (1 hour),
+ supplier offer (2 hours),
+ customer accept (2 hours),
+ supplier offer (4 hours),
+ customer accept (4 hours),
+ ...

If everything went fine and second coin was mined and published by consumer - both parties should receive it and get notified about successful contract finalization. Now supplier and customer will communicate again and decide about contract extension. If they agree to continue - the process will repeat: 2 more coins will be mined and appended to this contract-chain, and so on. So every contract is a repeating sequence of paired coins and every pair have twice longer duration (or more) than previous one.


## Breach of contract

Basically all such contracts are post-paid. At first step provider start providing a service and after some period of time consumer will pay for that service. Just like in real life - if contract was started customer must paid anyway.

Of course consumer may decide to not pay for consumed servies and do not mine second coin in the chain.
But in that case supplier will recognize that soon and will stop the relations. Also it will indicate that customer is not playing fair and his reputation will go down - every coin in "contract chain" is publicly available and everyone able to verify that.

So if second coin was not mined before contract became expired, provider will just stop supporting this customer, erase uploaded files from own machine and close all network connections with that consumer. From other side supplier can not just start a random contract without approval from customer - contract requires digital signatures from both parties.

Lets imagine quality of service by provider was not good enough during last period. Then customer simply decides to not extend the contract and it will be automatically finished. But customer still have to pay for it and offcourse he will be disappointed but it was his personal decision and he accepted the risk. Because every contract is started with shortest possible period, the cost of mistake is pretty low.

Also "amount" of resources provided/allocated can be changed after every coin mined by customer (every second coin). So if customer at some point decides to increase/decrease amount of storage taken from supplier, he needs to finish current contract first (need to pay for whole duration) and then request next contract with new options.


## Contract details

To mine a starting coin and begin a new "contract-chain", provider first must prepare a compact json-formatted data structure to describe the contract details:

    {
        'type': 'storage'
        'amount': 4096,
        'duration': 3600,
        'customer': 'http://some.id-host.org/alice_customer.xml',
        'supplier': 'http://another-server.com/bob_supplier.xml',
        'started': 1475338187,
        'price': 1.0
    }
    
This structure clearly describes the deal between customer and supplier on given amount of resources:
    
+ type of resources: storage space
+ amount: 4 Gigabytes
+ deal started at 2016-10-01 16:09:47 in UTC time zone
+ provider is : http://another-server.com/bob_supplier.xml
+ consumer is : http://some.id-host.org/alice_customer.xml
+ basic price will not be changed
    

## Digital signature

Second step will be to protect this info during transmitting over the network and storing in the contracts-chain database. A common way to do that is to calculate digital signature from target data before sending it to remote node. So provider will have to use own private key to generate electronic signature and append some extra data to the output json-structure.

In example bellow signature was generated based on all fields from "payload" part plus IDURL and Public Key of the "creator":

    {
        'payload': {
            'type': 'storage'
            'amount': 4096,
            'duration': 3600,
            'customer': 'http://some.id-host.org/alice_customer.xml',
            'supplier': 'http://another-server.com/bob_supplier.xml',
            'started': 1475338187,
            'price': 1.0
        },
        'creator': {
            'idurl': 'http://another-server.com/bob_supplier.xml',
            'pubkey': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPqJ1iCcC3KDeiOq...',
            'signature': '115096331524622101458108368974270760142567789931954...'
        }
    }

Now consumer also must agree on those terms and sign the contract. He will do this by generating another signature using own Private Key based on all fields from "payload" and "creator" parts plus own IDURL and Public Key:

    {
        'payload': {
            'type': 'storage'
            'amount': 4096,
            'duration': 3600,
            'customer': 'http://some.id-host.org/alice_customer.xml',
            'supplier': 'http://another-server.com/bob_supplier.xml',
            'started': 1475338187,
            'price': 1.0
        },
        'creator': {
            'idurl': 'http://another-server.com/bob_supplier.xml'
            'pubkey': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPqJ1iCcC3KDeiOq...',
            'signature': '115096331524622101458108368974270760142567789931954...'
        },
        'signer': {
            'idurl': 'http://some.id-host.org/alice_customer.xml',
            'pubkey': 'ssh-rsa AAAAUuLu3i1KVuhTAglVdiFKdQI69ymXGaoE3vXEDsDZxk...',
            'signature': '111355294611519018838837994378308110995591399641567...'
        }
    }
    
This structure customer will send back to supplier in response. Now provider and consumer have a perfectly signed contract by both parties.

## Hash value

The next step now is to write this contract in the global contracts database, so everyone will be able to check and verify this deal. Supplier will send this info to one of "miners" (can be picked randomly from the network) and let him work on this data to generate a matching "hash value" for this json-formatted data - this will be a new coin in the chain.

Basicaly mining is always based only on fields inside "payload" structure, we do not want to duplicate info about supplier and customer every next coin. But for first coin in every chain we also need to store "signature", "idurl" and "pubkey" fields to protect the whole contract-chain. All other coins will be linked and protected by hash value.

Early or later miner will find the matching "hash" and prepare another json-formatted structure containing data received from supplier and extra info added by "miner" to proof his work:
    
    {
        'payload': {
            'type': 'storage'
            'amount': 4096,
            'duration': 3600,
            'customer': 'http://some.id-host.org/alice_customer.xml',
            'supplier': 'http://another-server.com/bob_supplier.xml',
            'price': 1.0
        },
        'creator': {
            'idurl': 'http://another-server.com/bob_supplier.xml'
            'pubkey': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPqJ1iCcC3KDeiOq...',
            'signature': '115096331524622101458108368974270760142567789931954...',
            'time': 1475338187
        },
        'signer': {
            'idurl': 'http://some.id-host.org/alice_customer.xml',
            'pubkey': 'ssh-rsa AAAAUuLu3i1KVuhTAglVdiFKdQI69ymXGaoE3vXEDsDZxk...',
            'signature': '111355294611519018838837994378308110995591399641567...',
            'time': 1475338727
        },
        'miner': {
            'idurl': 'http://third-server.net/carl_miner.xml',
            'hash': '00011bd267c65d430a8c94837ffe5673adb29bf6',
            'prev': '',
            'starter': 'CC1WnfhRX4_52790',
            'time': 1475341122
        }
    }

Here, extra fields: "hash", "starter", "prev", "miner" and "mined" was added by "miner" and turn this structure into valid coin. The 'prev' field here is empty, because this is a first coin in the chain. Every next coin must have 'prev' field equal to 'hash' field of previous coin in the chain.

Need to say that every "miner" will have to spent own CPU time to found matching "hash" and "starter" fields. The whole process was designed in a such way: difficulty (complexity) of the "mining" process will rise for every next coin generated in the contract-chain. More info about mining process will be added soon.


## Coin verification

On fourth step "miner" will send a fresh json-formatted data to several "accountants", randomly picked from the network. Those guys actually store all such coins on own devices. All "accountants" always do several verification tests on every incoming coin before write it to own local HDD:

    + verify digital signature
    + verify creator ID
    + check "hash" and "starter" fields, must match to "coin" structure
    + verify "miner" ID
    + verify "consumer" and "provider" ID
    + verify "mined", "started", "duration" values
    + look at previous coin in the contract-chain and verify "prev" field
    + compare other coins in the contract-chain against this new coin

Accountant may not accept the coin for some reason. In this case he will reply back to "miner" instead of remember and broadcast this coin to others.

For example if hash of newly mined coin do not have enough "difficulty" this coin will be rejected. In that situation "miner" will have to work again on that coin to find another ("hash", "starter") combination which will have higher "difficulty".

Other possible scenario when coin can be rejected is when given customer and supplier already have an opened contract which is not expired yet and mined coin did not match to this contract. So only one contract may exist for every pair: (customer, supplier).

Again, fields "signature", "pubkey" and "idurl" will not be stored in the contracts-chain every time. Those fields are needed to protect coins during transfer. Storing those fields in the global database will produce huge overload on DB and this is not required. Only first coin will be stored with full details, so final structure to be written into "accountant" local db for this new chain will include all 4 structures: 'payload', 'creator', 'signer', 'miner'. All other coins in the chain will only include 'payload' and 'miner' fields.


## Broadcasting

Once "accountant" validate and verify incoming coin and decides to accept it he will first put this coin into own local storage database stored on his HDD. Further he sends a broadcast message to all other "accountants" in the network to propagate this coin to all other nodes. So every "accountant" node finally should receive this coin, verify and remember.

In order to keep all parties identitfied and all relations clean, "accountant" will also add his own indentity to that record and sign this coin with own key. He will do it before write to the local db, so all other nodes in the network will know the entry point of that coin. Basically it must be only one "accountant" who published this coin first time. All other "accountants" will do signatures verification as well. 

Broadcasting model designed in a such way so every new coin first gets delivered from "accountant" to "accountants" only, but not to "normal nodes" directly. It will be routed further to other nodes, but only to those who really need it. All "accountants", in fact, forms some kind of "sub-network" specifically designed to hold the contracts-chain data. Other nodes do not receive coins directly from "miners", but they must first "subscribe" and "listen" for new coins from one of connected "accountants". This way we prevent network overloading and optimize service data flows.

As you can see "accountant" nodes will store all existing coins in the network - this is sort of blockchain sub-network. We wish to call that type of storage "contracts-chain". Finally, consumer should receive coin generated by provider from one of his connected "accountants" and able to proceed with current contract. 

Because process is the same for every node in the network and every new coin we expect to have a fully synchronized and distributed global contracts storage. So every user in the network should be able to declare how much he consume/donate from/to others at the moment.

Every other user should be able to check and verify every existing contract (no mater of its current condition: "started", "finished", "failed", etc.). Also nodes should be able to send a "search queries" to "accountants" and they will reply with a list of coins found in contracts-chain. Because of such design we do not require users to store all existing contracts on own devices, like blockchain does, but only those nodes, who is intended and willing to do that.


## Linked coins

As we stated above, every coin is linked to previous one in the chain via "hash" and "prev" fields, only first coin have empty "prev" value. Every accountant always must validate this rule before accept any new coin to the contract-chain.

Here is an example of next linked coin in the contract-chain, generated by customer to continue with current contract options:

    {
        'payload': {
            'accepted': 1475301187
        },
        'miner': {
            'idurl': 'http://some-another-host.net/dave_miner.xml',
            'hash': '10111730b478d2657e903c82120da8b30b2f41ca',
            'prev': '00011bd267c65d430a8c94837ffe5673adb29bf6',
            'starter': 'ee24Xywona_4084',
            'time': 1475301212
        }
    }

As you can see, "hash" value of previous coin equals to "prev" value of this coin and that defines its position in the chain. Because every accountant verify every incoming coin there is no way to put something in between, modify or append some coins - no place for cheating. The fact that second coin was mined and published indicates that "customer" actually paid for this contract.

Let's see how those guys can proceed further with current contract. Right after the second coin was mined and published, supplier and customer will have to decide about contract extension. In general case customer suppose to check the quality of service he received from provider during last contract period and make a final decision.

Lets assume both sides agree to continue with current contract without any changes. That means next iteration of contract starts up and provider's turn begins now again. He must generate third coin and attach it to the contract-chain like this:

    {
        'payload': {
            'extended': 1475301187,
            'duration': 7200,
        },
        'miner': {
            'idurl': 'http://third-server.net/carl_miner.xml',
            'hash': '111014204e5849fd819d447bf7fe4a4571060539',
            'prev': '10111730b478d2657e903c82120da8b30b2f41ca',
            'starter': 'nGmlfoRoNV_9731',
            'time': 1475306119
        }
    }

Every opened contract must be closed early or later so let's imagine those two guys decided to stop after second iteration of the contract. In this case fourth coin in the contract-chain must be generated again by customer to finish current contract and contains "finished" field:

    {
        'payload': {
            'finished': 1475306305,
            'status': 'ok',
            'customer': 'http://some.id-host.org/alice_customer.xml',
        },
        'miner': {
            'idurl': 'http://third-server.net/carl_miner.xml',
            'hash': '101005ce203ff32694ca678c5de416ecb7d90636',
            'prev': '111014204e5849fd819d447bf7fe4a4571060539',
            'starter': 'nGmlfoRoNV_9731',
            'time': 1475319542        
        }
    }


## Prepaid/postpaid contracts

Imagine a very common case: you wish to use the storage space for own purposes, but do not want to keep your PC always connected to the network. All you want is just to backup some files for very long time. In other words consumer may not be able to finish the opened contract at right moment of time and correctly proceed with contract extension because he is just offline.

No problem, this confused situation can be solved by using "prepaid" contracts. Based on solution described above it is possible to open a contract with longer duration. Right after the first coin, mined by provider, consumer will generate a final coin to pay for whole duration in advance:

    {
        'payload': {
            'paid': 1475301187,
            'status': 'ok',
            'customer': 'http://some.id-host.org/alice_customer.xml',
        },
        'miner': {
            'idurl': 'http://some-another-host.net/dave_miner.xml',
            'hash': '00011bd267c65d430a8c94837ffe5673adb29bf6',
            'prev': '10111730b478d2657e903c82120da8b30b2f41ca',
            'starter': 'wOSNZbcsvP_1887',
            'time': 1475301212
        }
    }

As you can see, contract was not "finished", but it was "paid" in advance and closed. Of course, this is a big advantage for provider and more risk for customer. If quality of service will be not good enough, consumer definitely would like to switch to another provider, but he still need to pay for whole contract duration. So consumer will have to trust a lot to provider and agree on this situation.

Luckily, all contracts was saved in global distributed publicly accessible storage and consumer able to check all past contracts for any given provider. Based on this historical info and some level-of-trust methods he can decide whether he can trust or not to this provider. For example he can check how much "long and prepaid" contracts he was already involved in and compare their status.


## Contracts trustee

Another solution for offline customers would be to use other random nodes from network and trust them to do automatic contract renewals for you. So you publish one more field in "payload" part to declare a node who will be your "contracts guard":

    {
        'payload': {
            'type': 'storage'
            'amount': 4096,
            'duration': 3600,
            'customer': 'http://some.id-host.org/alice_customer.xml',
            'supplier': 'http://another-server.com/bob_supplier.xml',
            'trustee': 'http://super-trusted-server.com/mega_trusted.xml',
            'price': 1.0
        },
        'creator': {
            'idurl': 'http://another-server.com/bob_supplier.xml',
            'pubkey': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPqJ1iCcC3KDeiOq...',
            'signature': '115096331524622101458108368974270760142567789931954...',
            'time': 1475338187
        }
    }

In fact "trustee" will not pay for your contracts, but only sign and publish your contracts while you are offline. More information about that role will be added later.


## Calculate costs

At some point supplier may decide to get some refund from customer because he did a good job and provided customer with a good quality service. He also did a good work for other customers and would like to get refund from them as well. In BitDust every node can support a lot of connections and one single supplier can serve a lot of customers. So it is not feasible to process payments for every single contract.

Instead of dealing with every single contract BitDust software will calculate total amount of resources consumed by given customer during some period of time and charge him only one time. Same method can be used to calculate amount of donated storage provided by given supplier and find how much he earned during given period. The software will scan all existing contracts chains and summarize all your avctive contracts and calculate final value of consumed/donated resources for last period.

As described above, every contract have a fixed "price" - this coefficient allows you to "personalize" your service when you donating storage to the network. You can configure this option in program settings and so every next contract you starting will use that value. Currently started contracts still be calculated based on the value you set in the past.

Combining data for all coins in given contract-chain let us calculate a total amount of consumed resources and the final price of the contract. Total "value" of any single contract can be calculated with such simple expression:

    value = amount * duration * price
    
Here, a "price" parameter is set by provider to declare additional charge which he was going to take. This is a price "factor" - every user decides independently, how much to ask for own services. For example a value of 1.0 means no extra charges, but value 1.12 will put 12% extra tax.

We must provide more clear description about real meaning of "value" of the contract. Measurement unit for the "contract value" is Gb * Hours, or "GBH".

    a contract of 1 GBH represents situation when 1 GB storage space was consumed during 1 hour with price factor 1.0

Imagine you have one finished contract for 500 GBH to be paid, for example you were using 5 Gb storage space during 100 hours. However 25 Gb during 20 hours will give you a contract with same cost.

Lets see now how "value" and "price" can be used together to calculate service costs in real situation. Imagine supplier Bob constantly giving 30 Gb storage space of his HDD to customer Alice during one month. Also he asks 2% extra and they both agreed and did a handshake before sign the contract. All was good, both was happy and finished the contract successfully, the final value must be:

    30 GB * 30 days * 24 hours * 1.02 = 22032 GBH

But this is only expected value. To get the real value for the whole "contract-chain" we need more carefull calculations. First contract will be signed for 1 hour, second (after verification and confirmation from both sides) for 2 hours, third for 4 hours and so on ...  this is the sequence of powers of two. The contract have no total duration but extends every next period, so one big contract will be represented as a sequance of many smaller contracts:

    30 GB * 1.02 * 1 hour -> 30 GB * 1.02 * 2 hours -> 30GB * 1.02 * 4 hours -> ... 


## Supplier profits

Every customer always have to find enough suppliers to have reliable data storage - those guys agree to provide HDD space for you, but you will have to pay for the service. Supplier sign a deal with you but also checks your history. If you have many non-paid contracts, he can after one hour simply stop supporting you. All he need is to just refuse contract extension, and so the whole contract-chain will be closed - he lost nothing. But if you have a lot paid contracts every supplier will support you in a best way possible.

For example customer Alice will use ecc/4x4 mode and will be connected with 4 suppliers: Bob, and three other guys. Every supplier will sign a contract with Alice - all for same value and duration, but price can be different for every supplier. Let's say for example that the price for service provided by Bob is 1.2.

Because smallest iteration is one hour we can think of this process from different point of view: every hour Bob will "earn" (also you can think of words "mine" or "farm") that amount of "PC resources":

    100 GB * 1 hour * 1.2 / 4 suppliers = 30 GBH

After some period of time, Bob will have a several items in his contract-chain with Alice and total amount of donated resources can be easily calculated. For example, if he supported Alice during last 30 days he must be collected:

    100 GB * 30 days * 24 hours * 1.2 / 4 suppliers = 21600 GBH

When Bob decides to get refund for his services, same process will be repeated for all other of his customers for given period. The final value will be used to generate a new "supplier-coin" in immutable blockchain databse storing all transactions history, more info about this will be added later.


<div class=fbcomments markdown="1">
</div>


