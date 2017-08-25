# BitDust API

## stop()

Stop the main process immediately.





    {'status': 'OK', 'result': 'stopped'}


## restart(showgui=False)

Restart the main process, if flag show=True the GUI will be opened after
restart.





    {'status': 'OK', 'result': 'restarted'}


## reconnect()

Sends "reconnect" event to network_connector() Automat in order to refresh
network connection.





    {'status': 'OK', 'result': 'reconnected'}


## show()

Opens a default web browser to show the BitDust GUI.





    {'status': 'OK',   'result': '"show" event has been sent to the main process'}


## config\_get(key, default=None)

Returns current value for specific option from program settings.





    {'status': 'OK',   'result': [{'type': 'positive integer', 'value': '8', 'key': 'logs/debug-level'}]}


## config\_set(key, value)

Set a value for given option.





    {'status': 'OK', 'result': [{'type': 'positive integer', 'old_value': '8', 'value': '10', 'key': 'logs/debug-level'}]}


## config\_list(sort=False)

Provide detailed info about all options and values from settings.





    {'status': 'OK',
     'result': [{
        'type': 'boolean',
        'value': 'true',
        'key': 'services/backups/enabled'
     }, {
        'type': 'boolean',
        'value': 'false',
        'key': 'services/backups/keep-local-copies-enabled'
     }, {
        'type': 'diskspace',
        'value': '128 MB',
        'key': 'services/backups/max-block-size'
    }]}


## keys\_list(sort=False)

List details for known private keys.


## key\_create(key\_id, key\_size=4096)



## key\_erase(key\_id)



## filemanager(json\_request)

A service method to execute calls from GUI front-end and interact with web
browser. This is a special "gates" created only for Ajax calls from GUI. It
provides same methods as other functions here, but just in a different way.

    Request:
        {"params":{"mode":"stats"}}

    Response:
        {'bytes_donated': 8589934592,
         'bytes_indexed': 43349475,
         'bytes_needed': 104857600,
         'bytes_used_supplier': 21738768,
         'bytes_used_total': 86955072,
         'customers': 0,
         'files_count': 5,
         'folders_count': 0,
         'items_count': 15,
         'max_suppliers': 4,
         'online_suppliers': 0,
         'suppliers': 4,
         'timestamp': 1458669668.288339,
         'value_donated': '8 GB',
         'value_needed': '100 MB',
         'value_used_total': '82.93 MB'}

You can also access those methods with another API "alias": `filemanager_{ mode }({ extra params })`



## backups\_update()

Sends "restart" event to backup_monitor() Automat, this should start "data
synchronization" process with remote nodes.





    {'status': 'OK', 'result': 'the main loop has been restarted'}


## backups\_list()

Returns a whole tree of files and folders in the catalog.





    {'status': 'OK',
     'result': [{
        'path': '/Users/veselin/Documents',
        'versions': [],
        'type': 'parent',
        'id': '0/0/1',
        'size': 38992196
      }, {
        'path': '/Users/veselin/Documents/python',
        'versions': [],
        'type': 'parent',
        'id': '0/0/1/0',
        'size': 5754439
      }, {
        'path': '/Users/veselin/Documents/python/python27.chm',
        'versions': [{
            'version': 'F20160313043757PM',
            'blocks': 1,
            'size': '11 MB'
        }],
        'type': 'file',
        'id': '0/0/1/0/0',
        'size': 5754439
    }]}


## backups\_id\_list()

Returns only list of items uploaded on remote machines.





    {'status': 'OK',
     'result': [{
        'backupid': '0/0/1/0/0/F20160313043757PM',
        'path': '/Users/veselin/Documents/python/python27.chm',
        'size': '11 MB'
     }, {
        'backupid': '0/0/0/0/0/0/F20160315052257PM',
        'path': '/Users/veselin/Music/Bob Marley/01-Soul Rebels (1970)/01-Put It On.mp3',
        'size': '8.27 MB'
    }]}


## backup\_start\_id(pathID)

Start uploading a given item already existed in the catalog by its path ID.





    {'status': 'OK', 'result': 'uploading 0/0/1/0/0 started, local path is: /Users/veselin/Documents/python/python27.chm'}


## backup\_start\_path(path, mount\_path=None, key\_id=None)

Start uploading file or folder to remote nodes. It will generate a new path
ID for this file or folder and add it to the catalog.
If `mount_path` is `None` method will create a new file (or folder) and
all parent sub folders will be also added to the catalog:

    ["Users", "Users/veselin", "Users/veselin/Documents", "Users/veselin/Documents/python",]

Final ID of that item will be combined from parent IDs and target file or folder ID:

    0/0/1/0/0

