# Finite State-Machines

* [Introduction](#introduction)
* [Method](#method)
* [Example](#example)
* [The Core](#the-core)
* [Relation to Code](#relation-to-the-code)
* [Transition Graphs](#transition-graphs)
* [visio2python](#visio2python)
* [BitDust automatas list](#bitdust-automatas-list)
* [Microservices Tree](#microservices-tree)


## Introduction

BitDust project is developed on the principles of [automata-based programming](https://en.wikipedia.org/wiki/automata-based_programming) and [open project documentation movement](http://is.ifmo.ru/works/open_doc/).

This is a programming paradigm in which a program or its fragment is represented as a model of some [finite state machine](glossary.md#finite-state-machine).
The distinctive feature of this approach consists in picking out each condition in which that process is in order to analyze the program behavior on the whole.
State machines transition graphs are used on each stage of software development and final documentation.

SWITCH-technology of automata-based programming was first introduced by Anatoliy Abramovich Shalyto in 1991.
You are welcome to study suggested approach more in detail on the website of the academic department of "Programming Techniques" [is.ifmo.ru](http://is.ifmo.ru/automata_en/) of Saint-Petersburg National Research University of Information Technologies, Mechanics and Optics,
and also by reading an article [Automata-based Programming](https://en.wikipedia.org/wiki/automata-based_programming)
on Wikipedia.

As a general principle the use of finite state machines for the realization of program logic as well as the automation of compilation of transition graphs to the source code in Python allow to optimize the development process considerably.


## Method

I use a slightly modified method of automata-based programming. On the arcs of transition graphs the events, conditions and actions are marked in the format which is as close as possible to Python language syntax, moreover the color keys and text formatting are used. 

As compared to the classic method of Anatoliy Shalyto my approach has some small differences: 

* color differentiation helps better visualization 
* use of function names instead of number indications creates more "talking" drawings
* you can write whole statements on Python on the arcs, which opens more possibilities to the developer

Each automat is a descendant of the
[Automat](https://gitlab.bitdust.io/devel/bitdust/blob/master/automats/automat.py#l202) class,
which establishes all key collaborations in the BitDust program:

+ initializes a conceptual machine increment by its production
+ does its clean termination
+ keeps a global index of all existing state machines
+ tracks current states of the state machine
+ receives, sends and handles the events
+ manages adjustable timers
+ manages debug log in the program


## Example

As an example, consider a simple finite state machine which is designed for tracking the current status of user’s  connection to the given node in the BitDust network.

In this picture you can see an automat called
[contact_status()](https://gitlab.bitdust.io/devel/bitdust/blob/master/p2p/contact_status.py#l244),
which has four states.

<div class=automatpng markdown="1">
[![contact_status()](p2p/contact_status.png)](p2p/contact_status.pdf)
</div>

There are following elements:

<div id=table01 markdown="1">
<style>
div#table01 td, th { padding: 0px 15px; white-space: nowrap; }
div#table01 img { max-width: 100px; }
</style> 

| states         | events          | conditions     | actions           | variables     |
| :---           | :---            | :---           | :---              | :---          |
| **OFFLINE**    | outbox-packet   | isPingPacket() | doRepaint()       | AckCounter    |
| **CONNECTED**  | inbox-packet    | isDataPacket() | doRememberTime()  | &nbsp;        |
| **PING**       | file-sent       | &nbsp;         | &nbsp;            | &nbsp;        |
| **ACK?**       | sent-done       |                |                   | &nbsp;        |
|                | sent-failed     |                |                   |               |
|                | timer-20sec     |                |                   |               |

</div>

The automat `contact_status()` works as follows:

+ at the moment of creation it starts in the **OFFLINE** state
+ when receiving the incoming packet from the target node it turns to **CONNECTED** state and the current moment of time is "registered" to keep track the duration of node connection
+ if the special service packet was sent from the program to check the current status of connection and condition `isPingPacket()` triggered, the automat will pass to the **PING** state and wait for response from the remote machine
+ in case of request time out or packet sending to the target node was failed, the state machine will turn to **OFFLINE** state

Proper operation of the automat helps constantly tracking the current status of connection with the given node – you just need to check the value written in the `state` variable, which is the `ContactStatus` class member. 
For instance `self.state == 'CONNECTED'` means that user is on-line at the current moment.


## The Core

All this logic is concentrated in the kernel of the finite state machine in the method [A(event, arg)](https://gitlab.bitdust.io/devel/bitdust/blob/master/p2p/contact_status.py#l264)
of `ContactStatus` class:

    def A(self, event, arg):
        #---CONNECTED---
        if self.state == 'CONNECTED':
            if event == 'outbox-packet' and self.isPingPacket(arg) :
                self.state = 'PING'
                self.AckCounter=0
                self.doRepaint(arg)
            elif event == 'sent-failed' and self.isDataPacket(arg) :
                self.state = 'OFFLINE'
                self.doRepaint(arg)
        #---OFFLINE---
        elif self.state == 'OFFLINE':
            if event == 'outbox-packet' and self.isPingPacket(arg) :
                self.state = 'PING'
                self.AckCounter=0
                self.doRepaint(arg)
            elif event == 'inbox-packet' :
                self.state = 'CONNECTED'
                self.doRememberTime(arg)
                self.doRepaint(arg)
        #---PING---
        elif self.state == 'PING':
            if event == 'sent-done' :
                self.state = 'ACK?'
                self.AckCounter=0
            elif event == 'inbox-packet' :
                self.state = 'CONNECTED'
                self.doRememberTime(arg)
                self.doRepaint(arg)
            elif event == 'file-sent' :
                self.AckCounter+=1
            elif event == 'sent-failed' and self.AckCounter>1 :
                self.AckCounter-=1
            elif event == 'timer-20sec' or ( event == 'sent-failed' and self.AckCounter==1 ) :
                self.state = 'OFFLINE'
                self.doRepaint(arg)
        #---ACK?---
        elif self.state == 'ACK?':
            if event == 'inbox-packet' :
                self.state = 'CONNECTED'
                self.doRememberTime(arg)
                self.doRepaint(arg)
            elif event == 'timer-20sec' :
                self.state = 'OFFLINE'
            elif event == 'outbox-packet' and self.isPingPacket(arg) :
                self.state = 'PING'
                self.AckCounter=0
                self.doRepaint(arg)

This code is automatically generated from transition graph vector diagram of the finite state machine and you do not need to code all that lines and so have no chance to made the mistake.
The source files of the project can be automatically updated after any modifications applied in the finite state machine, how it works is described below. 

Within the concept of the open project documentation the transition graphs are used not only at the stage of design and development, but also in documentation and product description plan. This helps eliminate errors in programming logic – with this process automation the working code becomes absolutely identical to the visual framework of finite automat. Also it helps all sides to understand each other more clearly: customers, developers, testers, end-users.

This allows to split software development process in at least two paths and significantly optimizes the whole working process on the project: 

+ behavior design of the program
+ functional development and tests


## Relation to the Code

Let's see on example below, the given method
[doRememberTime()](https://gitlab.bitdust.io/devel/bitdust/blob/master/p2p/contact_status.py#l321)
of `ContactStatus` class makes a record of the current time moment – this is exactly the part of the functional, which is managed by the finite automat:

    def doRememberTime(self, arg):
        self.time_connected = time.time()
        
This is very simple code, but it makes a useful action and calls an external code - actions and conditions become separated from the state machine and target logic.

For every new network connection a new single instance of this automat will be created, method
[A(idurl, event, arg)](https://gitlab.bitdust.io/devel/bitdust/blob/master/p2p/contact_status.py#l229)
creates new instances and refers to existing instances of the automat.

External reference to the automat is carried out through [automat(event, args)](https://gitlab.bitdust.io/devel/bitdust/blob/master/automats/automat.py#l348) 
method of `Automat` class, for example after receiving new incoming packet from the target node an event `inbox-packet` will be passed to the state machine:

    def Inbox(newpacket, info, status, message):
        A(newpacket.OwnerID, 'inbox-packet', (newpacket, info, status, message))
        ...
        
In other words we can divide useful logic from the rest of the code within the development process and also structure the key interactions throughout the software. This is depends from developer and his understanding of the whole process. 

In fact, there is no need to create the machines only for the machines themselves. In my understanding, the purpose of automata-based programming is to highlight the key abstractions and processes described in the program and make their logic more clearly understandable. 

In the future, you can always go back and instantly remember how this piece of code works and very easily change the program behaviour. The majority of the Bitdust code is implemented a traditional programming methods and machines are used only for the construction of the top level classes. As usual, the best product is obtained when the balance was struck.

This approach reduces the likelihood of logic errors in the program to zero, while troubleshooting in most cases is the most complex and high-runner process at the stage of development and tests. As a rule the functional of software is divided into multiple methods, which can be programmed and tweaked separately or in a specially created test environment with the use of different automatic test and tweak procedures. 


## Transition Graphs

Transition graph is a graphical representation of the multiple conditions of the automat and functions of transitions between them. In the visual framework of the finite state machine you can see the logic of algorithm and all the possible process stages, outcomes and interconnections. States and transitions form the program behavioral model of the control over the specific unit or process.

State is the key element of the finite automat, it divides the stages which the algorithm does. While the program runs the automat does transition between its states. It can get in the same state several times or on the opposite not get in any predefined state.

By transition from one state to another the testing of the condition, which is assigned to given transition, is preliminary conducted. The condition can be written as a statement in Python and can consist of function invocations, access to variables or status inspection of other automats.

If the condition works, the transition to other state is conducted and the actions assigned for this transition are taken. These may include functions, statements in Python or other finite state machines invocations.

All interactions of the finite state machine are done through events accepting and communication. They are transferred directly into the automat kernel and launch inspection of the transition between states.

Events, conditions and actions form the finite statement for the transition function from one state to another. Below are given the examples of elements which can be used for the text record of these statements on the transition graph:


| element   | example |                    
| :---      | :--- |
| event     | inbox-packet | 
|           | contact_status.state is PING |
|           | timer-30sec |
| condition | isDataPacket() |
|           | AckCounter>1 |
|           | sent-failed and AckCounter==1 |
| action    | doRepaint() |
|           | AckCounter=0 |
|           | Attempts+=1 |
|           | contact_status(init) |



## visio2python

Microsoft Visio 2007 is used for creation of the vector schemes of transition graphs. Transition graphs of finite state machines, which control the behavior of BitDust client software, reside in *.vsd files.

A small tool called [visio2python](https://gitlab.bitdust.io/devel/visio2python/tree/master) was developed, it optimizes and facilitates the development of programs, which use the finite state machines. 
It can translate the transition graphs, created in Microsoft Visio into the code in Python or JavaScript languages.

[https://gitlab.bitdust.io/devel/visio2python](https://gitlab.bitdust.io/devel/visio2python/tree/master)


## BitDust automatas list

Below is a list of state machines currently introduced in BitDust software.
You can click on every item in the list to look at transition graph of the state.

* [backup()](automat_backup.md)
* [backup_db_keeper()](automat_backup_db_keeper.md)
* [backup_monitor()](automat_backup_monitor.md)
* [backup_rebuilder()](automat_backup_rebuilder.md)
* [contact_status()](automat_contact_status.md)
* [customers_rejector()](automat_customers_rejector.md)
* [data_sender()](automat_data_sender.md)
* [fire_hire()](automat_fire_hire.md)
* [id_registrator()](automat_id_registrator.md)
* [id_restorer()](automat_id_restorer.md)
* [id_server()](automat_id_server.md)
* [initializer()](automat_initializer.md)
* [install_wizard()](automat_install_wizard.md)
* [installer()](automat_installer.md)
* [list_files_orator()](automat_list_files_orator.md)
* [local_service()](automat_local_service.md)
* [network_connector()](automat_network_connector.md)
* [network_transport()](automat_network_transport.md)
* [nickname_holder()](automat_nickname_holder.md)
* [nickname_observer()](automat_nickname_observer.md)
* [p2p_connector()](automat_p2p_connector.md)
* [packet_in()](automat_packet_in.md)
* [packet_out()](automat_packet_out.md)
* [raid_worker()](automat_raid_worker.md)
* [restore()](automat_restore.md)
* [shutdowner()](automat_shutdowner.md)
* [stun_client()](automat_stun_client.md)
* [stun_server()](automat_stun_server.md)
* [supplier_connector()](automat_supplier_connector.md)
* [supplier_finder()](automat_supplier_finder.md)
* [tcp_connection()](automat_tcp_connection.md)
* [udp_connector()](automat_udp_connector.md)
* [udp_node()](automat_udp_node.md)
* [udp_session()](automat_udp_session.md)
* [udp_stream()](automat_udp_stream.md)


## Microservices Tree

BitDust software was developed using [service-oriented architecture](https://en.wikipedia.org/wiki/Microservices) and bellow you can see a dependencies tree of all [network services](services.md) currently exist in the software.

Most network services were implemented using finite state machines, on the picture you can see corresponding automatas as a blue labels. 


<div class=automatpng markdown="1">
[![BitDust Microservices Tree](services/bitdust_services_tree.png)](services/bitdust_services_tree.pdf)
</div>

[bitdust_services_tree.vsd](services/bitdust_services_tree.vsd)



<div class=fbcomments markdown="1">
</div>