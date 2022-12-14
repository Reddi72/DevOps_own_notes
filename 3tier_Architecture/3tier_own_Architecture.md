1. web proxy (nginx)
2. app server (tomcat)
3. data base (sql by aws rds)
### Creating database in "Amazon RDS" service"
  For your Amazon RDS for MySQL and PostgreSQL workloads,  get read scalability with two readable standby DB instances by deploying the Multi-AZ DB cluster.
    1. create database
         Standard create-->
    2. Engine options
         --my sql--select version of sql--8
    3. Template
           ---free tier
    4.Availability and durability
         --choose availability
    5.Settings
         DB instance identifier--database (mydatabase)
    4.Credentials Settings
         -Master username--(admin)--Master password(pras12345)---Confirm password (pras12345)
    5.Instance configuration 
       -DB instance class--choose db instance type--Burstable classes (includes t classes)--db.t3.micro.
    6.Storage
       Storage type--choose storage type--drop down.
       Allocated storage--choose how much storage u need ---20gb
    7.Storage autoscaling
       tick the --Enable storage autoscaling.
       Maximum storage threshold--choose--like 1000
    8.Connectivity
       Compute resource-- 
       Virtual private cloud (VPC)--
       DB Subnet group-- private  subnet
       Public access--- no
       VPC security group (firewall) -- create new 
       Availability Zone-
    9.Additional configuration
        Database port--3306
    10.Database authentication
       Password authentication
    11. create database..
    =======================================
## instal mysql gui client tool ##
  install -- my sql workbench--install in ur local
   open workbench---click on + symbol--hostname (copy paste ur dbs endpoin (mydatabase.cqrfexrsg2xc.us-east-1.rds.amazonaws.com)).
   connection---give any name (mydb1)--save..
   ============================================
## configure the database to ur resources###
1. #clone the java repo
2. #cd /java/src/main/resources
3. #vi application.properties
4. at spring.datasource.url= jdbc:mysql:// (here give ur database end point)mydatabase.cqrfexrsg2xc.us-east-1.rds.amazonaws.com
5. give database userid and password
   spring.datasource.username = admin
spring.datasource.password = pras12345
6.save :wq
================================================
## push the changes into java repo ##
  git add .
  git commit -m "add sourcefile"
  git push origin master
=======================
we already webhook to our build so it's automatically start build and deploy.