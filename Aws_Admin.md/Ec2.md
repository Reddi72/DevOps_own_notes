## EC2 ###
EC2 is short for Elastic Compute Cloud .it provides scalable computing capacity and eliminates the need to invest in hardware . 
You can use Amazon EC2 to launch as many or as few virtual servers as needed, configure security and networking, and manage storage. It can scale up or down to handle changes in requirements, reducing the need to forecast traffic.
EC2 is a virtual machine that represents a physical server for you to deploy your applications. Instead of purchasing your own hardware and connecting it to a network, Amazon gives you nearly unlimited virtual machines to run your applications while they take care of the hardware.
## Create EC2 Instance ##
From the Amazon EC2 console dashboard, choose Launch instance.
1.	Step 1: Choose an Amazon Machine Image (AMI) ... it is a template that contains the "software" configuration like amzn linux,Ubuntu,centos,macos,redhat,suse
2.	Step 2: Choose an Instance Type. ...like t2.micro,t2.large,t3.micro,a1.large,c1 large,xle.32xlarge,gpu…
3.	Step 3: Configure Instance Details. ...like no if instance ,subnet..
4.	Step 4: Add Storage. ...
5.	Step 5: Add Tags. ...
6.	Step 6: Configure Security Group. ...inbound rule
7.	Step 7: Review Instance Launch and Select Key Pair.
.pem key downloaded then converted into .ppk using puttygen tool. then login through putty.

copy ur ec2 instance public ip then open ur putty 
Hostip(34.224.98.138)-->Apperence-->change-->font style(bold)-->size(16)-->ok-->ssh-->click on +-->auth-->browse-->selct ur ppk key-->open-->login as-->ec2-user-->press enter.

# Types of Instances #
1. On-Demand instance:
you pay for compute capacity by per hour or per second depending on which instnces you run.
No longer-term commintments.
No upfront payments are needed.
# Recommands:
Users that prefer the low cost and flexibility of Amazon EC2 without any up-front payment or long-term commitment

* Applications with short-term, spiky, or unpredictable workloads that cannot be interrupted

* Applications being developed or tested on Amazon EC2 for the first time


2. Reserved instance:
provide you with a capacity reservation, and offer significant disount on hourly charge for an instance with 1year or 3 years
1 year / 3 years agreement or commitment with AWS.

3. Spot instances:
enble you to bid whatever price you want for instance capacity,provideing greater savings if your application have flexible start and end times.
There is no speed and performance guarantee from AWS
* If unused instance available then AWS provide offer to customer/users
* Based on biding:
    AWS price: $0.0043 /h
    Your Max:  $1 /h
Recommnds to:
4. Dedicated instance:
it is a physical ec2 server dedicated for your use.dedicated hosts can help you reduce costs by allowing you to use existing server-bound software licences,including windows server,SQL server and SUse,linux server.    
======================================================
1. Genaral Purpose:A1,T3,T2,M5,M5a,M4,T3a
2. Compute Optimized:C5,C5n,C4
3. Memory Optimized: R5,R5a,R4,X1,X1e,High memory,Z1D
4. Acclerated Computing:P2,P3,G3,F1
5. Storage Optimized: H1,I3,D2
==============================
## Windows server creation ##
aws-->ec2-->launch instance-->ami-->windows server 2019-->choose instance type-->t2.micro-->configure instance-->defult-->add storgae-->default-->security group-->windows-sg-->rds-->port 3389-->next-->select exiting keypair-->review and launch. 

selct windows server-->connect-->rdp client-->get new password-->upload ur key-->decrypt password-->copy the password & dns address and userid(Public DNS
 ec2-3-95-18-1.compute-1.amazonaws.com
User name
 Administrator
Password
 1fwEiuqw&*FOp%53H)b&THesGC4=qt%L)-->username(adminstrator)-->open ur remote desktop-->paste dns url-->connect-->enter credentials-->user name and password-->ok-->yes.
======================================================
## Instance metadat #
#curl http://169.254.169.254/latest/meta-data
here u can see all meta of ur instnce
#curl http://169.254.169.254/latest/meta-data/ami-id
here shows ur ami id
#curl http://169.254.169.254/latest/meta-data/public-ipv4
here shows ur public ip address
===================================================
## Linux basics #
# Linux machines 
1. RPM based                         2. Debain based
-Centos                               -Ubuntu
-RHEL (Redhat Enterpriselinux)
-Amazon linux
#yum update -y                      #apt-get update -y
#yum install httpd -y          #apt-get install apache -y
 
# Security groups #
Setup of firewall rules.
Inbound rules control the incoming traffic to your instance, and outbound rules control the outgoing traffic from your instance.

Aws-ec2-security groups-creare group-->inbound rules-->add-->http-->80-->allow.

# EBS
chekc ur ebs voulume in instance
#lsbls --->here shows all block storage.
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0   8G  0 disk
└─xvda1 202:1    0   8G  0 part    /
# Add somemore ebs volume to ur server
Aws-->ec2-->elastic block storage-->volumes-->create volume-->Volume settings-->Size(3gb)-->Availability Zone-->ur instance avialabilty(east1b)-->create volume.

