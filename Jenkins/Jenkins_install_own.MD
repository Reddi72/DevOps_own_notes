# Install Jenkins on AWS EC2
### Prerequisites
1. EC2 Instance 
   - With Internet Access
   - Security Group with Port `8080` open for internet
1. Java 11 should be installed  

# install java #
# amazon-linux-extras install java-openjdk11
 
 ### installing the jenkins ##
 goto google---> click on download--> click on centos/fedora/redhat--->paste the above cmnds excute it
 # sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
 # sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
 # yum install jenkins

## start the jenkins ##
# systemctl start jenkins

# Setup Jenkins to start at boot,
   #chkconfig jenkins on
### Accessing Jenkins
   By default jenkins runs at port `8080`, You can access jenkins at
   ```sh
   http://YOUR-SERVER-PUBLIC-IP:8080  --> jenkins gui opened
#### Configure Jenkins
- Grab the default password 
- Password Location:`/var/lib/jenkins/secrets/initialAdminPassword`
-Plugin Installation-->change password and user id.
### configure user credentials of git,tomcat,jfrog...etc
## adding credentils of git/bitbucket
dashboard--manage jenkins--manage credentials--global--user name of git/bitbckt (reddy pradad)--password  (ATBB45ksrHsQPe86C37g87xXUJtH61E8B560)-id (bitbucket)--descreption (bit user/pwd)- create.
## adding credentials of tomcat
dashboard--manage jenkins--manage credentials--global--user name of tomcat (tomcat)--password (12345)-id (tomcat)--descreption (tomcat user/pwd)- create.

=========================================================
### Test Jenkins Jobs
1. Create “new item”
1. Enter an item name – `My-First-Project`
   - Chose `Freestyle` project
1. Under the Build section
	Execute shell: echo "Welcome to Jenkins Demo"
1. Save your job 
1. Build job
1. Check "console output"
=====================================
## jenkins 2nd job maven in free style
 ## installing "copy artificate" plugin
   dashboard--manage jenkins--manage plugins--avilable--search copy artificate--select plugin--install without restart
1. Enter an item name – `My-maven-build`
   - Chose `Freestyle` project
2. under Description
  - this is first java code project
3. under Source Code Management
  - git -->Repository URL--->paste ur java code url from bit bucket/git
4. under Build Steps
  - Execute shell -> command -> /opt/maven/bin/mvn package
5. under post build action
 - archeive the artifactes--files to archeive-- target/*.war
5. apply & save
6. build now
7. Check "console output" war file created
================================================
### jenkins 3rd job-"tomcat deploy job" ##
## installing "deploy to container" plugin
  dashboard--manage jenkins--manage plugins--avilable--search deploy to container--select plugin--install without restart
1. Newitem --1. Enter an item name – `My-tomcat-deploy`
2. under Build Steps
  Copy artifacts from another project--Project name--My-maven-build
3. under Post-build Actions
 Deploy war/ear to a container--WAR/EAR files--**/*.war.
  Containers--Tomcat 8.x Remote--Credentials(select tomcat credentials from dropdown)--Tomcat URL (http://54.242.4.130:8080/)
4. under add post build action
   Build other projects--Projects to build--give tomcat deploy job name(deploy).
5. apply and save
6. Buildnow
 ## "here when the maven artificates created that war automatically copied into tomcat server in webapps folder" ##
=========================================================
## Jenkins 4th webhook job ###

1. Enter an item name – `My-maven-build-webhook`
   - Choose `Freestyle` project
2. under Description
  - this is first java webhook project
3. under Source Code Management
  - git -->Repository URL--->paste ur java code url from bit bucket/git
4. under Build Triggers
  Trigger builds remotely (e.g., from scripts)---Authentication Token--12345--copy the "jenkins url@jenkins user name & password and jobname"(http://jenkins:11262d0a4ae719a783d21c2eb5b951fad9@44.211.75.64:8080/job/first%20build/build?token=123456)

  ## note= "don't give the jenkins login password create token password"
   Jenkins user---drop down select configure--API Token--give the name(webhook_token)--genarate--copy the token (11262d0a4ae719a783d21c2eb5b951fad9).
     # use above token as a jenkins password"
5. goto bitbucket add webhook
    java repo---repository settings--webhook--add webhook--Title*(jenkins_build)--url (give jenkins url is " http://jenkins:11262d0a4ae719a783d21c2eb5b951fad9@44.211.75.64:8080/job/first%20build/build?token=123456")--triggers--tick the push,merge,approve (optional options)--save
6. under Build Steps
  - Execute shell -> command -> /opt/maven/bin/mvn package
7. under post build action
 - archeive the artifactes--files to archeive-- target/*.war
8. under add post build action
   Build other projects--Projects to build--give tomcat deploy job name(deploy).
9. apply & save

10. "do some chages to ur code and push into ur repo"
then it trigggers maven project it runs automatically..when maven job completd immeditely start deploy job automatically.
 ======================================================
 
