Java code--> war/jar
windows--> DLL/EXE/MSI or Zip/Tar

Continous Intigration (CI)
code---->fetch--->build-->test--->notify--->
feed back.
any failure in code notification send developer and fix and again push and build all the process runs when code is succesfully tested.

# An integrated development environment (IDE)
 is a software application that helps programmers develop software code efficiently.
 # IDE tools
 1. Eclipse
 2. Visual studio
 3. Atom
 4. Pycharm
 # Version Control System 
 1. Git
 2. Bit bucket
 3.  Subversion(SVN)
 4. Total Flowgate Capability(TFS)
 5. Perforce
 6. Etc Etc
 # Build tools ##
 1.Maven,Ant,Gradle 
 2. Ms build, Visual Build
 3. IBM urban code
 4. Make & Grant
 # Software repository (store artifacts) ##
 1. Sona type nexus
 2. Jfrog artifactory
 3. Archiva
 4. Cloudsmith package
 5. Gruant
 # Continous Integration (CI) tools #
 1. Jenkins
 2. Cicrle Ci
 3. Teamcity
 4. Bamboo Ci
 5. Crusie control

Continous Developement 
1. server provisioning
2. install dependicies
3. Conf changes
4. Network (inbound/outbound rules)
5. Artifact deploy
# Tools #
1. Ansible,puppet,Chef ----> for system automation
2. Terraform,Cformation --> for cloud Infrastructure automation
3. Jenkins,Octopus deploy---> for CICD automation
4. Helm charts,code deploy ......etc
## Testing Automation ##
1. Functional testing
2. Load testing
3. Performance testing
4. Database Testing
5. Security Testing

code build--->code test-->code analysis--->delivery--->Db/sec changes-->sofrware testing-->schedule production deployment
====================================================
Installing tools
1. jdk8
2. maven
3. intellij
4. sublime text editor
Signup tools
1. Github
2. Domain purchase page (go daddy)
3. Dockerhub
4. Sonarcloud
AWS
1. free tier account
2. IAM with MFA(multi factor authencation)
3. Billing alarm
4. Certificate setup
=========================================================




# Installing Chocklety in windows ## Homebrew for macos
go to ---> google --->https://chocolatey.org/---->open ur power shell----> run this command -->#Get-ExecutionPolicy -->#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))---->click enter.

if u want any install software goto serach bar and search it then install 

#choco install virtual box -y
#choco install vagrant
#choco install git
#choco install jdk11
#choco install maven
#choco install awscli
#choco install intellijidea-community
#choco install sublimetxt3.app
=======================================================
# Git hub ##
search -->git hub -->signup-->give user name -->email--->password-->signup---->create account-->verify image--->join for free plan--->welcome to git hub-->select what type of account--->student-->learn git hub-->cmplt setup.
goto ur email and verify github account confirmation.
=====================================================
# Purchase a domain in GODADDY  ##
google-->godaddy-->search for domain-->search mydevops domain-->it cost 200--->add cart-->purchase.
goto ur domain--->see ur dns.
=========================================================
## Docker hub account creation ##
google---->hub.docker.com--->then signup-->give docker id and email and password-->signup--->choose free plan--->verify ur email ---> done
=======================================================
## SonarCloud account creation ##
google---->sonarcloud.io--->signup with ur github account--->authorize sonarcloud--->done
click on create project manually-->create organisation manually-->key name--->continue--->choose free plan--->create organisation--->project key-->display name-->setup...
=========================================================
## AWS ##
# Free tier account creation ##
google--->awsconsole--->create free tier account---->email --->password-->confirm pwd-->name-->create-->fill all details-->create account and continue--> give ur debit card/credit card details--->2 rupees deducted and after 2 days ur 2 rupees will be credit--->done

## createing IAM user #
login to ur amazon console account--->IAM-->users-->add user--->user name(prasad)--->tik the amazon console access-->next--->attach existing policies directly--->select addmistrate permissoins--->next-->create user--->download.csv.
======================================================
aws consloe-->login through IAM user--->login though ur IAM user --> change ur passwords--->login

