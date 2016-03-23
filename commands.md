# BitDust command line 

### Create an identity

    bitdust id create alice


### Some basic configuration

    bitdust set needed 100Mb
    bitdust set donated 250Mb
    bitdust set suppliers 7


### Start/Stop software

    bitdust
    bitdust detach
    bitdust stop
    bitdust restart


### Upload files/folders

    bitdust backup start ~/examples.desktop


### List of uploaded items

    bitdust backups
    bitdust backup list
    bitdust backup idlist


### Download from remote peers

    rm ~/examples.desktop
    bitdust restore 0/0/0
    ls ~/examples.desktop

    bitdust restore /home/veselin/examples.desktop /tmp
    ls /tmp/examples.desktop


### Remove remote data
    
    bitdust backup delete /home/veselin/examples.desktop


### Request the actual info from remote nodes 
 
    bitdust backups updated


### Open the GUI (development in progress, almost nothing is working)

    bitdust show


