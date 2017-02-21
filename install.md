# Install the software


Seems like in Ubuntu (probably most other distros) you just need to install all dependencies at first step:

        sudo apt-get install git python-dev python-twisted python-setuptools python-pip python-django
        pip instycrypto psutil 
    
Optionally, you can also install [miniupnpc](http://miniupnp.tuxfamily.org/) tool if you want BitDust automatically deal with UPnPc configuration of your network router so it can also accept incomming connections from other nodes.:

        sudo apt-get install miniupnpc


Get Sources:

        git clone http://gitlab.bitdust.io/devel/bitdust.git


Create an alias in OS so you can easily run the program from any location:

        cd bitdust
        python bitdust.py alias > sudo tee /usr/bin/bitdust
        sudo chmod +x /usr/bin/bitdust
        

Create an identity for you in the BitDust network:
       
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
you can visit [BitDust Commands](http://bitdust.io/commands.html) page. 


## Known dependencies

python 2.6 or 2.7, python3 is not supported
    http://python.org/download/releases
    
twisted 11.0 or higher: 
    http://twistedmatrix.com
    
pyasn1: 
    http://pyasn1.sourceforge.net
    
pyOpenSSL: 
    https://launchpad.net/pyopenssl
    
pycrypto: 
    https://www.dlitz.net/software/pycrypto/

wxgtk2.8: 
    http://wiki.wxpython.org/InstallingOnUbuntuOrDebian

miniupnpc:
    http://miniupnp.tuxfamily.org/
