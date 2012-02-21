nginx:
  pkg:
    - installed
  file:
    - managed
    - name: /etc/nginx/conf/nginx.conf
    - source: salt://nginx/nginx.conf.jinja
    - template: jinja
    - defaults:
        worker_user: http
        worker_processes: 1
    - require:
      - pkg: nginx
  service:
    - running
    - enable: True
    - watch:
      - file: nginx

nginx-cruft:
  file:
    - absent
    - names:
      - /etc/nginx/html
      - /etc/nginx/logs

/etc/nginx/conf.d:
  file:
    - directory
    - require:
      - pkg: nginx

/srv/http:
  file:
    - directory
    - user: root
    - group: http
    - mode: 750
