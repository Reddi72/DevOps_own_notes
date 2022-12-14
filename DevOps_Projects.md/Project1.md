### DevOps Project 1 #####
In this project we do WEB APPLICATION STACK
Project name: VPROFILE PROJECT SETUP(Locally)

About the project: In this project we setting up multi tier web application stack
setup will be locally it means in ur laptop 
there 2 reasons to setup locally 
1. this go ing to setup base line for ur upcoming projects 
2. u can setup ur own laptop 
==================================================
## Scenario ##
let's working in a project.. we deals with Varieties of Services that deals with.
like database services mysql,oracl
webservices like apache ,ngnix
appliction servcies apache tomcat,jbox.
u have also Run book or Setup document.
=====================================================
## Tools ##
1. Hypervisor -->Oracle vm virtual box
2. Automation --> vagrant
3. Cli---> Git bash
4. IDE--> sublime text like notepad,visula studio
========================================
## VProfile Archetecture Design of Services##
1. Nginx
2. Tomcat
3. Rabbitmq
4. Memcashed
5. Mysql
## Architecture of Automated setup ##
1. Vagrant
2. Virtual box
3. Gitbash
================================================
End users--->Load balncer--->Nginx--->app server tomcat--->Rabbit Mq--->my sql server.

we will be useing vagrant to automate setup virtual machine . and vagrant going to communicate with oracle vm box which is the hypervisor and create automatically vms on that then we will be useing some bash scrptis or commands  to setup our services like tomcat database,nginx...etc
=======================================
## Flow of Excution ##
1. Setup all prerequsites tools 
2. clone the source code
3. cd into vagrant directory
4. bringup vms
5. validate all our vms
6. Setup the all services
   1. mqsql
   2. memcashed
   3. Rabbit mq
   4. Tomcat
   5. Nginx
   6. App build & deploy
7. verify from browser
=================================================
1. Go to google -->github/devopshydclub/vprofile-project-->go to local-setup branch---
2. open your git bash-->clone the source code reop in ur local machine
#cd /d --> mkdir project
#git clone https://github.com/devopshydclub/vprofile-project.git
#vprofile-project/
#git checkout local-setup
#cd vagrant/
#cd Manual_provisioning
#vi Vagrantfile
#vagrantup
all virtual machines are running up
open ur "Oracle virtual box" here u can see all virtual machies are running up
#vagrant ssh web01  --> valideate the infrastructure
#cat /etc/hosts  --> here shows all ur vm ips & name like app01,db01,rmq01,web01
#ping mco1
#ping rmq01
===============================================================================
Now Setup all vms as per requred series
1. ms sql (database SVC)
2. Memcashe (DB Cashing SVC)
3. Rabbit mq (Broker/Que svc)
4. Tomaact (application svc)
5. ngins (web svc)
## My sql setup ##
#vagrant ssh db01 --> login to db vm
#cat /etc/hosts ---> verify hostentry
#DATABASE_PASS='admin123' --> setup db pasword variable and it is tempry variable
#vi /etc/profile -->for perment variable here keep ur db pasword
DATABASE_PASS='admin123'
#source /etc/profile
#echo DATABASE_PASS --> here ur db password admin123 
#yum update -y --> update os with lateast patches
#yum install epel-release -y ---> set repository
#yum install git mariadb-server -y --> install maria db package
#systemctl enable mariadb
#systemctl status mariadb
#mysql_secure_installation
 here ask password click enter
 setnew password: here give ur new password admin123
 reenter password: admin123
