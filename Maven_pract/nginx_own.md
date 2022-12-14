## installing the nginx
 nginx is a reverse proxy server for tomcat app server.
 # amazon-linux-extras install nginx1
 # cd /etc/nginx
 # vi nginx.conf
     here add under include /etc/nginx/default.d/*.conf; under this-- add ur tomcat server ip

      location / {
        proxy_pass http://184.73.69.251:8080/dptweb-1.0/;
        }
        "" here tomcat ip or web browser name"
# service nginx start
 goto web ip of nginx
 here open ur tomcat server