In case `mount_path` is set it will act like backup_map_path()
and start the backup process: item will be created in the `mount_path` location.





    {'status': 'OK',
     'result': 'uploading of item 0/0/1/0/0 started, local path is: /Users/veselin/Documents/python/python27.chm',
     'id': '0/0/1/0/0',
     'type': 'file',
     'key_id': 'abc'}


## backup\_map\_path(path, mount\_path, key\_id=None)

Create a new top level item in the catalog and point it to given local
path. This is the simplest way to upload a file and get an ID for that
remote copy. Given local `path` will be mapped to virtual `mount_path`,
which must not exist in the catalog yet.





    {'status': 'OK',
     'result': [ 'new file was added: 1, local path is /Users/veselin/Pictures/bitdust.png'],
     'id': '1',
     'type': 'file',
     'key_id': 'abc'}


## backup\_dir\_make(dirpath, key\_id=None)

Creates empty folder in catalog.





    {'status': 'OK', 'result': 'new folder was added: 0/0/8, local path is /Users/veselin/Desktop/', 'key_id': 'abc'}


## backup\_dir\_add(dirpath, key\_id=None)

Add given folder to the catalog but do not start uploading process. This
method will create all sub folders in the catalog and keeps the same
structure as your local folders structure. So the final ID will be
combination of all parent IDs, separated with "/".





    {'status': 'OK', 'result': 'new folder was added: 0/0/2, local path is /Users/veselin/Movies/', 'key_id': 'abc'}


## backup\_file\_add(filepath, key\_id=None)

Add a single file to the catalog, skip uploading. This method will create
all sub folders in the catalog and keeps the same structure as your local
file path structure. So the final ID of that file in the catalog will be
combination of all parent IDs, separated with "/".





    {'status': 'OK', 'result': 'new file was added: 0/0/3/0, local path is /Users/veselin/Downloads/pytest-2.9.0.tar.gz', 'key_id': 'abc'}


## backup\_tree\_add(dirpath, key\_id=None)

Recursively reads the entire folder and create items in the catalog. For
all files and folders it will keeping the same files/folders structure.
This method will not start any uploads, just append items to the catalog.





    {'status': 'OK',
     'result': '21 items were added to catalog, parent path ID is 0/0/1/2, root folder is /Users/veselin/Documents/reports',
     'key_id': 'abc'}


## backup\_delete\_local(backupID)

Remove only local files belongs to this particular backup. All remote data
stored on suppliers' machines remain unchanged.





    {'status': 'OK',   'result': '8 files were removed with total size of 16 Mb'}


## backup\_delete\_id(pathID\_or\_backupID)

Delete local and remote copies of given item in catalog. This will
completely remove your data from BitDust network. You can specify either
path ID of that location or specific version.





    {'status': 'OK',   'result': 'version 0/0/1/1/0/F20160313043419PM was deleted from remote peers'}


## backup\_delete\_path(localPath)

Completely remove any data stored on given location from BitDust network.
All data for given item will be removed from remote peers. Any local files
related to this path will be removed as well.





    {'status': 'OK',   'result': 'item 0/1/2 was deleted from remote peers'}


## backups\_queue()

Returns a list of paths to be backed up as soon as currently running
backups finish.





    {'status': 'OK',
     'result': [{
         'created': 'Wed Apr 27 15:11:13 2016',
         'id': 3,
         'local_path': '/Users/veselin/Downloads/some-ZIP-file.zip',
         'path_id': '0/0/3/1'
    }]}


## backups\_running()

Returns a list of currently running uploads.





    {'status': 'OK',
     'result': [{
         'aborting': False,
         'backup_id': '0/0/3/1/F20160424013912PM',
         'block_number': 4,
         'block_size': 16777216,
         'bytes_processed': 67108864,
         'closed': False,
         'eccmap': 'ecc/4x4',
         'eof_state': False,
         'pipe': 0,
         'progress': 75.0142815704418,
         'reading': False,
         'source_path': '/Users/veselin/Downloads/some-ZIP-file.zip',
         'terminating': False,
         'total_size': 89461450,
         'work_blocks': 4
    }]}


## backup\_cancel\_pending(path\_id)

Cancel pending task to run backup of given item.





    {'status': 'OK', 'result': 'item 123 cancelled'}


## backup\_abort\_running(backup\_id)

Abort currently running backup.





    {'status': 'OK', 'result': 'backup 0/0/3/1/F20160424013912PM aborted'}


## restore\_single(pathID\_or\_backupID\_or\_localPath, destinationPath=None)

Download data from remote peers to your local machine. You can use
different methods to select the target data:

  + item ID in the catalog
  + full version identifier
  + local path

