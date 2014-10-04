htop:
  pkg:
    - installed
mosh:
  pkg:
    - installed
nmap:
  pkg:
    - installed
tmux:
  pkg:
    - installed
uptimed:
  pkg:
    - installed
  service:
    - running
    - enable: True
rxvt-unicode-terminfo:
  pkg:
    - installed
{% if grains['os'] == 'Arch' %}
cronie:
  pkg:
    - installed
  service:
    - running
    - enable: True
{% endif %}