cloud watch-->alarms-->create alarm-->select metric-->billing--->total estimated charge-->usd-->select metric--->define threshold value-->
5-->next--->create new topic-->my_mail_id-->give ur email-->create topic-->next-->alarm name(aws_billing) -->
next-->create alarm...
verify ur mail..
=========================================================
## Create Certificate Manager ##
Certificate Manager--->provison certificate--->get started---> request public certificate-->request a certificate---> domain name--> give ur domain name(which ur purchased in godaddy)--->next-->select validation verification--->dns validation-->next-->tag name-->review-->next-->confirm and requset-->continue-->done validation ur domain green tik.

goto ur godaddy-->add-->type-->cname-->hostname(give host name from ur aws certifiation)-->point to(copy ur aws certification value)----->  save
========================================================
## IAM user MFA ##
goto-->aws console-->IAM user-->user-->see ur user name-->security credentials-->assigned MFA device--->manage-->virtual MFA device-->assign mfa-->continue-->install google authencator in ur mobile-->scan ur qr code-->mfa code1-->mfa code2-->assign MFA-->close.
security alerts--->delete access key and enable mfa.
==================================================================================================================
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
=====================================================================================
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
========================================================
### Projec4 ####
## AWS Project ##
Name: Refactoring with AWS
## AWS Resources for Front end ##
Beanstalk--> Vm for tomcat app
Beanstalk-->nginx Load balancer Replacement
Beanstalk-->Automation for vm scaling
S3/EFS--> for storage artifacts
## AWS Resources for Backend services ##
RDS instance-->for Databases
Elastic cashe--> memcashed
Active mq--> for Rabbit mq
Route53-->DNS
Cloud front-->content delivery network
# Architecture of AWS services for Project #
Ec2 instances, ELB, Autoscaling, EFS/S3,   RDS. Elastic cashe, Active mq ,Route53, cloud front.
==============
user-->url-->amazon route52--->amazon cloud front--->application load balancer-->tomcat-->artifact sotred in s3 bucket -->these are all frontend

memcash-->mysql
===========
## Comparasion ##
Beanstalk replaces --> Tomcat Ec2/VM
ELB in Beanstalk replace--> Nginx Lb/ELB
Autoscaling-->Autoscaling
EFS/S3 --> NFS/S3/EFS
RDS --> MYsql on vm/ec2
Elastic cashe-->memmcashe on vm/ec2
Active mq-->Rabbit mq on vm/ec2
route53-->godaddy,Local dns
cloud front-->none
=================================
## Flow of Excution ##
1. loginto aws console
2. create key pair for beanstalk instance login
3. create security group for elasticcashe,RDS,Active mq
4. create RDS,Amazon elastic cashe,Amazon active mq
5. create elastice beanstak enviorment
6. update SG of backend to allow traffic from bean SG
7. update SG of backend to allow intrnal traffic
8. launch for instance for Db
9. login into instance and initializing RDS DB
10. change health check on beanstalk to /login
11. add 443 https listener to ELB
12. build artifact with backend information
13. Deploy artifact to beanstalk
14. create cdn with ssl alert
15. update entry in godaddy dns zones
16. test the url
======================================================
Aws console-->create key pair and create security group-->name(vprofile-backend-SG)-->add -->22-->myip
->create-->edit inbound rule-->all trafic-->vprofile-backend-SG->save
## create RDS ##
rds-->subnet group-->create db group-->name(vprofile-rds-sub-group)-->select all avialabilty zone-->create.
Parameters group-->create parameter group-->mqsql5.6-->group name(vprofile-parameter-group)-->create.