It is possible to select the destination folder to extract requested files to.
By default this method uses known location from catalog for given item.

WARNING: Your existing local data will be overwritten!





    {'status': 'OK', 'result': 'downloading of version 0/0/1/1/0/F20160313043419PM has been started to /Users/veselin/Downloads/restore/'}


## restores\_running()

Returns a list of currently running downloads.





    {'status': 'OK',
     'result': [{
        'aborted': False,
        'backup_id': '0/0/3/1/F20160427011209PM',
        'block_number': 0,
        'bytes_processed': 0,
        'creator_id': 'http://veselin-p2p.ru/veselin.xml',
        'done': False,
        'created': 'Wed Apr 27 15:11:13 2016',
        'eccmap': 'ecc/4x4',
        'path_id': '0/0/3/1',
        'version': 'F20160427011209PM'
    }]}


## restore\_abort(backup\_id)

Abort currently running restore process.





    {'status': 'OK',  'result': 'restoring of item 123 aborted'}


## suppliers\_list()

This method returns a list of suppliers - nodes which stores your encrypted data on own machines.





    {'status': 'OK',
     'result':[{
        'connected': '05-06-2016 13:06:05',
        'idurl': 'http://p2p-id.ru/bitdust_j_vps1014.xml',
        'numfiles': 14,
        'position': 0,
        'status': 'offline'
     }, {
        'connected': '05-06-2016 13:04:57',
        'idurl': 'http://veselin-p2p.ru/bitdust_j_vps1001.xml',
        'numfiles': 14,
        'position': 1,
        'status': 'offline'
    }]}


## supplier\_replace(index\_or\_idurl)

Execute a fire/hire process for given supplier, another random node will
replace this supplier. As soon as new supplier is found and connected,
rebuilding of all uploaded data will be started and the new node will start
getting a reconstructed fragments.





    {'status': 'OK', 'result': 'supplier http://p2p-id.ru/alice.xml will be replaced by new peer'}


## supplier\_change(index\_or\_idurl, new\_idurl)

Doing same as supplier_replace() but new node must be provided by you - you can manually assign a supplier.





    {'status': 'OK', 'result': 'supplier http://p2p-id.ru/alice.xml will be replaced by http://p2p-id.ru/bob.xml'}


## suppliers\_ping()

Sends short requests to all suppliers to get their current statuses.





    {'status': 'OK',  'result': 'requests to all suppliers was sent'}


## customers\_list()

List of customers - nodes who stores own data on your machine.





    {'status': 'OK',
     'result': [ {  'idurl': 'http://p2p-id.ru/bob.xml',
                    'position': 0,
                    'status': 'offline'
    }]}


## customer\_reject(idurl)

Stop supporting given customer, remove all his files from local disc, close
connections with that node.





    {'status': 'OK', 'result': 'customer http://p2p-id.ru/bob.xml rejected, 536870912 bytes were freed'}


## customers\_ping()

Sends Identity packet to all customers to check their current statuses.
Every node will reply with Ack packet on any valid incoming Identiy packet.





    {'status': 'OK',  'result': 'requests to all customers was sent'}


## space\_donated()

Returns detailed statistics about your donated space usage.





    {'status': 'OK',
     'result': [{
        'consumed': 0,
        'consumed_percent': '0%',
        'consumed_str': '0 bytes',
        'customers': [],
        'customers_num': 0,
        'donated': 1073741824,
        'donated_str': '1024 MB',
        'free': 1073741824,
        'old_customers': [],
        'real': 0,
        'used': 0,
        'used_percent': '0%',
        'used_str': '0 bytes'
    }]}


## space\_consumed()

Returns some info about your current usage of BitDust resources.





    {'status': 'OK',
     'result': [{
        'available': 907163720,
        'available_per_supplier': 907163720,
        'available_per_supplier_str': '865.14 MB',
        'available_str': '865.14 MB',
        'needed': 1073741824,
        'needed_per_supplier': 1073741824,
        'needed_per_supplier_str': '1024 MB',
        'needed_str': '1024 MB',
        'suppliers_num': 2,
        'used': 166578104,
        'used_per_supplier': 166578104,
        'used_per_supplier_str': '158.86 MB',
        'used_percent': '0.155%',
        'used_str': '158.86 MB'
    }]}


## space\_local()

Returns detailed statistics about current usage of your local disk.





    {'status': 'OK',
     'result': [{
        'backups': 0,
        'backups_str': '0 bytes',
        'customers': 0,
        'customers_str': '0 bytes',
        'diskfree': 103865696256,
        'diskfree_percent': '0.00162%',
        'diskfree_str': '96.73 GB',
        'disktotal': 63943473102848,
        'disktotal_str': '59552 GB',
        'temp': 48981,
        'temp_str': '47.83 KB',
        'total': 45238743,
        'total_percent': '0%',
        'total_str': '43.14 MB'
    }]}


