{# https://github.com/gtmanfred/salt-states/blob/master/gluster/init.sls #}
permissive:
  selinux.mode


ovirt-release:
  pkg.installed:
    - sources:
      - ovirt-release35: http://resources.ovirt.org/pub/yum-repo/ovirt-release35.rpm

glusterd:
  pkg.installed:
    - name: glusterfs-server
  service.running:
    - enable: True
    - start: True
vdsm-gluster:
  pkg.installed
system-storage-manager:
  pkg.installed
# ctdb needs netstat, which is in net-tools in EL7
net-tools:
  pkg.installed
nfs-utils:
  pkg.installed
ovirt-hosted-engine-setup:
  pkg.installed
firewalld:
  service.dead:
    - enable: False
iptables:
  service.dead:
    - enable: False

/etc/nfsmount.conf:
  file.managed:
    - source: salt://gluster/nfsmount.conf

/mnt/lock:
  mount.mounted:
    - device: localhost:/meta
    - fstype: glusterfs
    - persist: True
    - mkmnt: True

ctdb:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - mount: /mnt/lock
    - watch:
      - file: /etc/sysconfig/ctdb
      - file: /etc/ctdb/nodes
      - file: /etc/ctdb/public_addresses

/etc/sysconfig/ctdb:
  file.managed:
    - source: salt://gluster/ctdb

/etc/ctdb/nodes:
  file.managed:
    - source: salt://gluster/nodes

/etc/ctdb/public_addresses:
  file.managed:
    - source: salt://gluster/public_addresses

nfsserver:
  host.present:
    - ip:
      - 10.100.0.15

#sudo salt-ssh 'cloud1' gluster.peer cloud2 cloud3
peer-cluster:
  glusterfs.peered:
    - names:
      - 10.100.0.12
      - 10.100.0.13
      - 10.100.0.14

/srv/gluster/engine/brick:
  file.directory:
    - makedirs: true

/srv/gluster/data/brick:
  file.directory:
    - makedirs: true

/srv/gluster/meta/brick:
  file.directory:
    - makedirs: true

/etc/modprobe.d/kvm-nested.conf:
  file.managed:
    - source: salt://gluster/kvm-nested.conf

#engine:
#  glusterfs.created:
#    - bricks:
#      - 10.100.0.12:/srv/gluster/engine/brick
#      - 10.100.0.13:/srv/gluster/engine/brick
#      - 10.100.0.14:/srv/gluster/engine/brick
#    - replica: 3
#    - start: True

#data:
#  glusterfs.created:
#    - bricks:
#      - 10.100.0.12:/srv/gluster/data/brick
#      - 10.100.0.13:/srv/gluster/data/brick
#      - 10.100.0.14:/srv/gluster/data/brick
#    - replica: 3
#    - start: True

#meta:
#  glusterfs.created:
#    - bricks:
#      - 10.100.0.12:/srv/gluster/meta/brick
#      - 10.100.0.13:/srv/gluster/meta/brick
#      - 10.100.0.14:/srv/gluster/meta/brick
#    - replica: 3
#    - start: True