Database-->create database-->standard database-->mqsql-->version 5.6-->free tier-->db name(vprofile-db)-->password auto genarate--->db instance class-->burstble classes-->avalibilty-->do not create a standard instance-->subnet-->select ur own subnet-->select security group-->choose ur own parameter group-->log select all-->create database.
view credentals-->save it
====================================================
# create Elasticcashe #
aws-->Elasticcashe-->parameter groups-->create-->family(memcashed4)-->name(vprofile-memcashed-parameters)-->create.
Subnet group-->create subnet-->name(vprofile-memcash-subnet-group)-->selct vpc-->selct subnet-->select avialibilty-->create
Memcashed-->create-->memcashed-->name(vprofile-memcashed)-->parameter group->choose ur group-->select node type-->choose t2.micro-->save-adavanced setting-->security group-->choose ur Sg-->save-->sns-->select topic--->creat.
===============================
# create amazon mq ##
aws-->amazon mq-->get started-->single instance broker-->next-->broker name(vprofile-rmq)-->t2.micro-->
simple authentcation-->username(rabbitmq)-->password(12345)-->additional setting-->logs-->slct genaral,audit-->security group -->select ur own security group-->public accesbilty(no)-->create broker.
================================================
RDS copy endpoint 
aws-->lanuch instance-->ubuntu8-->next..-->review&launch.
copy the ip and goto putty-->ubuntu@ip
#sudo apt update
#sudo apt install mysql-client -y
#mysql -h "rdsendpoint" -u admin -p 12345
#show database
#git clone url
#cd vprofile-project/
#git branch -a
#git checkout aws-Refact
#cd src/main/resources
#ls
#mysql -h "rdsendpoint" -u admin -p 12345 accounts < db_backup.sql
==done==
========================================================
## Create Elastic beanstack ##
 goto aws -->Elastic beanstack-->create application-->applictaion name(vprofile)-->platform-->select tomcat-->version 8.5-->configure more options-->instacnce section-->edit-->seclect security group-->save.-->capacity-->edit-->enviorment-->loadbalacer-->instances-->max5 and minimum2-->save.-->loadbalancer-->edit-->application loadbalancer-->save.-->Rolling updates and depolyments-->edit-->deployment polciy-->rolling--batch size(50)-->save.--->security-->edit-->select keypair-->save. -->monitoring-->edit-->system-->enhanced-->logstream enable-->save.-->create app..
 your enviorment is up and running.
 ==================================================
  update the backend security group--->security groups--select the backend security group-->edit inboundrules-->addrule-->type-->allow-->mysql-->source-->select beanstack security group.
  add one more rule--> custom tcp-->port 11211-->source-->select beanstack security group.
  add one more rule-->custom tcp-->port 5671-->source-->select beanstack security group-->
save rules.
=======================================================
goto beanstak enviorment -->configuration-->load balancer-->edit-->add listener-->port443-->https--> choose certificate-->add.-->apply.
=================================================
# deploy the source code into elastic beanstack env #
goto gitbash-->clone repo-->
#cd vprofile-project
#git branch -a
#git checkout aws-Refactor
#cd src/main/resources
#vi application.properties
here update ur rds dns address
at memcashe host-->give memcash dns address
at rabbit mq-->give rabbitmq dns address
save.
#cd ../../..
#mvn install
artifact created
# this artifact deploy in beanstack env #
aws-ealstic beanstack-->applications versions->upload-->version label(vprofile-v1)-->upload file-->choose ur artifact form ur local-->upload .

application versions-->selct vprofile-v1-->actions-->deploy-->select enviorment-->deploy.

goto envirment section-->slect env-->here u can see env updateing is starting.
==================================================
goto godaddy-->  add env dns address-->
goto google-->serach with ur vprofile.groophy.com-->ur site is opened
=============================================
# cloud front #
aws-->cloud front-->create distrbution->get started-->orign domain name(vprofile.groophy.com)-->ssl certifcate-->custom certificate-->security policy-->Tslv1-->create distribution.

# done # project....
======================================================

### Project 5 ###
## Jenkins CICD Project ###
# Tools #
1. Jenkins--> for contionus intgreation
2. Git--> version contorl system
3. Maven--> Build tool
4. check style-->code analysis tool
5. Slack --> for notification
6. Nexus-->for store artifact
7. Sonar qube--> for deep code analysis
8.  Aws Ec2
## Architecture of Continous integration pipeline #
Developers-->push the code-->git hub-->trigger build-->fetch-->build-->unit testing-->code analysis-->quality gates-->notification-->version artifact-->upload artifact-->artifactory repository-->any build failure sent notifycation to developers. it's continous process
## Flow of Excution ##
1. log in to aws console
2. create key 
3. create securit groups 
  1. jenkins server SG
  2. Nexus server SG
  3. Sonar server SG
