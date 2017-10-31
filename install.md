# Install the software


## Get the software

Seems like in Ubuntu (probably most other distros) you can install all dependencies in that way:

        sudo apt-get install git python-dev python-setuptools python-pip python-virtualenv
        
        sudo apt-get install python-twisted python-django python-crypto python-pyasn1 python-psutil libffi-dev


Optionally, you can also install [miniupnpc](http://miniupnp.tuxfamily.org/) tool if you want BitDust automatically deal with UPnPc configuration of your network router so it can also accept incomming connections from other nodes.:

        sudo apt-get install miniupnpc


Second step is to get the BitDust sources:

        git clone https://gitlab.bitdust.io/stable/bitdust.latest.git bitdust


Then you need to build virtual environment with all required Python dependencies, BitDust software will run fully isolated.
Single command should make it for you, all required files will be generated in `~/.bitdust/venv/` sub-folder:

        cd bitdust
        python bitdust.py install


Last step to make BitDist software ready is to make a short alias in your OS, then you can just type `bitdust` in command line to fast access the program:
        
        sudo ln -s /home/<user>/.bitdust/bitdust /usr/local/bin/bitdust
        


## Run BitDist

Start using the software by creating an identity for your device in BitDust network:
       
        bitdust id create <some nick name>
       

I recommend you to create another copy of your Private Key in a safe place to be able to recover your data in the future. You can do it with such command:

        bitdust key copy <nickname>.bitdust.key


Your settings and local files are located in that folder: ~/.bitdust

Type this command to read more info about BitDust commands:

        bitdust help


To run the software type:

        bitdust
        

Start as background process:

        bitdust detach


To get some more insights or just to know how to start playing with software
you can visit [BitDust Commands](https://bitdust.io/commands.html) page. 



## Dependencies

If you are installing BitDust on Windows platforms, you may require some binary packages already compiled and packaged for Microsoft Windows platforms, you can check following locations and download needed binaries and libraries:

* cygwin: [cygwin.com](https://cygwin.com/install.html)
* git: [git-scm.com](https://git-scm.com/download/win)
* python 2.7 (python3 is not supported yet): [python.org](http://python.org/download/releases)
* twisted 11.0 or higher: [twistedmatrix.com](http://twistedmatrix.com)
* pyasn1: [pyasn1.sourceforge.net](http://pyasn1.sourceforge.net)
* pyOpenSSL: [launchpad.net/pyopenssl](https://launchpad.net/pyopenssl)
* pycrypto: [dlitz.net/software/pycrypto](https://www.dlitz.net/software/pycrypto/)
* wxgtk2.8: [wxpython.org](http://wiki.wxpython.org/InstallingOnUbuntuOrDebian)
* miniupnpc: [miniupnp.tuxfamily.org](http://miniupnp.tuxfamily.org/)


<div class=fbcomments markdown="1">
</div>