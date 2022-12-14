########### Projec3 #############
Name: Lift and Shift Application workload 
here our vprofile project lift and shift aws cloud
# About the project #
Multi tier web application stack(Vprofile-project)
Host & run on aws cloud for Production
lift & shift strategy
## teams required #
Virtualization team , Data centre opertation team, monitoring team, system admin team..etc
# problem 
complex management these teams and servers
scale up / scale down complexcity
upfront cost and reguralr operation cost
manuall process
diffcult to automation
time consumeing
## solution 
cloud setup
ec2 service for --> vm for tomcat,sql,rabbit mq
ELB(elastic load balancer)--> nginx replacement
Auto scaling-->automation for vm scaling
S3/Efs storage-->shared storage
Route53-->private dns service
IAM role,ebs...etc
## AWS Architecture design for this project 
ec2 instance,ELB,Autoscaling,EFS/s3 for shared storage,amazon certificate manage,route53

# Flow of Excution #
1. login into aws account-->create keypairs-->create security groups-->lanuch instances.
2. Update ip to name mapping in route53
3. Build Application from source code
4. upload to s3 bucket
6. download artifacts to ec2 instance from s3 bucket
7. Setup ELB with HTTPS [certificate from amazon certificate manager]
8. Map ELB endponit to website name in Godaddy DNS
9. verify
10. Build auto scaling group for Tomcat
==================================================================================
goto aws console
Create security group for load balancer
ec2-->security groups-->create security group-->name-->vprofile-ELB--> Descrption-->vprofile-project-ELB-SG-->add rule-->http-->anywhere.
-- add rule-->https-->create security group.
Security group for tomcat
ec2-->security groups-->create security group-->name-->vprofile-app-SG--> Descrption-->vprofile-project-Tomacat-SG-->add rule-->port -->8080-->source-->select ur ELB SG-->Descrption-->allow the traffic from ELB-->add rule-->create security group.
Security group for Backend services
ec2-->security groups-->create security group-->name-->vprofile-Backend-SG--> Descrption-->vprofile-project-backend-SG-->add rule-->mysql-->source-->select ur app-SG-->Descrption-->allow the traffic from app-sg-->
add rule-->port-->11211(Memcashed port)-->source-->select ur app-SG-->Descrption-->allow the traffic from app-sg-->
add rule-->port-->5672 (Rabbitmqport)-->source-->select ur app-SG-->Descrption-->allow the traffic from app-sg-->
add rule-->all traffic-->port-->all-->source-->select ur backend-SG-->Descrption-->allow the traffic from app-sg-->save.

## Create EC2-Instance fro mysql ##
open ur git bash and 
$git clone https://github.com/devopshydclub/vprofile-project.git
$git checkout aws-LiftAndShift
$cd userdata/
$ls --> here shows all scrpits
backend.sh*  memcache.sh*  mysql.sh*  nginx.sh  rabbitmq.sh*  tomcat.sh  tomcat_ubuntu.sh*

#vi mysql.sh*

#!/bin/bash
DATABASE_PASS='admin123'
sudo yum update -y
sudo yum install epel-release -y
sudo yum install git zip unzip -y
sudo yum install mariadb-server -y


# starting & enabling mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
cd /tmp/
git clone -b vp-rem https://github.com/devopshydclub/vprofile-repo.git
#restore the dump file for the application
sudo mysqladmin -u root password "$DATABASE_PASS"
sudo mysql -u root -p"$DATABASE_PASS" -e "UPDATE mysql.user SET Password=PASSWORD('$DATABASE_PASS') WHERE User='root'"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.user WHERE User=''"
sudo mysql -u root -p"$DATABASE_PASS" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'"
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"
sudo mysql -u root -p"$DATABASE_PASS" -e "create database accounts"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on accounts.* TO 'admin'@'localhost' identified by 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on accounts.* TO 'admin'@'%' identified by 'admin123'"
sudo mysql -u root -p"$DATABASE_PASS" accounts < /tmp/vprofile-repo/src/main/resources/db_backup.sql
sudo mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"

# Restart mariadb-server
sudo systemctl restart mariadb


