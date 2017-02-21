# Start a new Identity Server in BitDust network


## Install and configure apache2


First install Apache server if you do not have it yet on your machine:

    sudo apt-get install apache2

Edit file:
    
    /etc/apache2/apache2.conf 

you need to add a line to set your domain name:
    
    ServerName my-own-identity-server.com

Create a new .conf file in /etc/apache2/conf-available/ :

    <VirtualHost *:80>
      ServerName my-own-identity-server.com
      ServerAlias www.my-own-identity-server.com
      ProxyPreserveHost on
      ProxyRequests Off
      RewriteEngine on
      ProxyPass / http://localhost:8084/
      ProxyPassReverse / http://localhost:8084/
      Redirect / http://localhost:8084/
      RewriteRule ^/(.*) http://localhost:8084/$1 [P,L]
    </VirtualHost>

Enable this configuration in apache2, run command:

    sudo a2enconf id_server_apache2
    
Configure proxy_http and rewrite modes in apache2, run commands:

    sudo a2enmod proxy_http 
    sudo a2enmod rewrite

Restart apache2 server:

    sudo service apache2 restart


## Configure BitDust software

Now configure BitDust on your node to set domain name for your identity server, run commands:

    bitdust set services/id-server/host my-own-identity-server.com
    bitdust set services/id-server/enabled true


Restart BitDust software:

    bitdust restart


Be sure ID server is up and running:

    bitdust states | grep id_server
    36: id_server(LISTEN)


Open your browser and go to my-own-identity-server.com to check it end-to-end.

Contact with BitDust team to notify about this new ID server was started and we will add your domain name in the list of "known id servers" at: http://gitlab.bitdust.io/stable/bitdust.latest/blob/master/userid/known_servers.py

