redis:
  pkg:
    - installed
  file.managed:
    - name: /etc/redis.conf
    - source: salt://redis/redis.conf.jinja
    - template: jinja
    - defaults:
        bind: 127.0.0.1
        port: 6379
    - require:
      - pkg: redis
  service.running:
    - enable: True
    - watch:
      - file: redis

/etc/sysctl.d/redis.conf:
  file.managed:
    - source: salt://redis/sysctl.conf

redis-sysctl:
  cmd.wait:
    - name: sysctl -q -p /etc/sysctl.d/redis.conf
    - watch:
      - file: /etc/sysctl.d/redis.conf