4. Create Ec2 instances with userdata
   1. Jenkins
   2. Sonarqube
   3. Nexus
5. Jenkins post installation
6. Nexus Repository setup (setup 3 repo)
7. Sonarqube post installtion
8. Jenkins steps
   Build job
   setup slack notification
   check stylecode analysis job
   setup sonar integration
   sonarcode analysis job
   artifact upload
9. Connect above all jobs the in jenkins
10. setup automatic build triggers
11. Test with intellij
12. cleanup
=======================================================
1. log into aws console
2. create keypair
ec2-->keypair-->create keypair-->keypair name-->.ppk for putty and .pem for git bash-->create key pair
3. Create Security groups
  1. security groups-->create security group-->security group name(jenkins_Sg)-->add 2 rules-->port 8080 and 22 for ssh-->allow for myip--->add rule-->all traffic-->allow sonar sg-->create security groupcreate security group.
  2. security groups-->create security group-->security group name(Nexus_Sg)-->add 2 rules-->port 8081 and 22 for ssh-->allow for myip--->add rule-->port 8081-->allow jenkins sg-->create security group.
  3. security groups-->create security group-->security group name(Sonar_Sg)-->add rules-->port 80 and 22 for ssh-->allow for myip --->add rule-->port 8081-->allow jenkins sg-->create security group.
4. Create Ec2 instances
aws-->ec2-->lanuch instance("JENKINS")-->ubuntu18-->t2.small--->configure -->user data -->here give ur script for jenkins installnation-->next-->next-->configure security groups-->select jenkins sg-->review and launch.
script: 
#!/bin/bash
sudo apt update
sudo apt install openjdk-11-jdk -y
sudo apt install maven -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
###
# Create instance for Nexus
aws-->ec2-->lanuch instance("Nexus")-->ubuntu18-->t2.small--->configure -->user data -->here give ur script for nexus installnation-->next-->next-->configure security groups-->select Nexus sg-->review and launch.
script: 
#!/bin/bash
yum install java-1.8.0-openjdk.x86_64 wget -y
mkdir -p /opt/nexus/
mkdir -p /tmp/nexus/
cd /tmp/nexus/
NEXUSURL="https://download.sonatype.com/nexus/3/latest-unix.tar.gz"
wget $NEXUSURL -O nexus.tar.gz
EXTOUT=`tar xzvf nexus.tar.gz`
NEXUSDIR=`echo $EXTOUT | cut -d '/' -f1`
rm -rf /tmp/nexus/nexus.tar.gz
rsync -avzh /tmp/nexus/ /opt/nexus/
useradd nexus
chown -R nexus.nexus /opt/nexus
cat <<EOT>> /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/$NEXUSDIR/bin/nexus start
ExecStop=/opt/nexus/$NEXUSDIR/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target

EOT

echo 'run_as_user="nexus"' > /opt/nexus/$NEXUSDIR/bin/nexus.rc
systemctl daemon-reload
systemctl start nexus
systemctl en
able nexus
# Instance for Sonarqube 
aws-->ec2-->lanuch instance("Sonarqube")-->ubuntu18-->t2.medium--->configure -->user data -->here give ur script for nexus installnation-->next-->next-->configure security groups-->select Sonar sg-->review and launch.
# script:
#!/bin/bash
cp /etc/sysctl.conf /root/sysctl.conf_backup
cat <<EOT> /etc/sysctl.conf
vm.max_map_count=262144
fs.file-max=65536
ulimit -n 65536
ulimit -u 4096
EOT
cp /etc/security/limits.conf /root/sec_limit.conf_backup
cat <<EOT> /etc/security/limits.conf
sonarqube   -   nofile   65536
sonarqube   -   nproc    409
EOT

sudo apt-get update -y
sudo apt-get install openjdk-11-jdk -y
sudo update-alternatives --config java

java -version

