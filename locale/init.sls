en_US.UTF-8:
  locale.system

/etc/locale.gen:
  file.managed:
    - source: salt://locale/locale.gen

locale-gen:
  cmd.wait:
    - watch:
      - file: /etc/locale.gen
    

    

