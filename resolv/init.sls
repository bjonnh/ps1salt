systemd-resolved:
  service:
    - running
    - enable: True
/etc/resolv.conf:
#  file.symlink:
#    - target: /run/systemd/resolve/resolv.conf
  file.managed:
    - source: salt://resolv/resolv.conf
