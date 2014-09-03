base:
  '*':
    - files
    - vim
    - packages
    - avahi
    - ssh 
    - root
    - winbind
    - backup
  'os:Arch':
    - match: grain
    - systemd
    - resolv