## automats\_list()

Returns a list of all currently running state machines.





    {'status': 'OK',
     'result': [{
        'index': 1,
        'name': 'initializer',
        'state': 'READY',
        'timers': ''
      }, {
        'index': 2,
        'name': 'shutdowner',
        'state': 'READY',
        'timers': ''
    }]}


## services\_list()

Returns detailed info about all currently running network services.





    {'status': 'OK',
     'result': [{
        'config_path': 'services/backup-db/enabled',
        'depends': ['service_list_files', 'service_data_motion'],
        'enabled': True,
        'index': 3,
        'installed': True,
        'name': 'service_backup_db',
        'state': 'ON'
      }, {
        'config_path': 'services/backups/enabled',
        'depends': ['service_list_files', 'service_employer', 'service_rebuilding'],
        'enabled': True,
        'index': 4,
        'installed': True,
        'name': 'service_backups',
        'state': 'ON'
    }]}


## service\_info(service\_name)

Returns detailed info for single service.





    {'status': 'OK',
     'result': [{
        'config_path': 'services/tcp-connections/enabled',
        'depends': ['service_network'],
        'enabled': True,
        'index': 24,
        'installed': True,
        'name': 'service_tcp_connections',
        'state': 'ON'
    }]}


## service\_start(service\_name)

Start given service immediately. This method also set `True` for
correspondent option in the program settings:

    .bitdust/config/services/[service name]/enabled

If some other services, which is dependent on that service,
were already enabled, they will be started also.





    {'status': 'OK', 'result': 'service_tcp_connections was switched on'}


## service\_stop(service\_name)

Stop given service immediately. It will also set `False` for correspondent
option in the settings.

    .bitdust/config/services/[service name]/enabled

Dependent services will be stopped as well.





    {'status': 'OK', 'result': 'service_tcp_connections was switched off'}


## packets\_stats()

Returns detailed info about current network usage.





    {'status': 'OK',
     'result': [{
        'in': {
            'failed_packets': 0,
            'total_bytes': 0,
            'total_packets': 0,
            'unknown_bytes': 0,
            'unknown_packets': 0
        },
        'out': {
            'http://p2p-id.ru/bitdust_j_vps1014.xml': 0,
            'http://veselin-p2p.ru/bitdust_j_vps1001.xml': 0,
            'failed_packets': 8,
            'total_bytes': 0,
            'total_packets': 0,
            'unknown_bytes': 0,
            'unknown_packets': 0
    }}]}


## packets\_list()

Return list of incoming and outgoing packets.


## connections\_list(wanted\_protos=None)

Returns list of opened/active network connections. Argument `wanted_protos`
can be used to select which protocols to list:

    connections_list(wanted_protos=['tcp', 'udp'])


## streams\_list(wanted\_protos=None)

Return list of active sending/receiveing files.


## ping(idurl, timeout=10)

Sends Identity packet to remote peer and wait for Ack packet to check connection status.
The "ping" command performs following actions:

  1. Request remote identity source by idurl,
  2. Sends my Identity to remote contact addresses, taken from identity,
  3. Wait first Ack packet from remote peer,
  4. Failed by timeout or identity fetching error.

You can use this method to check and be sure that remote node is alive at the moment.





    {'status': 'OK', 'result': '(signed.Packet[Ack(Identity) bob|bob for alice], in_70_19828906(DONE))'}


## set\_my\_nickname(nickname)

Starts nickname_holder() machine to register and keep your nickname in DHT
network.


## find\_peer\_by\_nickname(nickname)

Starts nickname_observer() Automat to lookup existing nickname registered
in DHT network.


## send\_message(recipient, message\_body)

Sends a text message to remote peer.





    {'status': 'OK', 'result': ['signed.Packet[Message(146681300413)]']}


## receive\_one\_message()

This method can be used to listen and process incoming chat messages.

  + creates a callback to receive all incoming messages,
  + wait until one incoming message get received,
  + remove the callback after receiving the message.

After you received the message you can call this method again,
this is very simillar to message queue polling interface.





    {'status': 'OK',
     'result': [{
        'from': 'http://veselin-p2p.ru/bitdust_j_vps1001.xml',
        'message': 'Hello my dear Friend!'
    }]}


## broadcast\_send\_message(payload)

Sends broadcast message to all peers in the network.

Message must be provided in `payload` argument is a Json object.

WARNING! Please, do not send too often and do not send more then
several kilobytes per message.




