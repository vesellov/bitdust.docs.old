# BitDust Demo

## Windows Installer

[bitdust-setup.exe](https://bitdust.io/download/bitdust-setup.exe)


## Ubuntu / Debian package

[bitdust-ubuntu-devel.deb](https://bitdust.io/download/bitdust-ubuntu-devel.deb)


## Explanation

Now ready very limited demo version of BitDust software.
We publish this earlier works to verify and test our ideas of the full distribution of information flows in the network.

Available only the most basic functions:

  + enter the network
  + upload files and folders
  + download backed up data back to your local machine
  + remove uploaded data from the network
    
Many other functions have been implemented earlier, but still do not have a graphical interface.
Those functions that will be opened in the future, are displayed but not available. 
Product development continues.


## Dependencies

Windows users can use the following links to install necessary packages themselves:

  + [python 2.7](http://python.org/download/releases) 
  + [twisted 15.0](http://twistedmatrix.com) 
  + [pyasn1](http://pyasn1.sourceforge.net)
  + [pyOpenSSL](https://launchpad.net/pyopenssl)
  + [pycrypto](https://www.dlitz.net/software/pycrypto/)
  + [wxPython3](http://wxpython.org/)

In Ubuntu you can quickly get all dependencies in this way:

    sudo apt-get update
    sudo apt-get install git python python-twisted python-pyasn1 python-openssl python-crypto python-wxgtk3

    
## Git Repositories:
  + Development : [http://gitlab.bitdust.io/devel/bitdust.devel.git](http://gitlab.bitdust.io/devel/bitdust.devel.git)
  + Public : [http://gitlab.bitdust.io/devel/bitdust.git](http://gitlab.bitdust.io/devel/bitdust.git)
  + Most stable up-to-date : [http://gitlab.bitdust.io/stable/bitdust.latest.git](http://gitlab.bitdust.io/stable/bitdust.latest.git)


## Run from Sources

    git clone http://gitlab.bitdust.io/stable/bitdust.latest.git bitdust
    cd bitdust
    python bitdust.py

    
    

<div class=fbcomments markdown="1">
</div>