#starting the firewall and allowing the mariadb to access from port no. 3306
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent
sudo firewall-cmd --reload
sudo systemctl restart mariadb


## open ur ec2-->lanuch instance-->centos7--->ami-->choose instance type-->configure instance-->userdata-->copy above script-->add storage-->add tags-->configure security groups-->choose backend-SG-->review and lanuch.

goto putty --> public ip-->login
#systemctl status mariadb
#mysql -u root -p
password: admin123
#show databases
#use accounts
#show tables
====================================================
## createing ec2 instance for Memcashed ##
#vi memcashe.sh
#!/bin/bash
sudo yum install epel-release -y
sudo yum install memcached -y
sudo systemctl start memcached
sudo systemctl enable memcached
sudo systemctl status memcached
sudo memcached -p 11211 -U 11111 -u memcached -d

open ur ec2-->lanuch instance-->centos7--->ami-->choose instance type-->configure instance-->userdata-->copy above script-->add storage-->add tags-->configure security groups-->choose backend-SG-->review and lanuch.
==============================================================================
## Creating ec2 instance for Rabbitmq ##
$vi Rabbitmq
#!/bin/bash
sudo yum install epel-release -y
sudo yum update -y
sudo yum install wget -y
cd /tmp/
wget http://packages.erlang-solutions.com/erlang-solutions-2.0-1.noarch.rpm
sudo rpm -Uvh erlang-solutions-2.0-1.noarch.rpm
sudo yum -y install erlang socat
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
sudo yum install rabbitmq-server -y
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server
sudo systemctl status rabbitmq-server
sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo systemctl restart rabbitmq-server

open ur ec2-->lanuch instance-->centos7--->ami-->choose instance type-->configure instance-->userdata-->copy above script-->add storage-->add tags-->configure security groups-->choose backend-SG-->review and lanuch.

#systemctl status memcashed
===============================================================================

## Route53 ##
Aws--->Route53-->hostedzones-->create hosted zone--->Domain name(vprofile.in)-->private--->select region-->create hostzone.
create record-->simple routeing-->define simple record-->db01-->ip address or another value depending on the record type-->place ur db1 ip-->define simple record.
one more-->create record-->
simple routeing-->define simple record-->mc01-->ip address or another value depending on the record type-->place ur mc1 ip-->define simple record

one more-->
create record-->simple routeing-->define simple record-->rmq01-->ip address or another value depending on the record type-->place ur db1 ip-->define simple record.
one more-->create record-->
===============================================================================
## Ec2 instance for Tomcat server ##
gitbash--> vi tomcat.sh for Centos7
TOMURL="https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.gz"
yum install java-1.8.0-openjdk -y
yum install git maven wget -y
cd /tmp/
wget $TOMURL -O tomcatbin.tar.gz
EXTOUT=`tar xzvf tomcatbin.tar.gz`
TOMDIR=`echo $EXTOUT | cut -d '/' -f1`
useradd --shell /sbin/nologin tomcat
rsync -avzh /tmp/$TOMDIR/ /usr/local/tomcat8/
chown -R tomcat.tomcat /usr/local/tomcat8

rm -rf /etc/systemd/system/tomcat.service

cat <<EOT>> /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat
After=network.target

[Service]
User=tomcat
WorkingDirectory=/usr/local/tomcat8
Environment=JRE_HOME=/usr/lib/jvm/jre
Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_HOME=/usr/local/tomcat8
Environment=CATALINE_BASE=/usr/local/tomcat8
ExecStart=/usr/local/tomcat8/bin/catalina.sh run
ExecStop=/usr/local/tomcat8/bin/shutdown.sh
SyslogIdentifier=tomcat-%i

[Install]
WantedBy=multi-user.target
EOT

systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat

git clone -b vp-rem https://github.com/devopshydclub/vprofile-repo.git
cd vprofile-repo
mvn install
systemctl stop tomcat
sleep 120
rm -rf /usr/local/tomcat8/webapps/ROOT*
cp target/vprofile-v2.war /usr/local/tomcat8/webapps/ROOT.war
systemctl start tomcat
sleep 300
cp /vprofile-vm-data/application.properties /usr/local/tomcat8/webapps/ROOT/WEB-INF/classes/application.properties
systemctl restart tomcat8

