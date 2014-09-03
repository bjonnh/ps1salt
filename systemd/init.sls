/etc/systemd/network/20-dhcp.network:
  file:
    - managed
    - source: salt://systemd/20-dhcp.network
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
systemd-networkd:
  service:
    - enable: True
    - running
