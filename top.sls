base:
  '*':
    - files
    - vim
    - packages
    - avahi
    - ssh 
    - root
    - winbind
  'os:Arch':
    - match: grain
    - systemd

