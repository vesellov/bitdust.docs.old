# BitDust API

### stop()

Stop the main process immediately.

    "{'status': 'OK', 'result': 'stopped'}"


### restart(showgui=False)

Restart the main process, if flag show=True the GUI will be opened after restart.

    "{'status': 'OK', 'result': 'restarted'}"


### show()

Opens a default web browser to show the BitDust GUI.

    "{'status': 'OK', 
      'result': '`show` event has been sent to the main process'}"


### config\_get(key, default=None)

Return current value for specific option.
 
    "{'status': 'OK',
      'result': [
         {'type': 'positive integer',
          'value': '8', 
          'key': 'logs/debug-level'}]}"    


### config\_set(key, value, typ=None)

Set a value for given option.
 
    "{'status': 'OK',
      'result': [
         {'type': 'positive integer',
          'old_value': '8',
          'value': '10',
          'key': 'logs/debug-level'}]}"


### config\_list(sort=False)

Monitor all options and values.

    "{'status': 'OK',
      'result': [
         {'type': 'boolean',
          'value': 'true',
          'key': 'services/backups/enabled'}, 
         {'type': 'boolean',
          'value': 'false',
          'key': 'services/backups/keep-local-copies-enabled'},
         {'type': 'disk space',
          'value': '128 MB',
          'key': 'services/backups/max-block-size'}]}"


### filemanager(json\_request)

A method to execute calls from GUI front-end and interact with web browser.
This is a special "gates" created only for Ajax calls from GUI - for 
for specific file system io operations.

    request:
        {"params":{"mode":"stats"}}
    response:
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

You can also access those methods with API alias:
    filemanager_{method name}()
More info will be added soon.


### backups\_update()

A method to restart backup_monitor() Automat and 
fire "synchronize" process with remote nodes.

    "{'status': 'OK', 'result': 'the main loop has been restarted'}"


### backups\_list()

Return a whole tree of files and folders in the catalog.

    "{'status': 'OK', 
      'result': [
         {'path': '/Users/veselin/Documents', 
          'versions': [], 
          'type': 'parent', 
          'id': '0/0/1', 
          'size': 38992196}, 
         {'path': '/Users/veselin/Documents/python', 
          'versions': [], 
          'type': 'parent', 
          'id': '0/0/1/0', 
          'size': 5754439}, 
         {'path': '/Users/veselin/Documents/python/python27.chm', 
          'versions': [
              {'version': 'F20160313043757PM', 
               'blocks': 1, 
               'size': '11 MB'}], 
          'type': 'file', 
          'id': '0/0/1/0/0', 
          'size': 5754439}]}"    


### backups\_id\_list()

Return only list of items uploaded on remote machines.

    "{'status': 'OK', 
      'result': [{'backupid': '0/0/1/0/0/F20160313043757PM', 
                  'path': '/Users/veselin/Documents/python/python27.chm', 
                  'size': '11 MB'}, 
                 {'backupid': '0/0/0/0/0/0/F20160315052257PM', 
                  'path': '/Users/veselin/Music/Bob Marley/01-Soul Rebels (1970)/01-Put It On.mp3', 
                  'size': '8.27 MB'}]}"        


### backup\_start\_id(pathID)

Start uploading a given item already existed in the catalog by its path ID.

    "{'status': 'OK', 
      'result': 'uploading 0/0/1/0/0 started, local path is: /Users/veselin/Documents/python/python27.chm'}"


### backup\_start\_path(path)

Start uploading file or folder to remote nodes, assign a new path ID and add it to the catalog.

    "{'status': 'OK',
      'result': 'uploading 0/0/1/0/0 started, local path is: /Users/veselin/Documents/python/python27.chm'}"


### backup\_dir\_add(dirpath)

Add given folder to the catalog but do not start uploading process.

    "{'status': 'OK',
      'result': 'new folder was added: 0/0/2, local path is /Users/veselin/Movies/'}" 


### backup\_file\_add(filepath)
  
Add a single file to the catalog, skip uploading.

    "{'status': 'OK', 'result': 'new file was added: 0/0/3/0, local path is /Users/veselin/Downloads/pytest-2.9.0.tar.gz'}"
 

### backup\_tree\_add(dirpath)

Recursively reads the entire folder and put files and folders items into the catalog,
but did not start any uploads.
Results:
    "{'status': 'OK',
      'result': '21 items were added to catalog, parent path ID is 0/0/1/2, root folder is /Users/veselin/Documents/reports'}"


### backup\_delete\_local(backupID)

Remove only local files belongs to this particular backup.
All remote data stored on suppliers machines remains unchanged.

    "{'status': 'OK',
      'result': '8 files were removed with total size of 16 Mb'}"


