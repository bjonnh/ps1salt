duplicity:
  pkg:
    - installed
python2-boto:
  pkg:
    - installed
/usr/local/bin/backup:
  file:
    - managed
    - source: salt://backup/backup
    - user: root
    - group: root
    - mode: 0750
    - template: jinja
/etc/systemd/system/backup.service:
  file:
    - managed
    - source: salt://backup/backup.service
    - user: root
    - group: root
    - mode: 0750
    - template: jinja
/etc/systemd/system/backup.timer:
  file:
    - managed
    - source: salt://backup/backup.timer
    - user: root
    - group: root
    - mode: 0750
    - template: jinja
backup.timer:
  service:
    - running
    - enable: true
