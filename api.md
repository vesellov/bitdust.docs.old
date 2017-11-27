# BitDust API

## stop()

Stop the main process immediately.





    {'status': 'OK', 'result': 'stopped'}


## restart(showgui=False)

Restart the main process, if flag show=True the GUI will be opened after
restart.





    {'status': 'OK', 'result': 'restarted'}


## show()

Opens a default web browser to show the BitDust GUI.





    {'status': 'OK',   'result': '"show" event has been sent to the main process'}


## config\_get(key)

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


## key\_get(key\_id, include\_private=False)

Returns details of known private key.
Use `include_private=True` to get Private Key as openssh formated string.





    {'status': 'OK'.
     'result': [{
        'alias': 'cool',
        'creator': 'http://p2p-id.ru/testveselin.xml',
        'key_id': 'cool$testveselin@p2p-id.ru',
        'fingerprint': '50:f9:f1:6d:e3:e4:25:61:0c:81:6f:79:24:4e:78:17',
        'size': '4096',
        'ssh_type': 'ssh-rsa',
        'type': 'RSA',
        'public': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCPy7AXI0HuQSdmMF...',
        'private': '-----BEGIN RSA PRIVATE KEY-----\nMIIJKAIBAAKCAgEAj8uw...'
    }]}


## keys\_list(sort=False, include\_private=False)

List details for known Private Keys.
Use `include_private=True` to get Private Keys as openssh formated strings.




    {'status': 'OK',
     'result': [{
         'alias': 'master',
         'id': 'master$veselin@p2p-id.ru',
         'creator': 'http://p2p-id.ru/veselin.xml',
         'fingerprint': '60:ce:ea:98:bf:3d:aa:ba:29:1e:b9:0c:3e:5c:3e:32',
         'size': '2048',
         'ssh_type': 'ssh-rsa',
         'type': 'RSA',
         'public': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbpo3VYR5zvLe5...'
         'private': '-----BEGIN RSA PRIVATE KEY-----\nMIIJKAIBAAKCAgEAj8uw...'
     }, {
         'alias': 'another_key01',
         'id': 'another_key01$veselin@p2p-id.ru',
         'creator': 'http://p2p-id.ru/veselin.xml',
         'fingerprint': '43:c8:3b:b6:da:3e:8a:3c:48:6f:92:bb:74:b4:05:6b',
         'size': '4096',
         'ssh_type': 'ssh-rsa',
         'type': 'RSA',
         'public': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmgX6j2MwEyY...'
         'private': '-----BEGIN RSA PRIVATE KEY-----\nMIIJKsdAIBSjfAdfguw...'
    }]}


## key\_create(key\_alias, key\_size=4096, include\_private=False)

Generate new Private Key and add it to the list of known keys with given `key_id`.





    {'status': 'OK',
     'message': 'new private key "abcd" was generated successfully',
     'result': [{
        'alias': 'abcd',
        'id': 'abcd$veselin@p2p-id.ru',
        'creator': 'http://p2p-id.ru/veselin.xml',
        'fingerprint': 'bb:16:97:65:59:23:c2:5d:62:9d:ce:7d:36:73:c6:1f',
        'size': '4096',
        'ssh_type': 'ssh-rsa',
        'type': 'RSA',
        'public': 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8w2MhOPR/IoQ...'
        'private': '-----BEGIN RSA PRIVATE KEY-----\nMIIJKsdAIBSjfAdfguw...'
    }]}


## key\_erase(key\_id)

Removes Private Key from the list of known keys and erase local file.





    {'status': 'OK',
     'message': 'private key "ccc2" was erased successfully',
    }


## key\_share(key\_id, trusted\_global\_id\_or\_idurl, timeout=10)

Connect to remote node identified by `idurl` parameter and transfer private key `key_id` to that machine.
This way remote user will be able to access those of your files which were encrypted with that private key.

Returns:



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

WARNING: Those methods here will be deprecated and removed, use regular API methods instead.


## files\_sync()

Sends "restart" event to backup_monitor() Automat, this should start "data
synchronization" process with remote nodes. Normally all situations
should be handled automatically so you wont run this method manually,
but just in case.





    {'status': 'OK', 'result': 'the main files sync loop has been restarted'}


## files\_list(remote\_path=None)

Returns list of known files registered in the catalog under given `remote_path` folder.
By default returns items from root of the catalog.




    { u'execution': u'0.001040',
      u'result': [
                   { u'childs': False,
                     u'customer': u'veselin@veselin-p2p.ru',
                     u'glob_id': u'master$veselin@veselin-p2p.ru:1',
                     u'idurl': u'http://veselin-p2p.ru/veselin.xml',
                     u'key_id': u'master$veselin@veselin-p2p.ru',
                     u'latest': u'',
                     u'local_size': -1,
                     u'name': u'cats.png',
                     u'path': u'cats.png',
                     u'path_id': u'1',
                     u'size': 0,
                     u'type': u'file',
                     u'versions': []},
                   { u'childs': False,
                     u'customer': u'veselin@veselin-p2p.ru',
                     u'glob_id': u'master$veselin@veselin-p2p.ru:2',
                     u'idurl': u'http://veselin-p2p.ru/veselin.xml',
                     u'key_id': u'master$veselin@veselin-p2p.ru',
                     u'latest': u'',
                     u'local_size': 345418,
                     u'name': u'dogs.jpg',
                     u'path': u'dogs.jpg',
                     u'path_id': u'2',
                     u'size': 0,
                     u'type': u'file',
                     u'versions': []},
                  ],
      u'status': u'OK'}


