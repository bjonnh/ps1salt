avahi:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - name: avahi-daemon
#TODO set disallow-other-stacks=yes in /etc/avahi/avahi-daemon
