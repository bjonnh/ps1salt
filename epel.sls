{% if grains.os_family == 'RedHat' %}
epel-release:
  pkg.installed:
  - require_in:
    - pkg: htop
    - pkg: mosh
{% endif %}
