{% if grains.os == 'CentOS' %}
epel-release:
  pkg.installed:
  - require_in:
    - pkg: htop
    - pkg: mosh
{% endif %}
