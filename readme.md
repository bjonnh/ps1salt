SaltStack for Pumping Station: One
==================================


Supported Platforms
-------------------

* Arch Linux

Install Configurations
----------------------

Installs winbind and preps for domain joining
Allows member logons, once domain is joined.

Testing
-------

Vagrant will start up an Arch linux box, bootstrap salt, and install the default salt settings. This will take about 4 minutes.

    vagrant up

Run state.highstate from the vagrant instance, look for errors, make change, etc

    vagrant ssh
    sudo salt-call state.highstate