voluems u can see ur voulme and it's status is avialble it means it is not in use.
## Attach volume to instance
select volume-->actions-->Instance-->choose instance-->Device name-->it's default(/dev/sdf)-->attach.

go back to putty and see ur volumes
# lsblk --> here 2 voulmes root & attached volume
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0   8G  0 disk
└─xvda1 202:1    0   8G  0 part /
xvdf    202:80   0   3G  0 disk
 now check any file systm attached to this volume

# file -s /dev/xvda1 -->root volume hav files
/dev/xvda1: SGI XFS filesystem data (blksz 4096, inosz 512, v2 dirs)

#file -s /dev/xvdf
/dev/xvdf: data -->it means no files 
# mkfs -t ext4 /dev/xvdf
file system is created
# cd /
# mkdir reddi/
# mount dev/xvdf reddi/
#  lsblk
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0   8G  0 disk
└─xvda1 202:1    0   8G  0 part /
xvdf    202:80   0   3G  0 disk /reddi
# cd reddi
# touch file1
#  cd /
# umount dev/xvdf 
mount will be removed
# cd reddi
# ls --> here not shows any files
# lsblk
lsblk
NAME    MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
xvda    202:0    0   8G  0 disk
└─xvda1 202:1    0   8G  0 part /
xvdf    202:80   0   3G  0 disk

goto aws -->volumes-->select volume-->detach.
refresh it then status shows avialble
now backup this-->select this volume-->actions-->create snapshot-->descrption-->new snphshot-->create snapshot(backup).

If u want to increae ur volume then
volumes-->select volume-->actions-->modify-->add size-->create.
## Snapshot #
it backup of ur volume
here u can use this to create volume/image/copy/modify permissions.
1. copy 
select-->snapshot-->actions-->copy-->Destination region-->choose ur destion region-->enacrypt-->copy.
2. Modify permissiions:it helps for share snapshot to other aws accounts.
selct-->snapshot-->actions-->modify permissions-->private-->aws account number-->add permissions-->save
3. Create volume:
select snapshot-->actions-->create volume-->volume type-->genaral purpose ssd-->size(3gb)-->avialability zone(same as instance avblty zone)-->create volume.
============================================
# Boot strap server #
aws-->ec2-->lanuch instance-->name(bootstrap_server)-->ami-->amazon linux-->key pair-->security group with 80 port-->advanced-->user data-->
#!/bin/bash
yum update -y
yum install httpd -y
cd var/www/html
echo "<html><h1>this is bootstarp server<h1><html>">index.html
systemctl start httpd
chconfig httpd on
-->review and lanuch.

then goto google-->publicip-->search-->here shows ur website
=========================================================
## Amazon Machine Image(AMI) ##
it is a template that contains the software configuration like amzn linux,Ubuntu,centos,macos,redhat,suse.

Aws-->lanuch new instance.
now install LAMP stack:linux+apache+mysql+php
1.Security patches
2.Linux server + httpd + php+sdk + php-mysql
login to putty
# sudo su -
# yum update -y
# yum install httpd -y
# yum install php -y
# yum intall php-mysql -y
# php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
# php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
# php composer-setup.php
# php -r "unlink('composer-setup.php');"
# composer require aws/aws-sdk-php
# ls
composer.json  composer.lock composer.phar
========================

Now Take it AMI
goto aws-->select this instance-->actions-->Image and Template-->create image-->Image name(Lamp_stack)-->create image.

See ur ami images:
ec2-->images-->amis-->here u can see ur ami.
selcet ami-->actions-->copy-->choose destination region-->copy ami.
use this ami u can launch,spot requset,deregister,register new ami,copy ami,modify image permissions
======================================================
## Root Device Volumes & EBS vs Instance Store #
1. cannot stop the ec2 instance with instance store volumes(only reboot & terminate)
2. cannot view the volume from AWS store 
3. any data stored on the instance store volume is lost (if m/c is freezed or with problems)
4. instance store volumes are otherwise called as empherel storage
5. EBS volumes are otherwise called as perisistent storage.
# Raid, Volumes & Snapshots
RAID: Redundant array of indepedent disks
 RAID 0: stripped,no redundancy,good performance
 RAID 1: mirrored,redundancy
 RAID 5: good for reads,bad for writes,AWS doesnot recommend ever putting RAID 5's on EBS
 RAID 10: stripped mirroed good redundancy good performance.

Go to AWS
Aws-->ec2-->lanuch instances-->choose ami-->windows 2019-->choose instance-->t2.micro-->next-->add storage-->add new 3 volumes 2gb+2gb+2gb-->next-->review and launch.
selcet instance-->connect-->get password-->key pair path-->browse ur keypair-->decrypt-->copy the dns,userid,password.
open ur remote desktop connection-->paste ur dns-->connect-->enter credentials-->userid-->password-->ok-->yes..
computer management-->c drive-->here u can see 30gb and 2gb,2gb,2gb-->select and right click-->online-->keep 3 volumes in online-->selct right click and initilize it 3volumes-->selct right clck -->new starred volume-->next-->next-->assign the following drive letter-->d-->next-->perform a quick format-->next-->finish.
u cans see top newvolume mounted.