### backup\_delete\_id(pathID\_or\_backupID)

Delete local and remote copies of given item in catalog.
This will completely remove your data from BitDust network.
You can specify either path ID of that location or specific version.

    "{'status': 'OK',
      'result': 'version 0/0/1/1/0/F20160313043419PM was deleted from remote peers'}"


### backup\_delete\_path(localPath)

Completely remove any data stored for given location from BitDust network.
All data for given item will be removed from remote peers.
Any local files related to this path will be removed as well.

    "{'status': 'OK',
      'result': 'item 0/1/2 was deleted from remote peers'}"


### backups\_queue()

Return a list of paths to be backed up as soon as
currently running backups will be finished.
    "{'status': 'OK',
      'result': [    
        {'created': 'Wed Apr 27 15:11:13 2016',
         'id': 3,
         'local_path': '/Users/veselin/Downloads/some-ZIP-file.zip',
         'path_id': '0/0/3/1'}]}"


### backups\_running()

Return a list of currently running uploads:
    "{'status': 'OK',
      'result': [    
        {'aborting': False,
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
         'work_blocks': 4}
    ]}"    


### backup\_cancel\_pending(path\_id)

Cancel pending task to backup given item from catalog. 


### backup\_abort\_running(backup\_id)

Abort currently running backup.


### restore\_single(pathID\_or\_backupID\_or\_localPath, destinationPath=None)

Download data from remote peers to you local machine.
You can use different methods to select the target data:
    + item ID in the catalog
    + full version identifier
    + local path
It is possible to select the destination folder to extract requested files to.
By default this method uses known location from catalog for given item.
WARNING: Your existing local data will be overwritten.

    "{'status': 'OK',
      'result': 'downloading of version 0/0/1/1/0/F20160313043419PM has been started to /Users/veselin/Downloads/restore/'}"


### restores\_running()

Return a list of currently running downloads:

    { u'result': [ { 'aborted': False,
                     'backup_id': '0/0/3/1/F20160427011209PM',
                     'block_number': 0,
                     'bytes_processed': 0,
                     'creator_id': 'http://veselin-p2p.ru/veselin.xml',
                     'done': False,
                     'created': 'Wed Apr 27 15:11:13 2016',
                     'eccmap': 'ecc/4x4',
                     'path_id': '0/0/3/1',
                     'version': 'F20160427011209PM'}],
      u'status': u'OK'}    


### restore\_abort(backup\_id)

Abort currently running restore process.


### suppliers\_list()

List of suppliers - nodes who stores my data on own machines.


### supplier\_replace(index\_or\_idurl)

Execute a fire/hire process of one supplier,
another random node will replace this supplier.
As soon as new supplier will be found and connected,
rebuilding of all uploaded data will be started and
the new node will start getting a reconstructed fragments.


### supplier\_change(index\_or\_idurl, new\_idurl)

Doing same as supplier_replace() but new node is provided directly.


### suppliers\_ping()

Send short requests to all suppliers to get their current statuses.


### customers\_list()

List of customers - nodes who stores own data on your machine.


### customer\_reject(idurl)

Stop supporting given customer, remove all his files from local disc,
close connections with that node.


### customers\_ping()

Send Identity packet to all customers to check their current statuses.
Every node will reply with Ack packet on any valid incoming Identiy packet.  


### space\_donated()

Return detailed statistics about your donated space usage.


### space\_consumed()

Return some info about your current usage of BitDust resources.


### ping(idurl, timeout=10)

The "ping" command performs following actions:
1. Request remote identity source by idurl,
2. Send my Identity to remote contact addresses, taken from identity,
3. Wait first Ack packet from remote peer,
4. Failed by timeout or identity fetching error.

    "{'status': 'OK', 
      'result': '(signed.Packet[Ack(Identity) bob|bob for alice], in_70_19828906(DONE))'}"


### list\_messages()



### send\_message(recipient, message\_body)

Send a message to remote peer.
 
    {'result': 'message to http://p2p-id.ru/alice.xml was sent', 
     'packet': ... , 
     'recipient': http://p2p-id.ru/alice.xml,
     'message': 'Hi Alice!!!',
     'error': '',}


### list\_correspondents()

Return a list of your friends.

    [ {'idurl': 'http://p2p-id.ru/alice.xml', 
       'nickname': 'alice'}, 
      {'idurl': 'http://p2p-id.ru/bob.xml', 
       'nickname': 'bob'},]


### add\_correspondent(idurl, nickname='')


### remove\_correspondent(idurl)


### find\_peer\_by\_nickname(nickname)




