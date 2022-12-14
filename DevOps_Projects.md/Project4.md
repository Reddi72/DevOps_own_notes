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