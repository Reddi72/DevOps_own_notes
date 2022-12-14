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