sudo apt update
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo apt install postgresql postgresql-contrib -y
#sudo -u postgres psql -c "SELECT version();"
sudo systemctl enable postgresql.service
sudo systemctl start  postgresql.service
sudo echo "postgres:admin123" | chpasswd
runuser -l postgres -c "createuser sonar"
sudo -i -u postgres psql -c "ALTER USER sonar WITH ENCRYPTED PASSWORD 'admin123';"
sudo -i -u postgres psql -c "CREATE DATABASE sonarqube OWNER sonar;"
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE sonarqube to sonar;"
systemctl restart  postgresql
#systemctl status -l   postgresql
netstat -tulpena | grep postgres
sudo mkdir -p /sonarqube/
cd /sonarqube/
sudo curl -O https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.3.0.34182.zip
sudo apt-get install zip -y
sudo unzip -o sonarqube-8.3.0.34182.zip -d /opt/
sudo mv /opt/sonarqube-8.3.0.34182/ /opt/sonarqube
sudo groupadd sonar
sudo useradd -c "SonarQube - User" -d /opt/sonarqube/ -g sonar sonar
sudo chown sonar:sonar /opt/sonarqube/ -R
cp /opt/sonarqube/conf/sonar.properties /root/sonar.properties_backup
cat <<EOT> /opt/sonarqube/conf/sonar.properties
sonar.jdbc.username=sonar
sonar.jdbc.password=admin123
sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube
sonar.web.host=0.0.0.0
sonar.web.port=9000
sonar.web.javaAdditionalOpts=-server
sonar.search.javaOpts=-Xmx512m -Xms512m -XX:+HeapDumpOnOutOfMemoryError
sonar.log.level=INFO
sonar.path.logs=logs
EOT

cat <<EOT> /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking

ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop

User=sonar
Group=sonar
Restart=always

LimitNOFILE=65536
LimitNPROC=4096


[Install]
WantedBy=multi-user.target
EOT

systemctl daemon-reload
systemctl enable sonarqube.service
#systemctl start sonarqube.service
#systemctl status -l sonarqube.service
apt-get install nginx -y
rm -rf /etc/nginx/sites-enabled/default
rm -rf /etc/nginx/sites-available/default
cat <<EOT> /etc/nginx/sites-available/sonarqube
server{
    listen      80;
    server_name sonarqube.groophy.in;

    access_log  /var/log/nginx/sonar.access.log;
    error_log   /var/log/nginx/sonar.error.log;

    proxy_buffers 16 64k;
    proxy_buffer_size 128k;

    location / {
        proxy_pass  http://127.0.0.1:9000;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_redirect off;

        proxy_set_header    Host            \$host;
        proxy_set_header    X-Real-IP       \$remote_addr;
        proxy_set_header    X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto http;
    }
}
EOT
ln -s /etc/nginx/sites-available/sonarqube /etc/nginx/sites-enabled/sonarqube
systemctl enable nginx.service
#systemctl restart nginx.service
sudo ufw allow 80,9000,9001/tcp

echo "System reboot in 30 sec"
sleep 30
reboot

5. post installtion of jenkins 
putty-->jenkins server connect
#cat /var/lib/jenkins/secrts/intialadminpassword
  copy the password.
google-->jenkinsip:8080-->jenkins gui opened--->enter password.
install all plugins-->set ur own userid and password-->finish.
=======================================================
# connect nexus server
putty --> nexus ip-->connect
#cat /opt/nexus/sonatype-work/nexux3/admin.password
  copy the password
google --> nexusip:8081-->nexus gui opened
-->sign in-->user 'admin' and pasword:pasteit-->next-->setup ur own password-->enable enanyoums-->next-->goto setting symbol for create repository-->maven2host-->name-->vprofile-relese-->create repo.
goto setting symbol for create repository-->maven2 proxy-->name-->vprofile-central-->create repo.

goto setting symbol for create repository-->maven2 root-->name-->vprofile-group-->member repository-->select create repo vprofile-relese and vprofile-central and vprofile-snapshot -->create repo.

goto setting symbol for create repository-->maven2 host-->name-->vprofile-snapshot-->version policy -->snapshot-->create repo.

