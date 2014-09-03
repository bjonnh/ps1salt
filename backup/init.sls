duplicity:
  pkg:
    - installed
python2-boto:
  pkg:
    - installed
/etc/cron.daily/backup:
  file:
    - managed
    - source: salt://backup/backup
    - user: root
    - group: root
    - mode: 0750
    - template: jinja
