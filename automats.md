# Finite State Machines
* [Introduction](#introduction)
* [Method](#method)
* [Example](#example)
* [Automaton Kernel](#the-core)
* [Relation to Code](#relation to the code)
* [Transition Graphs](#transition-graphs)
* [visio2python Tool](#visio2python)


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

Each automaton is a descendant of the
[`Automat`](http://gitlab.bitdust.io/devel/bitdust/blob/master/automats/automat.py#l202) class,
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

In this picture you can see an automation called
[`contact_status()`](http://gitlab.bitdust.io/devel/bitdust/blob/master/p2p/contact_status.py#l244),
which has four states.

[![contact_status()](p2p/contact_status.png)](p2p/contact_status.pdf)

There are following elements:


| states | events       | conditions        | actions         | variables |
| ---       | ---           | ---            |   ---            | ---        |
| **OFFLINE**  | <font color=#FF0000>outbox-packet</font> | <span style="color:#00FF00">isPingPacket()</span> | <span style="color:#00FFFF">doRepaint()</span> | AckCounter |
| **CONNECTED** | <span style="color:#FF0000">inbox-packet</span> | <span style="color:#00FF00">isDataPacket()</span> | <span style="color:#00FFFF">doRememberTime()</span> |  |
| **PING**     | <span style="color:#FF0000">file-sent</span>    |  |  |  |
| **ACK?**     | <span style="color:#FF0000">sent-done</span>     |  |  |  |
|     | <span style="color:#FF0000">sent-failed</span>   |  |  |  |
|     | <span style="color:#FF0000">timer-20sec</span>   |  |  |  |

</div>

The automaton `contact_status()` works as follows:

+ at the moment of production it is in the **OFFLINE** state
+ when receiving the incoming packet from the target node it turns to **CONNECTED** state and the current time is "registered" to track the duration of node connection
+ if the special service pack is sent to check the current status of connection and condition `isPingPacket()` goes off, the automaton will pass to the **PING** state and wait for response from the remote machine
+ in case of request time out or failed package sending to the target node, the automaton will turn to **OFFLINE** state

Proper operation of the automaton helps constantly tracking the current status of connection with the given node – you just need to check the value written in the `state` variable, which is the `ContactStatus` class member. 
For instance `self.state == 'CONNECTED'` means that user is online at the current moment.


## The Core

All this logic is concentrated in the kernel of the finite state machine in the method [`A(event, arg)`](http://gitlab.bitdust.io/devel/bitdust/blob/master/p2p/contact_status.py#l264)
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

This code is automatically generated under the visual framework of the transition graph of the finite state machine and the source files of the project can be automatically updated after modification implementation in the finite automaton. How it works is described below. 

Within the concept of open project documentation movement transition graphs are used not only at the stage of design and development, but also in documentation and product requirements list. This helps eliminate errors in programming logic – with this process automation the working code becomes absolutely identical to the visual framework of finite automaton. 

This allows to split software development process in at least two paths and significantly optimizes the whole working process on the project: 

+ behavior design проектирование поведения
+ functional development and test

## Relation to the Code

In the example given the method
[`doRememberTime()`](http://gitlab.bitdust.io/devel/bitdust/blob/master/p2p/contact_status.py#l321)
of `ContactStatus` class makes a record of the current time moment – this is exactly the part of the functional, which is managed by the finite automaton:

    def doRememberTime(self, arg):
        self.time_connected = time.time()

For every new network connection a new specific instance of this finite automaton will be created, method
[`A(idurl, event, arg)`](http://gitlab.bitdust.io/devel/bitdust/blob/master/p2p/contact_status.py#l229)
creates new instances and refers to existing instances of the automaton.

External reference to the automaton is carried out through [`automat(event, args)`](http://gitlab.bitdust.io/devel/bitdust/blob/master/automats/automat.py#l348) 
method of `Automat` class, for example after receiving new incoming package from the target node an event transfer will take place 
<span style="color:#FF0000">`inbox-packet`</span>:

    def Inbox(newpacket, info, status, message):
        A(newpacket.OwnerID, 'inbox-packet', (newpacket, info, status, message))
        ratings.remember_connected_time(newpacket.OwnerID)

In other words we can divide useful logic from the rest code within the development process and also structure the key interactions throughout the software. 
This reduces the likelihood of logic errors in the program to zero, while troubleshooting in most cases is the most complex and high-runner process at the stage of development and tests. As a rule the functional of software is divided into multiple methods, which can be programmed and tweaked separately or in a specially created test environment with the use of different automatic test and tweak procedures. 


## Transition Graphs

Transition graph is a graphical representation of the multiple conditions of the automaton and functions of transitions between them. In the visual framework of the finite state machine you can see the logic of algorithm and all the possible process stages, outcomes and interconnections. States and transitions form the program behavioral model of the control over the specific unit or process.

State is the key element of the finite automaton, it divides the stages which the algorithm does. While the program runs the automaton does transition between its states. It can get in the same state several times or on the opposite not get in any predefined state.

By transition from one state to another the testing of the condition, which is assigned to given transition, is preliminary conducted. The condition can be written as a statement in Python and can consist of function invocations, access to variables or status inspection of other automatons.

If the condition works, the transition to other state is conducted and the actions assigned for this transition are taken. These may include functions, statements in Python or other finite state machines invocations.

All interactions of the finite automaton are done through events accepting and communication. They are transferred directly into the automaton kernel and launch inspection of the transition between states.

Events, conditions and actions form the finite statement for the transition function from one state to another. Below are given the examples of elements which can be used for the text record of these statements on the transition graph:

<style type="text/css">div#table02 td, th { vertical-align: top; padding: 0px 15px; width:20%;}</style>

<div id=table02 markdown="1">

| элемент | пример |                    
| :---    | :---   |
| событие | <span style="color:#FF0000">inbox-packet</span> | 
|   | <span style="color:#FF0000">contact_status.state</span> <span style="color:#C0C0C0">is</span> <span style="color:#00FF00">PING</state> |
|   | <span style="color:#FF0000">timer-30sec</span> |
| условие | <span style="color:#00FF00">isDataPacket()</span> |
|   | <span style="color:#00FF00">AckCounter>1</span> |
|   | <span style="color:#C0C0C0">and</span> <span style="color:#00FF00">AckCounter==1</span> |
| действие |   <span style="color:#00FFFF">doRepaint()</span> |
|   | <span style="color:#00FFFF">AckCounter=0</span> |
|   | <span style="color:#00FFFF">Attempts+=1</span> |
|   | <span style="color:#FFFF00">contact_status(</span><span style="color:#FF0000">init</span><span style="color:#FFFF00">)</span> |

</div>


## visio2python

Microsoft Visio 2007 is used for creation of the vector schemes of transition graphs. Transition graphs of finite state machines, which control the behavior of BitDust client software, reside in *.vsd files.

A small tool called `visio2python` was developed, it optimizes and
facilitates the development of programs in Python, which use the finite state machines. It can translate the transition graphs, created in Microsoft Visio into the code in Python.


## BitDust Finite State Machines

...




<div style="text-align: center;" markdown="1"> <br>
[\[содержание\]](toc.md)
</div>