these all settings in ur .m2 setting.xml file
=====================================================
# Start jenkins job #
# variables:
SNAP-REPO= vprofile-snapshot
NEXUS-USER=admin
NEXUS-PASS=admin123
RELEASE-REPO=vprofile-relese
CENTRAL-REPO=vpro-maven-central
NEXUS-GRP-REPO=vpro-maven-group
NEXUSIP= private ip nexus server
NEXUSPORT=8081
gotojenkinsgui--->createjob-->newitem-->name-->build-job--->free style-->ok.
source code--->git-->git repo url-->https://github.com/reddiprasad72/vprofile-project.git-->branch-ci-jenkins-->build-->add build steps-->invoke toplevel maventargets-->goals-->install- Dskip tests-->advanced-->setting file-->setting file in system-->file path-->settings.xml-->properties-->SNAP-REPO= vprofile-snapshot
NEXUS-USER=admin
NEXUS-PASS=admin123
RELEASE-REPO=vprofile-relese
CENTRAL-REPO=vpro-maven-central
NEXUS-GRP-REPO=vpro-maven-group
NEXUSIP= private ip nexus server
NEXUSPORT=8081-->save and apply
build now-->success
goto ur nexus dashboard here store all data
===============================================
## Slack for notification alert ##
goto goole-->api.slack.com--->start buliding-->create app-->name-->Jenkins-->workspace-->vprofile-->create app
outh and permissions-->bot token scops-->add-->chat-write-->install app to workspace-->allow--->copy the token.

goto -->slack.com-->create account-->login--->channel-->create channel-->name-->
vprofile-jenkins-notification-->create-->message-->@jenkins-->enter-->invite channel.

go to jenkins-->configure-->manage plugins-->avialable-->serach--->slack-->slack notification-->install without restart.

manage jenkins-->manage credentials-->jenkins-->global credentials-->add credentials-->kind-->sercret test-->copy the token at secret-->id -->slack-token-->ok

manage jenkins-->configure system-->slack-->custom slack bot user tik it-->save and apply.

goto ur job-->configure-->post build action-->slack notification--> mark what type of notification u want-->go advanced-->credentials-->selct slack-token-->workspace-->vprofile-->channel-->#vprofile-jenkins-->test connection.
post build acion-->archive the artifact-->file to archive-->**/*.war--->save apply. and build.
===================================================
# Test JOb #
jenkins-->new item-->test-->free style-->copy from-->build-job-->ok-->invoke toplevel maventargets-->goals-->test-->remove archive-->save apply. and then build.
# Integration job #
jenkins-->new item-->integration-->free style-->copy from-->test-->ok-->invoke toplevel maventargets-->goals-->verify-DskipUnitTests-->save apply. and then build.
=====
goto test job-->configure-->add-post build action-->build other project-->project to build-->integration-->save.

goto build job-->configure-->add-post build action-->build other project-->project to build-->test-->save.
=========================================
# Code analysis #
managejenkins-->manageplugins-->avilable-->search-->check style-->checkstyle and violation-->install without restart.

create new item-->name-->code_analysis-->free style-->copy from build-->ok-->git-->branch-->*/vp-rem-->goals-->checkstyle:checkstyle-->and delete trigger next job-->save apply. and then build.
here crate 2 folders in target dir 1.checkstyle-checker.xml 2.checkstyle-result.xml.
# here get some error that was vp-rem branch not in ur setting.xml so u can remove that step #
now i want trigger next job when this shows low warnigs.
goto-->code_analysis-->configure-->add post build actions-->report violation-->check style-->target/checkstyle-result.xml-->10,100,100-->(it means when code errors above 100 then this going to unstable state)-->save apply.
build-->here shows u yellow clr ball -unstable

goto ur ci-jenkins branch  and back to settings.xml step and build now ..
here success the build..

Now integrate this job in ur pipe line
go to -->integration job-->configure-->add post build actions-->build other jobs-->code_analysis->save apply.

# here we conncet 4 jobs build-->test-->integation-->code_analysis.