## file\_info(remote\_path, include\_uploads=True, include\_downloads=True)



## file\_create(remote\_path, as\_folder=False)



## file\_delete(remote\_path)



## files\_uploads(include\_running=True, include\_pending=True)

Returns a list of currently running uploads and
list of pending items to be uploaded.





    { 'status': 'OK',
      'result': {
        'running': [{
            'aborting': False,
            'version': '0/0/3/1/F20160424013912PM',
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
        }],
        'pending': [{
            'created': 'Wed Apr 27 15:11:13 2016',
            'id': 3,
            'source_path': '/Users/veselin/Downloads/another-ZIP-file.zip',
            'path_id': '0/0/3/2'
        }]
    }


## file\_upload\_start(local\_path, remote\_path, wait\_result=True)



## file\_upload\_stop(remote\_path)



## files\_downloads()

Returns a list of currently running downloads.





    {'status': 'OK',
     'result': [{
        'aborted': False,
        'backup_id': '0/0/3/1/F20160427011209PM',
        'block_number': 0,
        'bytes_processed': 0,
        'creator_id': 'http://veselin-p2p.ru/veselin.xml',
        'done': False,
        'key_id': 'abc$veselin@veselin-p2p.ru',
        'created': 'Wed Apr 27 15:11:13 2016',
        'eccmap': 'ecc/4x4',
        'path_id': '0/0/3/1',
        'version': 'F20160427011209PM'
    }]}


## file\_download\_start(remote\_path, destination\_path=None, wait\_result=False)

Download data from remote suppliers to your local machine. You can use
different methods to select the target data with `remote_path` input:

  + "remote path" of the file
  + item ID in the catalog
  + full version identifier with item ID

It is possible to select the destination folder to extract requested files to.
By default this method uses specified value from local settings or user home folder

WARNING: Your existing local data will be overwritten!





    {'status': 'OK', 'result': 'downloading of version 0/0/1/1/0/F20160313043419PM has been started to /Users/veselin/'}


## file\_download\_stop(remote\_path)

Abort currently running restore process.





    {'status': 'OK', 'result': 'restoring of "alice@p2p-host.com:0/1/2" aborted'}


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


## user\_ping(idurl, timeout=10)

Sends Identity packet to remote peer and wait for Ack packet to check connection status.
The "ping" command performs following actions:

  1. Request remote identity source by idurl,
  2. Sends my Identity to remote contact addresses, taken from identity,
  3. Wait first Ack packet from remote peer,
  4. Failed by timeout or identity fetching error.

You can use this method to check and be sure that remote node is alive at the moment.





    {'status': 'OK', 'result': '(signed.Packet[Ack(Identity) bob|bob for alice], in_70_19828906(DONE))'}


## user\_search(nickname)

Starts nickname_observer() Automat to lookup existing nickname registered
in DHT network.


## set\_my\_nickname(nickname)

Starts nickname_holder() machine to register and keep your nickname in DHT
network.


## find\_peer\_by\_nickname(nickname)

Starts nickname_observer() Automat to lookup existing nickname registered
in DHT network.


## send\_message(recipient, message\_body)

Sends a text message to remote peer, `recipient` is a string with nickname or global_id.





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


## message\_send(recipient, message\_body)

Sends a text message to remote peer, `recipient` is a string with nickname or global_id.





    {'status': 'OK', 'result': ['signed.Packet[Message(146681300413)]']}


## message\_receive(consumer\_id)

This method can be used to listen and process incoming chat messages by specific consumer.
If there are no messages received yet, this method will be waiting for any incomings.
If some messages was already received, but not "consumed" yet method will return them imediately.
After you got response and processed the messages you should call this method again to listen
for more incomings again. This is simillar to message queue polling interface.
If you do not "consume" messages, after 100 un-collected messages "consumer" will be dropped.
Both, incoming and outgoing, messages will be populated here.





    {'status': 'OK',
     'result': [{
        'type': 'private_message',
        'dir': 'incoming',
        'id': '123456788',
        'sender': 'abc$alice@first-host.com',
        'recipient': 'abc$bob@second-host.net',
        'message': 'Hello World!',
        'time': 123456789
    }]}


## broadcast\_send\_message(payload)

Sends broadcast message to all peers in the network.

Message must be provided in `payload` argument is a Json object.

WARNING! Please, do not send too often and do not send more then
several kilobytes per message.


## event\_send(event\_id, json\_data=None)


## network\_stun(udp\_port=None, dht\_port=None)



## network\_reconnect()

Sends "reconnect" event to network_connector() Automat in order to refresh
network connection.





    {'status': 'OK', 'result': 'reconnected'}