$vi tomcat_ubuntu.sh
#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install openjdk-8-jdk -y
sudo apt install tomcat8 tomcat8-admin tomcat8-docs tomcat8-common git -y


open ur ec2-->lanuch instance-->ubuntu 18.04--->ami-->choose instance type-->configure instance-->userdata-->copy above script-->add storage-->add tags-->configure security groups-->choose backend-SG-->review and lanuch.

aws console--IAM-->users-->user name(vprofile-project)-->programattic access--->next-->attach existing policy-->search for s3-->s3bucket fullaccess-->next-->download .csv-->
=================================================================================
open ur power shell-->$choco install jdk8--> choco install maven.

gitbash-->cd vprofile_project-->$cd src-->cd main-->cd resources-->vi application properties-->
at jbdc.url //db01.vprofile.in
at memcashed.active.host: mc01.vprofile. in
at rabbitmq.address=rmq01.vprofile.in
$cd ../../../
$mvn install --> artifact created

open ur powershell--->choco install awscli -y

goto gitbash-->cat downloads/new.user_user_credentials
$aws configure
give ur access key and secreat access key and region and json
$aws s3 mb s3://vprofile-artifact-storage --> s3 bucket created
$aws s3 cp vprofile-project/webapps/vprofile-v2.war s3://vprofile-artifact-storage/vprofile-v2.war --> war uploaded to s3
$aws s3 ls s3://vprofile-artifact-storage

aws console-->IAM-->role-->create role-->ec2-->attach existing -->s3 full access-->next-->role name-->vprofile-artifact-storage-->create role.
goto -->EC2-->select app01-->actions-->instance settings-->modify role-->select role vprofile-artifact-storage-->save.
coonect ur app01 throuh git bash
#systemctl status tomcat
#cd /var/lib/tomact/webapps
#systemctl stop tomcat
#rm -rf ROOT
#apt install aws cli
#aws s3 ls s3://vprofile-artifact-storage
#aws s3 cp s3://vprofile-artifact-storage/vprofile-v2.war /tmp/vprofile-v2.war
#cd /tmp
#cp vprofile-v2.war /var/lib/tomcat/webapps/ROOT.war
#systemctl start tomcat
==================================================================
## Setup loadbalncer ##
aws console-->ec2--->target groups-->create target group-->instance-->port 8080-->health check-->/login-->override port 8080-->next-->avilable instances-->select app01-->inclide as pendig below-->create target group
go to loadbalancer-->create loadbalancer--->application loadbalancer-->create-->name-->vprofile-loadbalncer-->loadbalancer port-->https and http-->select all the zones-->next-->select choose acm certificate from acm-->certificate-->choose ur acm certificate-->next-->choose loadbalancer-->choose loadbalancer-sg-->next-->target group-->existing target group-->next-->create...
copy dns adress
============================================================================
 ## GO daddy 
 go to godaddy-->dns-->add -->cname-->host(vprofileapp)-->points to-->copy here loadbalancer DNS adress..

 go to validate ur webapp--> browser-->vprofileapp.groohy.in
==================================================================================
## Autoscalling group for tomcat app ##
aws-->ec2-->select app instance-->action-->image-->create image-->name(vprofile-image)-->create image.

auto scaling-->launch configuration-->create launch configuration-->name(vprofile-lc)-->select ur AMI--->instance type-->t2.micro-->iam-->choose ur role-->security group-->app-sg-->keypair-->create launch..

Autoscaling-->create-->name(vprofile-asg)-->switch to lanuch configuration-->select lunch confguration-->next-->vpc-->select all subnets-->next-->enable loadbalncer-->choose tarrget group-->health check-->elb-->next-->scaling policy-->target scaling policy-->tik enable instance scale-in protection--->next-->   add notifiction-->clod alrms-->next-->tag-->name-->vprofile-project-->next-->create auto scaling group.

# validate once ur app 