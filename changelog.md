# BitDust Change Log



2017-10-31 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* added known id server at veselin-p2p.ru
* changes in bppipe.py : store files and folders in tar archive with modified names
* error fallback flow added in restore() automat
* MAJOR CHANGE !!! ALL Enrypted customers data stored on suppliers is PUBLICLY SHARED now!
* added feature : encrypt private message with recipient master key or another known key
* bug fix in id_registrator()
* fixes in chat, more transport logs
* removed id serverd on bitdust.io:8084
* adjusted default settings : run proxy transport by default
* fixes in service_nodes_lookup(), service_proxy_transport()
% jqchat and UI fixes
* updated interface.ftp_server according to new api interface methods
* added api.file_*() commands
* removed api.backup_*() commands
* removed api.restore_*() commands
* added userid/global_id.py
* BOOM! backupID/pathID format change: 0/0/1/0/F20131120053803PM -> alice@idhost.org:0/0/1/0/F20131120053803PM
* added service_supplier_relations()
* cmd line fixes for "files" command



2017-08-23 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* added colors to terminal logs
* added "service_keys_registry" request in the API key_share() method flow
* added private keys managment commands to API methods
* storing catalog index in json format now
* store key_id in the catalog
* implemented multiple encryption/decryption keys in backup index
* added access/key_ring.py
* added service_keys_registry()
* added local FTP server and FTP interface bridge to access distributed data via FTP client
* added Query class to contract_chain_node
* software should be autmatically restarted after receiving an update
* added logging to git_proc, git_proc will start in 30 sec after startup
* changed "git reset --hard" to "git rebase origin/master" in git_proc.py
* added coins_index.py, working on coins storage, codernity db indexes now are located in the source code
* added added contract_chain_node.py
* fix in accountant_node() to prevent infinite loop
* added contract_chain_consumer() automat
* added service_contract_chain()
* added service_customer_contracts()
* added service_supplier_contracts()
* added state machine p2p_service_seeker()
* added simple global events system with listeners
* added Coin() and RetreiveCoin() commands
* change in broadcaster_node() automat, improved lookup and dht code, default N of broadcasters set to 3
* fix in storage/backup_matrix.py
* update help/usage, added "install" command to cmd_line interface
* setup a virtual environment folder in ~/.bitdust/venv/ to isolate BitDust software from system Python
* added one seed node
* started playing with Ethereum, continue working on contracts chains


2017-03-04 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* migration of genezis nodes to another vps machines
* added new configs under api/json-rpc-server/
* bug fix in restore backup flow
* removed unused id server conf scripts/docs, a new doc page added instead
* hot fix in logging
* added customer_assistant() automat to service_customer_support()


2016-12-14 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* improve gui, added progress bars for in/out streams
* huge changes in UPD streaming: improve performance, stability - it is working now actualy!
* bug fixes in TCP transport as well
* pep8 auto fixes for all .py files
* added index_synchronizer() machine to replace backup_db_keeper()
* remove old unused options from settings
* adjust packet_out automat
* adjust events in contact_status automat
* added another packet type (Command) for proxy transport : Relay()
* keep working on proxy transport


2016-10-23 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* bug fixes in settings and fire_hire machine
* updated README
* start working on crypto coins


2016-09-18 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* publish Python sources under GNU AGPL v3!


2016-09-04 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* added nodes_lookup() service
* added broadcasting() service
* added broadcast_listener() state machine
* added broadcaster_node() automat
* added broadcasters_finder() state machine
* fixes in git update procedures
* updated employer() service dependencies
* slow down bptester process a little bit
* more clean shutdown of all state machines
* `bitdust api` will print all api methods in cmd line
* fix loging in network_connector()
* fix service_udp_transport() - now it should finish stun process firstly and then go further
* modified "integrate" command, it should not create a file but print to stdout


2016-07-16 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* added text chat via command line
* bug fix in UDP transport
* added scripts to build commits history
* lots new API methods
* made port to Mac OS
* updates in ubuntu package


2016-05-04 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* built a new Web Site for BitDust project: https://bitdust.io
* new project Logo!
* lots methods added to API
* updated/improved command line interface
* made a stable port for MacOS
* fixed several major bugs in p2p networking code
* switched software updating to use "git" - distribute Python sources to end-users
* created a new Windows installer archive
* continue working on new GUI based on Django


2015-07-05 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* a lot of changes in the code, many things were turned off temporary
* switched API to JSON interface finally at interface/jsonrpc_server.py
* interface/cmd_line_json.py now uses lib.jsontemplate module to render content
* added Django to the project - now GUI interface is using WEB Browser (I was thinking about that stuff in 2010!)
* added Bootstrap to make a simple and nice looking design
* created jqchat and several other Django apps in the bitdust/web/ folder
* created a new deployment script : bitdust/deploy/windows_devel
* created a new binary installer : bitdust/deploy/windows_innosetup
* oh! by the way! The project was renamed from BitPie.NET to BitDust!


2014-11-23 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* KEY FEATURE: software core is transformed into a system of interrelated services
* made upgrade on stun client - multiple stun requests at same time to increase performance
* changed user settings engine, now it is splited on single files in sub folder: .bitdust/config/
* many fixes in GUI and command line interface
* hash method was changed from MD5 to SHA1 
* added a small feature - can request a single random packet for given backup from GUI


2014-10-21 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* fixed messages - p2p chat is working now! 
* did small fixes in: GUI, DHT code, API
* changed UDP PING timeout again, from 1 minute to 30 seconds


2014-10-17 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* a bug fix in the backups, error when trying to add a network location under Windows
* make developer reports working again, set up a script https://bitdust.io/cgi-bin/feedback.py
* changed UDP PING timeout from 10sec to 1 minute
* small fixes in the command line interface


2014-10-15 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* fixed error in registration part


2014-10-10 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* switched on a new improrved UDP transport - can use UDP to transfer packets now
* upgrade messaging service - safe p2p encrypted chat
* added command line support to send/list messages


2014-08-20 Veselin Penev [penev.veselin@gmail.com](mailto:penev.veselin@gmail.com)

* new tray icons for Microsoft Windows


<div class=fbcomments markdown="1">
</div>
