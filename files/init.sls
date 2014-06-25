/saltstack_managed:
  file:
    - managed
    - source: salt://files/saltstack_managed
    - user: root
    - group: root
    - mode: 0755
    - template: jinja
