{% from "avahi/map.jinja" import avahi with context %}
avahi:
  pkg:
    - installed
    - name: {{ avahi.avahi_pkg }}
  service:
    - running
    - enable: True
    - name: avahi-daemon
#TODO set disallow-other-stacks=yes in /etc/avahi/avahi-daemon
