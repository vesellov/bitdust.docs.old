# BitDust Change Log


2015-07-05 Veselin Penev [veselin@bitdust.io](mailto:veselin@bitdust.io)

* a lot of changes in the code, many things were turned off temporary
* switched API to JSON interface finally at interface/jsonrpc_server.py
* interface/cmd_line_json.py now uses lib.jsontemplate module to render content
* added Django to the project - now GUI interface is using WEB Browser (I was thinking about that stuff in 2010!)
* added Bootstrap to make a simple and nice looking design
* created jqchat and several other Django apps in the bitdust/web/ folder
* created a new deployment script : bitdust/deploy/windows_devel
* created a new binary installer : bitdust/deploy/windows_innosetup
* oh! by the way! The project was renamed from BitPie.NET to BitDust!


2014-11-23 Veselin Penev [veselin@bitdust.io](mailto:veselin@bitdust.io)

* KEY FEATURE: software core is transformed into a system of interrelated services
* made upgrade on stun client - multiple stun requests at same time to increase performance
* changed user settings engine, now it is splited on single files in sub folder: .bitdust/config/
* many fixes in GUI and command line interface
* hash method was changed from MD5 to SHA1 
* added a small feature - can request a single random packet for given backup from GUI


2014-10-21 Veselin Penev [veselin@bitdust.io](mailto:veselin@bitdust.io)

* fixed messages - p2p chat is working now! 
* did small fixes in: GUI, DHT code, API
* changed UDP PING timeout again, from 1 minute to 30 seconds


2014-10-17 Veselin Penev [veselin@bitdust.io](mailto:veselin@bitdust.io)

* a bug fix in the backups, error when trying to add a network location under Windows
* make developer reports working again, set up a script http://bitdust.io/cgi-bin/feedback.py
* changed UDP PING timeout from 10sec to 1 minute
* small fixes in the command line interface


2014-10-15 Veselin Penev [veselin@bitdust.io](mailto:veselin@bitdust.io)

* fixed error in registration part


2014-10-10 Veselin Penev [veselin@bitdust.io](mailto:veselin@bitdust.io)

* switched on a new improrved UDP transport - can use UDP to transfer packets now
* upgrade messaging service - safe p2p encrypted chat
* added command line support to send/list messages


2014-08-20 Veselin Penev [veselin@bitdust.io](mailto:veselin@bitdust.io)

* new tray icons for Microsoft Windows


<div class=fbcomments markdown="1">
</div>