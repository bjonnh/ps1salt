/etc/nsswitch.conf:
  file:
    - managed
    - source: salt://winbind/Debian/nsswitch.conf
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
/usr/share/pam-configs/my_mkhomedir:
  file:
    - managed
    - source: salt://winbind/Debian/my_mkhomedir
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
  cmd.wait:
    - watch:
      - file: /usr/share/pam-configs/my_mkhomedir
    - name: pam-auth-update
