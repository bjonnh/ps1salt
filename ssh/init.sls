ssh:
  pkg:
    - installed
    - name: openssh
  service:
    - running
    - enable: True
    - name: sshd
dbever:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/dbever.id_rsa.pub
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
justin:
  ssh_auth:
    - present  
    - user: root
    - source: salt://ssh/justin.id_rsa.pub
kuroishi:
  ssh_auth:
    - present
    - user: root
    - source: salt://ssh/kuroish.id_rsa.pub
