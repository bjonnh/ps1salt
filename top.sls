base:
  '*':
    - avahi
    - files
    - root
    - packages
    - ssh
  'os:Arch':
    - match: grain
    - backup
    - resolv
    - systemd
    - terminfo
    - uptimed
    - winbind
  'cloud[1-3]':
    - gluster
