# Install BitDust software


* [Intro](#intro)
* [Install software dependencies](#install-software-dependencies)
* [Get BitDust to your local machine](#get-bitdust-to-your-local-machine)
* [Building virtual environment](#building-virtual-environment)
* [Run BitDust](#run-bitdust)
* [Binary Dependencies](#binary-dependencies)



## Intro

BitDust is a distributed on-line storage and communication network where only data owner posses full access to his personal data.

Current project stage is about to only research opportunities of
building a holistic eco-system that protects your privacy in the network
by establishing p2p communications of users and maximize distribution of
information flows in the network.

At the moment exists a very limited alpha version of the BitDust software.
We decided to publish those earlier works to verify/test/share our ideas and experiments with other people.



## Install software dependencies

Under Ubuntu/Debian, and probably most other distros as well, you can install all dependencies with single command:

        sudo apt-get install git gcc python-dev python-virtualenv


Optionally, you can also install [miniupnpc](http://miniupnp.tuxfamily.org/) tool if you want BitDust automatically set up UPnPc configuration of your network router so it can also accept incomming connections from other nodes.:

        sudo apt-get install miniupnpc


On MacOSX platform you can install requirements with that command:

        brew install git python2


Then you need to use pip manager to get all required packages:

        pip install --upgrade --user
        pip install --upgrade pip --user
        pip install virtualenv --user



## Get BitDust sources to your local machine

Second step is to get the BitDust sources. To have a full control over BitDust process running on your local machine you better make a fork of the Public BitDist repository on GitHub at https://github.com/bitdust-io/public and clone it on your local machine:

        git clone https://github.com/<your GitHub username>/<name of BitDust fork>.git bitdust


The software will periodically run `git fetch` and `git rebase` to check for recent commits in the repo. This way we make sure that everyone is running the latest version of the program. Once you made a fork, you will have to update your Fork manually and pull commits from Public BitDust repository if you trust them.

However if you just trust BitDust contributors you can simply clone the Public repository directly and software will be up to date with the "official" public code base:

        git clone https://github.com/bitdust-io/public.git bitdust



## Building virtual environment

Then you need to build virtual environment with all required Python dependencies, BitDust software will run fully isolated.

Single command should make it for you, all required files will be generated in `~/.bitdust/venv/` folder:

        cd bitdust
        python bitdust.py install


Last step to make BitDust software ready to be used is to make a short alias in your OS, then you can just type `bitdust` in command line to get fast access to the program:
        
        sudo ln -s -f /home/<user>/.bitdust/bitdust /usr/local/bin/bitdust



## Run BitDust

Start using the software by creating an identity for your device in BitDust network:
       
        bitdust id create <some nick name>
       

I recommend you to create another copy of your Private Key in a safe place to be able to recover your data in the future. You can do it with such command:

        bitdust key copy <nickname>.bitdust.key


In the future, just in case you need to restore access to your data, you will need to install BitDust on again and recover your identity:

        bitdust id restore <nickname>.bitdust.key


Your settings and local files are located in that folder: `~/.bitdust/`

Type this command to read more info about BitDust commands:

        bitdust help


To run the software type:

        bitdust
        

Start as background process:

        bitdust detach


To get some more insights or just to know how to start playing with software
you can visit [BitDust Commands](https://bitdust.io/commands.html) page. 

To get more info about API methods available go to [BitDust API](https://bitdust.io/api.html) page.



## Binary Dependencies

If you are installing BitDust on Windows platforms, you may require some binary packages already compiled and packaged for Microsoft Windows platforms, you can check following locations and download needed binaries and libraries:

* cygwin: [cygwin.com](https://cygwin.com/install.html)
* git: [git-scm.com](https://git-scm.com/download/win)
* python 2.7 (python3 is not supported yet): [python.org](http://python.org/download/releases)
* twisted 16.0 or higher: [twistedmatrix.com](http://twistedmatrix.com)
* pyasn1: [pyasn1.sourceforge.net](http://pyasn1.sourceforge.net)
* pyOpenSSL: [launchpad.net/pyopenssl](https://launchpad.net/pyopenssl)
* pycrypto: [dlitz.net/software/pycrypto](https://www.dlitz.net/software/pycrypto/)
* miniupnpc: [miniupnp.tuxfamily.org](http://miniupnp.tuxfamily.org/)



<div class=fbcomments markdown="1">
</div>