remove ananymos users: yes
disallow root login remote: no
test database : yes
#mysql -u root -p
enter password: admin123
exit
#git clone https://github.com/devopshydclub/vprofile-project.git
#cd vprofile-project
#cd src
#cd main
#cd resources --> here db_backup.sql
#mysql -u root -p"$DATABASE_PASS" -e "create database accounts"
#mysql -u root -p"$DATABASE_PASS" -e grant all privileges on accounts.* TO 'admin'@'app01' identified by 'admin123'
--> here root previliges
#cd ../../..
#mysql -u root -p"$DATABASE_PASS" accounts < src/main/resources/db_backup.sql
#mysql -u root -p"$DATABASE_PASS" -e "FLUSH PREVILIGIES"
#mysql -u root -p"$DATABASE_PASS" --> login into database
#show databases
#use accounts --> switch to database
#show tables
#exit
==================================================================================
## if u useing firewall in centos then setup with mqsql port 3306 **
#systemctl restart mariadb
#systemctl start firewalld
#systemctl enable firewalld
#firewall-cmd--get-active-zones
#firewall-cmd--zone=public --add-port=3306/tcp --permanent
#firewall-cmd--reload
#systemctl restart mariadb
==============================================================================
## Memcashe setup ##
#vangrant ssh mc01
Install,start,enable memcashe on port 11211
#yum install epel-realese-y
#yum install memcashed -y
#systemctl start meamcashed
#systemctl status meamcashed
#memcashed -p 11211-U 11111 -u memcashed -d
## Starting the firewall  and allowing the port 11211 to access port no. 3306 ##
#systemctl restart mamcashed
#systemctl start memcashed
#systemctl enable firewalld
#firewall-cmd--get-active-zones
#firewall-cmd --add-port=11211/tcp --permanent
#firewall-cmd--reload
#memcashed -p 11211 -U 11111 -u memcashed -d
#systemctl restart mariadb
===================================================================================
### Setup Rabbit mq ## 
#vagrant ssh rmqq01
#yum update -y
#yum install epel-realese-y
#yum install erlang -y
#yum install wget
#wget https://www.rabbitmq.com/realeses/rabbitmq--server/v3.6.10/rabbitmq--server-3.6.10-e17.norach.rpm
#rpm --import https://www.rabbitmq.com/realeses-signing-key.asc
#rpm -Uvh rabbitmq--server-3.6.10-e17.norach.rpm
#systemctl start rabbitmq-server
#systemctl enable rabbitmq-server
#rabbitmqctl add_user test test --> user test & pwd test
#rabbitmqctl set_user_tags test adminstrator
#systemctl restart rabbitmq-server
#exit
================================================================================
## Setup app server Tomcat ##
#vagrant ssh app01
#sudo -i
#yum update -y
#yum install epel-realese-y
#yum install java-1.8.0-openjdk -y
#yum install git maven wget -y
#cd /tmp
#wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.83/bin/apache-tomcat-8.5.83-windows-x64.zip
#unzip apache-tomcat-8.5.83-windows-x64.zip
#useraddd --home-dir /usr/local/tomcat8 --shell /sbin/nologin tomcat
#rsync -avzh /tmp/apache-tomcat-8.5.83-windows-x64 /usr/local/tomcat8
#chown -R tomcat.tomcat /usr/local/tomcat8
#vi /ect/systemd/system/tomcat.service
[unit]
Descrption=tomcat
After=network.target

[servcie]
user=tomcat
workingdirectory=/usr/local/tomcat8
Enviroment=JRE_HOME=/usr/lib/jvm/jre
Enviroment=JAVA_HOME=/usr/lib/jvm/jre
Enviroment=CATALINA_HOME=/usr/local/tomcat8
Enviroment=CATALINA_BASE=/usr/local/tomcat8
ExecStart=/usr/local/tomcat8/bin/catalina.sh run
ExecStop=/usr/local/tomcat8/bin/shutdown.sh
syslodIdentifier=tomcat-%i

[install]
wantedBy=multi-user.target
#systemctl deamon reload
#systemctl start tomcat
#systemctl enable tomcat
#systemctl status tomcat
#gitclone url of repo
#cd vprofile-project
#mvn install 
#cd target
#systemct stop tomcat
#rm -rf /usr/local/tomcat8/webapps/ROOT
#cd ../
#cp target/vprofile.war /usr/local/tomcat8/webapps/ROOT.war
#ls /usr/local/tomcat8/webapps
#systemctl start tomcat
#exit
==============================================================================
## Setup nginx ## (ubuntu)
#vagrant ssh web01
#sudo apt update && apt upgrade
#sudo -i
#apt install nginx
#vim /etc/nginx/sites-available/vproapp
upstream vproapp {
   server app01:8080;
   }
server {
   listen 80:
location / {
   proxy_pass http://vproapp ;
   }
   }
#rm -rf /etc/nginx/sites-enabled/default
#ln -s  /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp
#systemctl restart nginx
#ifconfig
copy the ip of enp0s8 and go browser paste it ip. here u can see ur webpage
then trying to login to id:admin_vp : pasword : admin_vp
 here u can see all ur webpage
=================================================================================
# Now i can above infra automated by Shell scrpting ##
#exit
#vagrant destroy
#cd vprofile-project/vagrant
#vagrant up
all vms connected goto google ip 
 ### done ###