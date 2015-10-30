vsftpd:
  pkg.installed: []
  service.running:
    - enable: True
    - watch:
      - file: /etc/vsftpd.conf
/etc/vsftpd.conf:
  file.managed:
    - source: salt://semservices/vsftpd.conf
    - user: root
    - group: root
    - mode: 644
/srv/ftp/upload:
  file.directory:
  - user: ftp
  - group: ftp
  - mode: 755
  - require:
    - pkg: vsftpd
