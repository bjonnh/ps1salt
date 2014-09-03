ssh:
  pkg:
    - installed
{% if grains['os'] == 'Ubuntu' %}
    - name: openssh-server
{% elif grains['os'] == 'Arch' %}
    - name: openssh
{% endif %}
  service:
    - running
    - enable: True
{% if grains['os'] == 'Ubuntu' %}
    - name: ssh
{% elif grains['os'] == 'Arch' %}
    - name: sshd
{% endif %}
hef:
  ssh_auth:
    - present  
    - user: root
    - source: salt://ssh/hef.id_rsa.pub
gamblit:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/gamblit.id_rsa.pub
kuroishi:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/kuroish.id_rsa.pub
