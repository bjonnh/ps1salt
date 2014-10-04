/etc/locale.conf:
  file:
    - managed
    - source: salt://locale/locale.conf
    - user: root
    - group: root
    - mode: 0755
