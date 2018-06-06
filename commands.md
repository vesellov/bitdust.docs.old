# BitDust command line 

## Commands

### start
start main BitDust process


### detach
start BitDust in as a daemon process


### restart
restart BitDust 


### stop                
stop BitDust


### show                
start BitDust and show the main window


### integrate           
creates a `bitdust` alias in OS
in /usr/local/bin/bitdust or in
~/bin/bitdust if no access to /usr/local/ 


### identity create [nickname] [private key size]
generate a new private key and 
new identity file for you
key size can be 1024, 2048 or 4096


### identity restore [private key source file] [IDURL]
recover existing identity file
with your private key file


### identity erase
delete local identity from this machine 


### key copy            
copy private key to clipboard,
use Ctrl+V to paste it


### key backup [a filename for copy of private key]
copy private key into file


### key print
print private key to console
WARNING!!! never publish your key


### get [option]
print current value for given program setting


### set [option] [value]
use this command to set program setting


### set list            
print all available settings and its values


### file list
show a full catalog of registered
files and folders


### file idlist
show a list of items already uploaded
on remote peers 


### file bind [local path]
add given path as a top level item in the catalog


### file add [local path]
replicate given path into the catalog,
this will add to catalog all parent folders too


### file addtree [local folder path]
replicate given folder with
all sub folders to the catalog,
be aware if you add too much items to catalog
the software may operate inefficient    


### file start [local path or ID]
start uploading a catalog item on to remote peers,
bind a new local file/folder if path is not yet
existing in the catalog 


### file delete [local path, ID or full backup ID]
remove a file or folder (with all sub folders)
from catalog or only erase a given remote copy


### file delete local [full backup ID]
remove only local copy of given backup,
keep remote copy on suppliers HDD

### file queue        
show a list of paths to be uploaded


### file progress
show a list of currently running uploads


### file sync       
request all suppliers to check/restart uploads


### restore list
show a list of items already uploaded on remote peers


### restore start [local path or ID] [destination path]
download personal data back to local machine
from remote peers, you can specify 
the destination path on your local drive,
WARNING! source path is default location,
so it will overwrite existing files by default


### restore abort [backup ID]
abort currently running restore process of given item


### restore progress 
show currently running downloads 


### supplier list       
show list of your suppliers
nodes who stores your data on own machines


### supplier replace [IDURL or position]
execute a fire/hire process for given supplier,
another random node will replace him


### supplier change [IDURL or position] [new IDURL]
replace a supplier by given node


### supplier ping       
send Identity packet to all suppliers
and wait Ack packets to check their statuses


### customer list       
show list of your customers
nodes who stores own data on your machine


### customer remove [IDURL]
reject supporting given customer and
remove all local files stored for him


### customer ping       
send Identity packet to all customers
and wait Ack packets to check their statuses


### storage
show donated/needed storage statistic 


### automat list
list all running state machines and current states


### service list
list all registered services


### service [service name]
print detailed info for given service


### ping [IDURL]        
send Identity packet to this node
and wait Ack packet to check his status


### chat
start a chat session, send/listen text
messages from other users


### chat send [IDURL] ["text message"]
send a single text message to remote user


### api [method] [params]
execute API method and return JSON response


### version             
display current software version


### help                
print a detailed info for command line usage


### usage               
print a brief list of available commands


## Options:

-h, --help        
show this help message and exit

-d DEBUG, --debug=DEBUG
set debug level

-q, --quite     
quite mode, do not print any messages to stdout

-v, --verbose   
verbose mode, print more messages

-n, --no-logs   
do not use logs

-o OUTPUT, --output=OUTPUT
print log messages to the file

-a APPDIR, --appdir=APPDIR
set alternative location 
for application data files,
default is ~/.bitdust/

--twisted       
show twisted log messages too




## Examples

#### Create an identity

    bitdust id create alice


#### Backup the Private Key

    bitdust key backup ~/bitdust-alice-private.key
    

#### Some basic configuration

    bitdust set needed 100Mb
    bitdust set donated 250Mb
    bitdust set suppliers 7


#### Start/Stop software

    bitdust
    bitdust detach
    bitdust stop
    bitdust restart


#### Upload files/folders

    bitdust backup start ~/examples.desktop


#### List of uploaded items

    bitdust backups
    bitdust backup list
    bitdust backup idlist


#### Download from remote peers

    rm ~/examples.desktop
    bitdust restore 0/0/0
    ls ~/examples.desktop

    bitdust restore /home/veselin/examples.desktop /tmp
    ls /tmp/examples.desktop


#### Remove remote data
    
    bitdust backup delete /home/veselin/examples.desktop


#### Request the actual info from remote nodes 
 
    bitdust backups updated


#### Ping all suppliers to check their current status

    bitdust suppliers ping
    
#### Ping a given node by IDURL

    bitdust ping http://p2p-id.ru/veselin.xml

#### Get some info about donated and consumed space usage

    bitdust storage

#### Print a list of program settings

    bitdust set list
    
#### Modify a single setting

    bitdust set logs/debug-level 8
