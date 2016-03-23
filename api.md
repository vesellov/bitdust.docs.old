# BitDust API

### stop()
    
    Stop the main process immediately.
    Return:
        { "result": "stopped" }
    

### restart(show=False)
    
    Restart the main process, if flag show=True the GUI will be opened after restart.
    Return:
        [<twisted.python.failure.Failure twisted.internet.error.ConnectionDone: Connection was closed cleanly.>]
    

### show()
    
    Opens a default web browser to show the BitDust GUI.
    Return:
        { "result": '"show" event sent to the main process' }
    

### config\_get(key, default=None)
    
    Return current value for specific option.
    Return: 
        {'key': 'logs/debug-level', 
         'type': 'positive integer', 
         'value': '8'}    
    

### config\_set(key, value, typ=None)
    
    Set a value for given option.
    Return:
        {'key': 'logs/debug-level',
         'old_value': '8',
         'type': 'positive integer',
         'value': '10'}
    

### config\_list(sort=False)
    
    Return a list of all options and its values.
        [ {'key': 'services/backups/enabled', 'type': 'boolean', 'value': 'true'},
          {'key': 'services/backups/keep-local-copies-enabled', 'type': 'boolean', 'value': 'false'},
          {'key': 'services/backups/max-block-size', 'type': 'disk space', 'value': '128 MB'},
          ...
    

### filemanager(json\_request)
    
    A method to execute calls from GUI front-end and interact with web browser.
    This is a specific "gate" created for Ajax calls only.
    Example:
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
    

### backups\_update()
    
    A method to restart backup_monitor() Automat and fire "synchronize" process with remote nodes.
    Result:
        { 'result': 'the main loop has been restarted', }
    

### backups\_list()
    
    Return a whole tree of files and folders in the catalog.
    Result:
        [{'id': '0', 'path': '/Users', 'size': 43349475,'type': 'parent', 'versions': []},
         {'id': '0/0', 'path': '/Users/veselin', 'size': 43349475, 'type': 'parent', 'versions': []},
         {'id': '0/0/1', 'path': '/Users/veselin/Documents', 'size': 38992196, 'type': 'parent', 'versions': []},
         {'id': '0/0/1/0', 'path': '/Users/veselin/Documents/python', 'size': 5754439, 'type': 'parent', 'versions': []},        
         {'id': '0/0/1/0/0', 'path': '/Users/veselin/Documents/python/python27.chm', 'size': 5754439, 'type': 'file',
              'versions': [{'blocks': 1, 'size': '11 MB', 'version': 'F20160313043757PM'}]},
         ...   
    

### backups\_id\_list()
    
    Return only list of items uploaded on remote machines.
    Result:
        [{'backupid': '0/0/1/0/0/F20160313043757PM',
          'path': '/Users/veselin/Documents/python/python27.chm',
          'size': '11 MB'},
         {'backupid': '0/0/0/0/0/0/F20160315052257PM',
          'path': '/Users/veselin/Music/Bob Marley/01-Soul Rebels (1970)/01-Put It On.mp3',
          'size': '8.27 MB'}
         ...        
    

### backup\_start\_id(pathID)
    
    Start uploading a given item already existed in the catalog by its path ID.
    Result:
        {'result': 'uploading 0/0/1/0/0 started, local path is: /Users/veselin/Documents/python/python27.chm' }
    

### backup\_start\_path(path)
    
    Start uploading file or folder to remote nodes, assign a new path ID and add it to the catalog.
    Result:
        {'result': 'uploading 0/0/1/0/0 started, local path is: /Users/veselin/Documents/python/python27.chm' }
    

### backup\_dir\_add(dirpath)
    
    Add given folder to the catalog but do not start uploading process.
    Result:
        {'result': 'new folder was added: 0/0/2, local path is /Users/veselin/Movies/'} 
    

### backup\_file\_add(filepath)
      
    Add a single file to the catalog, skip uploading.
    Result:
        {'result': 'new file was added: 0/0/3/0, local path is /Users/veselin/Downloads/pytest-2.9.0.tar.gz'}
     

### backup\_tree\_add(dirpath)


### backup\_delete\_local(backupID)


### backup\_delete\_id(pathID\_or\_backupID)


### backup\_delete\_path(localPath)


### restore\_single(pathID\_or\_backupID\_or\_localPath, destinationPath=None)


### list\_messages()


### send\_message(recipient, message\_body)


### list\_correspondents()


### add\_correspondent(idurl, nickname='')


### remove\_correspondent(idurl)


### find\_peer\_by\_nickname(nickname)


### ping(idurl)