Now Integrate Sonarqube sever..
goto google-->sonarserverip:80.-->gui opened-->log in-->user admin pwd admin.-->(create token for jenkins integration)-->goto admin-->my account-->security-->enter token name(sonaer token)-->geanrate-->copy that token. store it.

jenkins-->manage jenkins-->manage plugins-->avilable-->search-->sonar-->select Sonarqube scanner and Sonar quility gates-->install without restart.

manage jenkins-->global tool configuration-->sonarqube scanner-->add-->select version-->name(Sona-4.4.210170)->save.

manage jenkins-->configure system-->sonarqube servers-->tik enable injection-->add sonarqube-->name (vprofile-sonar)-->server url (privateip:80)-->servera authentication-->add-->jenkins-->kind-->secret text-->secret-->copy the sonar token here-->id (sonar)-->add-->select sonar-->then go down-->Quility gates-sonarqube-->add sonar instance-->name(sonar-vprofile)-->sonarqube url-->sonarqube token-->save apply.

New item-->name(Sonarscanner-codeanalysis)-->freestyle-->copy from build job-->ok-->goals-->install-->build-->invoke-top level maven targets-->goal-->checkstyle:checkstyle-->remove archive step-->remove build triggers step-->build-->add build step-->excute sonarqube scanner-->anlysis properties-->
write -->
sonar.projectKey=vprofile
sonar.projectName=vprofile-repo
sonar.projectVersion=1.0
sonar.sources=src/
sonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/
sonar.junit.reportsPath=target/surefire-reports/
sonar.jacoco.reportsPath=target/jacoco.exec
sonar.java.checkstyle.reportPaths=target/checkstyle-result.xml
--->save apply then build.
goto sonar gui there u can see code full report like bugs, vunabilities,code smells..etc.

sonar gui-->quility gates-->creat-->name(vprofile-QuilityGate)-->save-->add condition-->overall code-->bugs-->value 50--> add condition.

project-->vprofile-repo-->project settings-->Quility gates-->selcet vprofile-QuilityGate.

jenkins-->sonarscanner-codeanalysis-->configure-->add post build actions-->quality gate sonar plugin-->project key-->vprofile-->fail-->save apply.
# here code analysis errors are above 50 then job will be fail #
jenkins-->code analysi job-->configure-->build other projects-->project to build-->Sonarscanner-codeanalysis-->save and apply
=====================================================
## Store the Artifact in Nexus #
Jenkins-->manage jenkins--->manage plugins-->avialble-->search for nexus artifact uploader-->install with out restart-->search for copy artifact-->installwithoutrestart-->search-->zentmestemp-->installwithoutrestart.

