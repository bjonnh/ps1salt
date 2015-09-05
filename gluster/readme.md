
Kickstart
=========

PXE boot, select "CentOS 7 x86_64 Cloud Server Kickstart"
This will wipe and partition the drives

state.highstate
===============

    sudo salt-ssh 'cloud*' state.highstate

The initial call to state.highstate is going to take some time.

Master host only
================

Using salt to try and create the gluster volumes doesn't always work correctly. Run this step manually:


    gluster volume create engine replica 3 10.100.0.12:/srv/gluster/engine/brick 10.100.0.13:/srv/gluster/engine/brick 10.100.0.14:/srv/gluster/engine/brick
    gluster volume create data replica 3 10.100.0.12:/srv/gluster/data/brick 10.100.0.13:/srv/gluster/data/brick 10.100.0.14:/srv/gluster/data/brick
    gluster volume create meta replica 3 10.100.0.12:/srv/gluster/meta/brick 10.100.0.13:/srv/gluster/meta/brick 10.100.0.14:/srv/gluster/meta/brick
    gluster volume set engine group virt
    gluster volume set engine storage.owner-uid 36
    gluster volume set engine storage.owner-gid 36
    gluster volume set data group virt
    gluster volume set data storage.owner-uid 36
    gluster volume set data storage.owner-gid 36

    gluster volume start engine
    gluster volume start data
    gluster volume start meta

state.highstate again
=====================

ctdb requires that the gluster volumes are setup and mounted. Run state.highstate again.

sudo salt-ssh 'cloud*' system.reboot
sudo salt-ssh 'cloud*' state.highstate

hosted-engine on Host 1
=======================

    ssh root@10.100.0.12
    passwd

You need to setup some password for root until all 3 boxes have been configured. After that we can wipe the password agian.

    tmux
    hosted-engine --deploy

use the following answers:

Please specify the full shared storage connection path to use (example: host:/path): nfsserver:/engine
Please specify the device to boot the VM from (cdrom, disk, pxe) [cdrom]: pxe
You may specify a unicast MAC address for the VM or accept a randomly generated default [00:16:3e:4f:37:40]: 00:16:3e:5e:3b:e8
Engine FQDN: purrvirt.ps1

purrvirt.ps1
------------

use a vnc client to connect to 10.100.0.12:5900 and use the password provided on the prompt.
select CentOS 7 x86_64 from the pxe boot menu.  You might need to press 2 on the install script to reboot the machine to get the pxe boot screen to come back.
I didn't write a kickstart file for this one, so you'll just have to do the installer manually.

Once installed, run the following commands on the vm:

    yum localinstall -y http://resources.ovirt.org/pub/yum-repo/ovirt-release35.rpm
    yum install -y ovirt-engine

reboot and reconnect.  I can't get the engine to work on the first try for some reason.

    engine-setup

Setting up Hosts 2 and 3
========================

set a root password for the first host.  The setup scripts need to be able to log in.  The next state.highstate we re-erase the root password

log in to host 2
create a tmux session
hosted-engine --deploy

pay attention to the "Machine ID".  It must be 2 for host 2, and 3 for host 3.

Please specify the full shared storage connection path to use (example: host:/path): nfsserver:/engine
Please provide the FQDN or IP of the first host: 10.100.0.12
Enter 'root' user password for host 10.100.0.12:


log in to host 3, and repeat the above steps.  Again, make sure Machine ID is 3.

recovering from a botched hosted-engine deploy
----------------------------------------------

Destroy the VM

    vdsClient -s 0 list

find the guid of the vm

    vdsClient -s 0 destroy <machine-id>

Wipe the engine storage

    mkdir /mnt/engine
    mount -t glusterfs nfsserver:/engine
    rm -rf /mnt/engine/
    umount /mnt/engine
    rm -rf /mnt/engine

go back to the hosted-engine --deploy step

Logging in to the Hosted Engine
===============================

go to https://10.100.0.18 and log in

Click Storage >> New Domain

Name: Data
Domain Function / Storage Type: Data / GlusterFS
Path: nfsserver:/data

click ok

getting the iso domain
======================

shell into 10.100.0.18
edit /etc/exports.d/ovirt-engine-iso-domain.exports to look like this:
/var/lib/exports/iso	10.100.0.12(rw) 10.100.0.13(rw) 10.100.0.14(rw) purrvirt.ps1(rw)

then run

    systemctl restart nfs-server
