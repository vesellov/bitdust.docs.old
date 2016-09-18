# BitDust Crypto Contracts


## Introduction

In order to buy/sell hardware resources, nodes in BitDust network must sign some kind of "contract" between each other. 

This contract will regulate how much resources was allocated, identity of consumer and provider, when it was started and basic price for that contract.

All contracts will be stored in global distributed storage network - pretty close to well-known blockchain technology, this storage will be called "contracts-chain".

Here I want to give you some more information about that idea and explain how this is going to be built. 


## Supplier-Customer contracts

When some customer get connected to one of suppliers in the network - both must agree on that relations. In other words they will sign a contranct and this contract declares several important points:

    + who provide the storage (ID of supplier),
    + who consume the storage (ID of customer),
    + when this deal was started,
    + how much space was allocated from supplier to customer
    + a basic price for one megabyte for that contract

At first customer requests from supplier some amount of storage and we assume that supplier accepts this request and able to provide that amount of storage. Imediately after that contract means to be signed and customer able to start using this space for own data.

Whithin one hour supplier must declare that deal and so he will mine a crypto-coin and attach own info to that coin.

he need to send this info to one of “miners”, “miner” will spent some CPU to  “mine” the coin for supplier and then broadcast this coin to all “accountants”. “accountants” nodes will store all existing coins in the network - this is sort of blockchain, but I call that “contracts chain"

so all accountants will receive this coin via broadcasting service - it should be routed thru other nodes.

then customer will also receive this coin from one of broadcasters and so recognize that supplier already published his part of contract for past hour. now customer must do the same but from own side - he will mine a coin and attach own info to that coin - it should match with previous coin mined by supplier. so supplier declares that he did some work for that customer, and customer declares that he agreed on that and agree to pay. so finally for this hour we will have two crypto coins from both supplier and customer. then supplier also get notified about second coin created by customer via broadcasting and recognize that he was paid for past hour. now both sides: supplier and customer should be satisfied and they can continue with current contract. but second period will be two hours - we do not want too much coins in the network - to not create too much records in global “contracts chain”. so every time we will double the period - 1hour , 2 hours, 4 hours, and so. at some point one of them (supplier or customer ) will decide to stop this and  so this contract will be finished.

later customer will have to pay to one of “accountants” according to amount of mined coins belongs to him (for all his suppliers). from other side, supplier can go to one of accountants and request for refund - accountant will check how much crypto coins belongs to this supplier and calculate total amount in US $, euro, rubles, etc…