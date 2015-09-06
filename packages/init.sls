{% from "packages/map.jinja" import packages with context %}
include:
  - epel
htop:
  pkg.installed
mosh:
  pkg.installed
nmap:
  pkg.installed
salt-minion:
  pkg.installed:
    - name: {{ packages.salt_pkg }}
tmux:
  pkg.installed
vim:
  pkg.installed:
    - name: {{ packages.vim_pkg }}
