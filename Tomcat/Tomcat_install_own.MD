# Tomcat installation on EC2 instance #
### Pre-requisites
1. EC2 instance with Java 11
### Install Apache Tomcat
goto google  search apapche tomcat-->select version of tomcat
# cd /opt/
# wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.82/bin/apache-tomcat-8.5.82-windows-x64.zip
# unzip apache-tomcat-8.5.82-windows-x64.zip
succesfully tomcat installed

2. give executing permissions to startup.sh and shutdown.sh which are under bin. 
   ```sh
# chmod +x /opt/apache-tomcat-<version>/bin/startup.sh 
# chmod +x /opt/apache-tomcat-<version>/bin/shutdown.sh

3. start tomcat 
# cd /opt/apache-tomcat-8.5.82/bin
   ./startup.sh
   
 3. 1= if u want start/stop the tomcat any where in ur server
 # ln -s /opt/apache-tomcat-8.5.82/bin/startup.sh /usr/bin/tomcatup
# ln -s /opt/apache-tomcat-8.5.82/bin/shutdown.sh /usr/bin/tomcatdown
now u can simply start/stop tomcat any where through #tomcatup #tomcatdown

4. give security group permission to 8080 port
 goto AWS console -->
select server-->got security groups-->edit inbound rules-->add port 8080 

5. access tomcat application from browser on port 8080
 goto google "tomcatserver ip:8080"--> tomcat gui opened
 ## stop tomact service ##
 # ./shutdown.sh
 ========*=======
 
 ###changeing the port of tomcat if jenkins and tomcat in same server
 ## NOTE= Using unique ports for each application is a best practice in an environment. But tomcat and Jenkins runs on ports number 8080. Hence lets change tomcat port number to 8090. Change port number in conf/server.xml file under tomcat home
   ```sh
 cd /opt/apache-tomcat-<version>/conf
# update port number in the "connecter port" field in server.xml
# restart tomcat after configuration update
 ===============================================
 5. ## access the tomcat through browser u can do some changes ###
   # /opt/tomcat/webapps/host-manager/META-INF/context.xml
delete some data last 2 lines to 5 lines from context.xml
keep at the only these 2 lines 
<Context antiResourceLocking="false" privileged="true" >
</Context>
# /opt/tomcat/webapps/manager/META-INF/context.xml
delete some data last 2 lines to 5 lines from context.xml
keep at the only these 2 lines 
<Context antiResourceLocking="false" privileged="true" >
</Context>
   
# Restart tomcat services
   tomcatdown  
   tomcatup
   ```
1. Update users information in the tomcat-users.xml file
goto tomcat home directory and Add below users to conf/tomcat-users.xml file
   ```sh
	<role rolename="manager-gui"/>
	<role rolename="manager-script"/>
	<role rolename="manager-jmx"/>
	<role rolename="manager-status"/>
	<user username="admin" password="admin" roles="manager-gui, manager-script, manager-jmx, manager-status"/>
	<user username="deployer" password="deployer" roles="manager-script"/>
	<user username="tomcat" password="s3cret" roles="manager-gui"/>
   ```
1. Restart serivce and try to login to tomcat application from the browser. This time it should be Successful

 
 1. copy the artificates from jfrog artifactory paste into webapps
 # cd /opt/apache-tomcat-8.5.82/webapps
 # https://reddi.jfrog.io/artifactory/default-libs-release-local/com/devopsrealtime/dptweb/1.0/dptweb-1.0.war
  war file successfully paste into ur webapps

 2. goto google "Tomcatip:8080/dptweb-1.0/"
  ur application will be run
