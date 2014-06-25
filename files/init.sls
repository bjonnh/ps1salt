/saltstack_managed:
  file:
    - managed
    - source: salt://files/saltstack_managed
    - user: root
    - group: root
    - mode: 0755
    - template: jinja
{% if grains['os'] == 'Arch' %}
/etc/ld.so.conf.d/tevent.conf:
  file:
    - managed
    - source: salt://files/tevent.conf
    - user: root
    - group: root
    - mode: 0775
    - template: jinja
ldconfig:
  cmd.wait:
  - name: ldconfig
  - watch:
    - file: /etc/ld.so.conf.d/tevent.conf
{% endif %}
