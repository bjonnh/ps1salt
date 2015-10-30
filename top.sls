base:
  '*':
    - avahi
    - files
    - root
    - packages
    - ssh
  'os:Arch':
    - match: grain
    - resolv
    - systemd
    - terminfo
    - uptimed
    - locale
    - winbind
  'os:Debian':
    - match: grain
    - winbind
  'cloud[1-3]':
    - gluster
  'roles:semservices':
    - match: grain
    - semservices
