krb5:
  pkg:
    - installed
{% if 'roles' in grains and 'dc' in grains['roles']%}
samba:
  pkg:
    - installed
  service:
    - running
    - enable: true
smbd:
  service:
    - dead
    - disable: true
nmbd:
  service:
    - dead
    - disable: true
winbindd:
  service:
    - dead
    - disable: true
{% else %}
samba:
  pkg:
    - installed
  service:
    - dead
    - disable: true
smbd:
  service:
    - running
    - enable: True
nmbd:
  service:
    - running
    - neable: true
winbindd:
  service:
    - running
    - enable: True
{% endif %}


include:
  - .{{ grains['os'] }}
/etc/samba/smb.conf:
  file:
    - managed
{% if 'roles' in grains and 'dc' in grains['roles'] %}
    - source: salt://winbind/dc.smb.conf
{% else %}
    - source: salt://winbind/smb.conf
{% endif %}
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
/etc/krb5.conf:
  file:
    - managed
    - source: salt://winbind/krb5.conf
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
/etc/hosts:
  file:
    - managed
    - source: salt://winbind/hosts
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
/etc/sudoers.d/domain_admins:
  file:
    - managed
    - source: salt://winbind/sudoers_domain_admins
    - user: root
    - group: root
    - mode: 0440
    - template: jinja
    - makedirs: True