Newitem-->name(deploy to nexus)-->free style-->ok-->geanral-->tik change date pattern for the BUILD_STAMP-->date and time pattern-->yy-mm-dd_hhmm
-->build-->add build step-->copy artifact from another project-->projct name-->build job-->artifacts to copy-->**/*.war-->add build step-->nexus artifact uploader-->version-->nexus3-->nexus server url-->nexusprivate@8081-->credentials-->add-->username-->admin-->pasword(12345)-->add-->group id (QA)-->version-->V$BUILD_ID-->repository-->vprofile-release-->artifact-->add-->artifact id-->vprofile-$BUILD_TIMESTAMP-->type-->war-->file-->target/vprofile-v2.war-->add post build action-->slack notification-->tik notify build,notify success,notify unstable,every file,back to normal-->advanced-->workspace-->visulpath-->credentials-->slack token-->channel-->#vprofile-jenkins->save apply.
build --success
 
 goto nexus and check the artifact.
 nexus-->vprofile-realeae-->here u can see war file..

Now integrte in pipeline after sonarScnner job

jenkins-->SonarScanner-CodeAnalysis-->post build actions-->build other projects-->Deploy to nexus-->save apply.
# all jobs are integrated #
 now
 jenkins-->manage jenkins-->manage plugins-->avilable-->search-->Build pipeline-->install without restart..

all jobs-->click on + symbol-->view name(vprofile-continoues-integration)-->build pipeline view-->ok-->pipe line flow-->upstream downstream config-->select intial job(build)-->display options-->no of displayed builds-->5-->save.
here shows all jobs one by one.and then test entire pipeline.  click on run .

# set automatic trigger #
jenkins-->build job-->configure-->build triggers-->pol scm-->schedule-->*****-->(every minute every hour ever day every month every week)-->save apply..

now do some changes in ur code it will triggred automatically build it.
================================================
# Data backup of cicd stack #
1. Create S3 bucket
2. Create IAmM role with s3 access
3. Attch role to all your instances
4. login into jenkins instance
5. shutdown jenkins server
6. clean up unneccssery data 
7. Archive var/lib/jenkins
8. install aws cli on ur jenkins server.
9. copy jenkins archive to s3 bucket
10. login to nexus server 
11. shutdown nexus server 
12. archive /opt/nexus dir
13. install aws cli in nexus server
14. copy nexus archive to same s3 bucket
15. login to sonar server
16. shutdown sonar server
17. Archive /opt/sonarqube dir
18. Archive /var/lib/postgreaql dir
19. install aws cli on sonar server
20. copy sonar and postgreaql archive in same s3 bucket.
21. notedown names of s3 buckets and archive file names

# jenkins backup #
aws-->s3-->create-->name(vprofile-cicd-stack-backup)-->create bucket.
IAM-->roles-->create role-->ec2 instance-->next-->policy-->amazons3fullaccess-->next-->role name(vprofile-cicd-s3fullaccess)-->create role.
  Now attach role to all servers.
jenkins server-->actions-->instance setting-->modify iam role -->select ur role-->save.
 # like this add role to all servers

Login to jenkisn server--->
#sudo su -
#systemctl stop jenkins
#cd var/lib/
#du -sh jenkins --> here shows jenkins file size.
#cd /jenkins
#cd .m2/repositiore
#rm -rf *
#cd ../..
#cd workspace
#rm -rf *
#cd ../..
#cd jobs/BuildProject/builds-->here shows jobs run numbr
#rm -rf 1 10 5
#cd ../../../../..
#tar -czvf jenkins_cicdjobs.tar.gz jenkins 
#apt update && install awscli -y
#aws s3 cp jenkins_cicdjobs.tar.gz s3://vprofile-cicd-stack-backup/(bucketname)
# NEXUS server backup #
login to nexus server in putty cli
#sudo su -
#cd /opt
#systemctl stop nexus
#tar -cvzf nexus-cicd-vpro-pro. tgz nexus
#aws s3 cp nexus-cicd-vpro-pro. tgz s3://vprofile-cicd-stack-backup
# Sonarqube Backup #
loginto sonar server in putty cli.
#sudo su -
#systemctl stop sonarqube
#cd /opt
#tar -cvzf sonarqube-cicd-vpro-pro. tgz sonarqube
#aws s3 cp sonarqube-cicd-vpro-pro. tgz s3://vprofile-cicd-stack-backup
# tomcat server backup #
app tomact server login to putty cli
#sudo su -
#cd usr/local/tomcat8/conf
#aws s3 cp tomcat-users.xml s3://vprofile-cicd-stack-backup
#cd ../
#cd webapps/manager/META-INF
#aws s3 cp context.xml s3://vprofile-cicd-stack-backup
#aws s3 ls vprofile-cicd-stack-backup -->shows all files
 done NOw shutdown the all servers
# jekins new server setup with our backup #
aws-->ec2-->lanuch instance. and attach iam role to this sever.
jenkinsip:8080-->jenkins gui opened.
loginto jenkisn server in putty
#sudo su -
#systemctl stop jenkins
#cd var/lib
#ls -ld jenkins
#sudo apt install aws cli
#aws s3 cp s3://vprofile-cicd-stack-backup/jenkins_cicdjobs.tar.gz .
--> jenkins backup file downloaded
#tar xvzf jenkins_cicdjobs.tar.gz
#ls -ld jenkins
#chown jenkins. jenkins jenkins -R
#systemctl start jenkins
 
goto jenkins cli refresh page here ask ur credentils u can give  old jenkins credentials and then login jenkins and here shows all jobs waht are u created previosuly.
 # done #
========================================================