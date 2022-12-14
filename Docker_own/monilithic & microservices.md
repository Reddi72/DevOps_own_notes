A monolithic application is built as a single unified unit while a microservices architecture is a collection of smaller, independently deployable services. Which one is right for you? It depends on a number of factors. 
1. monolithic application: vm----os(linux)---application 
or datalayer--app layer---proxy or app (front end)gui.
2. microservices- physical/vm--host os--container engine--containers(tomcat,maven,jenkins).

## Microservices Architecture #
#amazon-linux-extras install docker -y
#service start docker
## installing docker compose ##
 #DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
 #mkdir -p $DOCKER_CONFIG/cli-plugins
 #curl -SL https://github.com/docker/compose/releases/download/v2.11.0/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compos
 #chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
 #docker compose version
### composing 3 tier architecture app ##
## login app docker files 1.app 2.mysql 3.nginix

1. #mkidr loginapp --> #cd loginapp
2. #mkdir app    -->#cd app
3. #vi Dockerfile
 FROM amazonlinux
 MAINTAINER PRReddy
 WORKDIR /opt
 ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.82/bin/apache-tomcat-8.5.82-windows-x64.zip /opt/
 RUN yum install unzip -y
 RUN yum install vim -y
 RUN yum install mysql -y
 RUN yum install telnet -y
 RUN unzip /opt/apache-tomcat-8.5.82-windows-x64.zip
 RUN chmod +x /opt/apache-tomcat-8.5.82/bin/*
 RUN amazon-linux-extras install java-openjdk11 -y
 COPY ./dptweb-1.0.war /opt/apache-tomcat-8.5.82/webapps/
 CMD ["/opt/apache-tomcat-8.5.82/bin/catalina.sh", "run"]

4. copy ur war file to inthis directory [/app]
===========================================
## mysql dockerfile ##
#cd loginapp
#mkdir mysql   --> #cd mysql
#vi Dockerfile
 FROM mysql:8.0
 ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
 ENV MYSQL_DATABASE=$MYSQL_DATABASE
 ENV MYSQL_USER=$MYSQL_USER 
 ENV MYSQL_PASSWORD=$MYSQL_PASSWORD
===========================================
## nginx dockerfile ##
#cd loginapp
#mkdir nginx
#vi Dockerfile
FROM amazonlinux
RUN amazon-linux-extras install nginx1 -y
RUN yum install telnet -y
COPY nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]

## copy the conf file from another nginx and edit it add ur proxt server details [location / {
            proxy_pass http://app:8080/dptweb-1.0/;
        }] ##

#vi nginx.conf
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
            proxy_pass http://app:8080/dptweb-1.0/;
        }

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2;
#        listen       [::]:443 ssl http2;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers PROFILE=SYSTEM;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}
===========================================
#cd loginapp
#vi docker-compose.yml
version: '3.8'
networks:
  dpt4webnw:
    driver: bridge
services:
    mysql:
        build:
          context: ./mysql
          dockerfile: Dockerfile
        container_name: mysql
        restart: always
        ports:
          - "3306:3306"
        environment:
          - MYSQL_ROOT_PASSWORD=admin123
          - MYSQL_DATABASE=UserDB
          - MYSQL_USER=admin
          - MYSQL_PASSWORD=admin123
        volumes:
          - /data:/var/lib/mysql
        networks:
          - dpt4webnw
    nginx:
        build:
           context: ./nginx
           dockerfile: Dockerfile
        container_name: nginx
        depends_on:
          - app
        ports:
          - 80:80
        networks:
          - dpt4webnw
        links:
          - app
    app:
        build:
          context: ./app
          dockerfile: Dockerfile
        container_name: app
        depends_on:
          - mysql
        restart: always
        ports:
          - "8080:8080"
        networks:
          - dpt4webnw
        links:
          - mysql
======================================================
### Now build ur yml file ##
#docker compose up -d
     -ur build process start and containers also start
#docker images
#docker ps

** now access ur app through google , useing-- ip of ur server ***
## if u want delete all only containers not images ##
#docker compose down
