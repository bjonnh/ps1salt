{% from "ssh/map.jinja" import ssh with context %}
ssh:
  pkg:
    - installed
    - name: {{ ssh.ssh_pkg }}
  service:
    - running
    - enable: True
    - name: sshd
dbever:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/dbever.id_rsa.pub
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/dbever_oberth.id_rsa.pub
gamblit:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/gamblit.id_rsa.pub
hef:
  ssh_auth:
    - present  
    - user: root
    - source: salt://ssh/hef.id_rsa.pub
imcleod:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/imcleod.id_dsa.pub
justin:
  ssh_auth:
    - present  
    - user: root
    - source: salt://ssh/justin.id_rsa.pub
kuroishi:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/kuroishi.id_rsa.pub
patrickschless:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/patrickschless.id_rsa.pub
sheila:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/sheila.id_rsa.pub
toba:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/toba.id_rsa.pub
tachoknight:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/tachoknight.id_rsa.pub

