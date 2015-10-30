{% from "winbind/map.jinja" import winbind with context %}
krb5:
  pkg.installed:
    - name:  {{ winbind.kerberos_pkg }}
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
{% if winbind.winbind_pkg %}
  pkg.installed:
    - name: {{ winbind.winbind_pkg }}
    - require_in:
      - service: winbindd
{% endif %}
  service:
    - running
    - enable: True
    - watch:
      - cmd: join domain
{% if winbind.winbind_pkg %}
    - name: {{ winbind.winbind_pkg }}
{% endif %}
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
    - mode: 0750
    - template: jinja
    - makedirs: True
join domain:
  cmd.run:
    - name: net ads join -U{{ pillar['join_account'] }}%{{ pillar['join_account_password'] }}
    - creates: /run/samba/smb_krb5/krb5.conf.PS1

{% for extra_pkg in winbind.extra_pkgs %}
{{extra_pkg}}:
  pkg.installed
{% endfor %}

#upgrade problems
/var/cache/samba:
  file.directory:
    - mode: 0755
/var/cache/samba/msg:
  file.directory:
    - mode: 0755

