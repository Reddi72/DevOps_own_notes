1. pull the default tomcat image from docker hub
 if u want specific version mention version like tomcat:8.5
2. copy the .war to webapps
 
 ## docker file  for customized own image##
FROM tomcat:8.5
COPY ./javarepo/targets/dpt-web.war /usr/local/tomcat/webapps
=======================================================
## docker file build #
#docker build -t prasad72/dptdevimge:1.0 .
   here -t=tag prasad72=dockerhub id dptdev:1.0=version 
   . = present working directory (where dockerfile is present)
========================================================
## pushing ur customized own image to ur dockerhub registory##
#docker login
  userid=prasad72  password=pras@1993
##docker push prasad72/dptweb:1.0
=========================================================
## pull the ur customized own image ur app sever ##
#docker pull prasad72/dptweb:1.0
#docker run --name dev-web -d -p 8080:8080 prasad72/dptweb:1.0
#docker exec -it container id /bin/bash
#ls 
   here u can see 2 webapps folders 1.webapps 2.webapps.dist
1.webapps= in this only have war file
2.webapps.dist= have "docs  examples  host-manager manager  ROOT"
##copy the war file into webapps.dist and then rename as a webapps.
#cp -pr webapps/* webapps.dist/
#rm -rf webapps
#mv webapps.dist webapps
=========================================================
## acces ur app through web/end user
pubip:8080/dptweb-1.0
========================================================
## In your container some comnds not work like vi ,netstat tuplan.. so u can write ur docker file #3
1. find ur container os
 #docker exec -it 0d8021217d8 /bin/bash
 #cat /etc/issue
   here shows ur os name "Ubuntu 22.04.1 LTS \n \l "
=========================================================
## i want to  run my container on amazon-linux ##
 1. pull the amazonlinux image form docker hub
 2. working directory - /opt
 3. download apache tomcat 8.5
 4. install unzip
 5. install vim
 6. extract tomcat -unzip
 7. rename the tomcat
 8. excutions permissions to bin folder
 9. install java-openjdk11
 10. copy .war to /opt/tomcat/webapps
 11. start the tomcat service 
 ========================================================
 #vi Dockerfile
  FROM amazonlinux
  WORKDIR /opt
  ADD https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.82/bin/apache-tomcat-8.5.82-windows-x64.zip /opt/
  RUN yum install unzip -y
  RUN yum install vim -y
  RUN unzip apache-tomcat-8.5.82-windows-x64.zip
  RUN chmod +x /opt/apache-tomcat-8.5.82/bin/*
  RUN amazon-linux-extras install java-openjdk11 -y
  COPY ./java/target/dptweb-2.0.war /opt/apache-tomcat-8.5.82/webapps
  CMD  ["/opt/apache-tomcat-8.5.82/bin/catalina.sh","run"]
=========================================================
## Docker file commands ##

# FROM
FROM instruction used to specify the valid docker image name. So specified Docker Image will be downloaded from docker hub registry if it is not exists locally.

Examples:
from docker.io/centos:latest
from docker.io/centos:6
If tag “6” is not specfied, FROM instruction will use the latest tag (version).

# MAINTAINER
MAINTAINER instruction is used to specify about the author who creates this new docker image for the support.
Examples:
maintainer administrator
maintainer admin @ learnitguide.net
maintainer devops engineer(admin @ learnitguide.net)

# LABEL
LABEL instruction is used to specify metadata informations to an image. A LABEL is a key-value  pair.
Examples:
label “application_environment”=”development”
label “application_support”=”learnitguide.net group”
  
# EXPOSE
EXPOSE instruction is used to inform about the network ports that the container listens on runtime. Docker uses this information to interconnect containers using links and to set up port redirection on docker host system.

Examples:
expose 80 443
expose 80/tcp 8080/udp

# ADD
ADD instruction is used to copy files, directories and remote URL files to the destination (docker container) within the filesystem of the Docker Images. Add instruction also has two forms – Shell Form and Executable Form.
Examples:
Shell Form – ADD src dest
add /root/testfile /data/
Executable Form – ADD [“src”,”dest”]
add /root/testfile /data/
If the “src” argument is a compressed file (tar, gzip, bzip2, etc) then it will extract at the specified “dest” in the container’s filesystem.

# COPY
COPY instruction is used to copy files, directories and remote URL files to the destination within the filesystem of the Docker Images. COPY instruction also has two forms – Shell Form and Executable Form.

Examples:
Shell Form
copy src dest
copy /root/testfile /data/

Executable Form
copy [“src”,”dest”]
copy /root/testfile /data/
If the “src” argument is a compressed file (tar, gzip, bzip2, etc), then it will copy exactly as a compressed file and will not extract.

# RUN
RUN instruction is used to executes any commands on top of the current image and this will create a new layer. RUN instruction has two forms – Shell Form and Executable Form.

Examples:
Shell form:
run yum update
run systemctl start httpd

Executable form:
run [“yum”,”update”]
run [“systemctl”,”start”,”httpd”]

# CMD
CMD instruction is used to set a command to be executed when running a container. There must be only one CMD in a Dockerfile. If more than one CMD is listed, only the last CMD takes effect.
CMD instruction has two forms – Shell Form and Executable Form.

Example :
Shell form:
cmd ping google.com
cmd python myapplication.py

Executable form:
cmd [“ping”,”google.com”]
cmd [“python”,”myapplication.py”]

# ENTRYPOINT
ENTRYPOINT instruction is used to configure and run a container as an executable. ENTRYPOINT instruction also has two forms – Shell Form and Executable Form.

Examples:
Shell form:
entrypoint ping google.com
entrypoint python myapplication.py

Executable form:-
entrypoint [“ping”,”google.com”]
entrypoint [“python”,”myapplication.py”]

If user specifies any arguments (commands) at the end of “docker run” command, the specified commands override the default in CMD instruction, But ENTRYPOINT instruction are not overwritten by the docker run command and ENTRYPOINT instruction will run as it is.

So Docker CMD and ENTRYPOINT commands are used for same purpose, but both has some different functionality, refer this link to understand the differences between Docker CMD and ENTRYPOINT Command with examples.

# VOLUME
VOLUME instruction is used to create or mount a volume to the docker container from the docker host filesystem.

Examples:
volume /data
volume /appdata:/appdata

# USER
USER instruction is used to set the username,group name, UID and GID for running subsequent commands. Else root user will be used.

Examples:
user webadmin
user webadmin:webgroup
user 1008
user 1008:1200

# WORKDIR
WORKDIR instruction is used to set the working directory.

Examples:
workdir /app/
workdir /java_dst/

# ENV
ENV instruction is used to set environment variables with key and value. Lets say, we want to set variables APP_DIR and app_version with the values /data and 2.0 respectively. These variables will be set during the image build also available after the container launched.

Examples:
env app_dir /data/
env app_version 2.0

# ARG
ARG instruction is also used to set environment variables with key and value, but this variables will set only during the image build not on the container.

Examples:
arg tmp_name mycustom_image
arg tmp_ver 2.0

So both Docker ENV and ARG commands are used to set environment variables, but there are some differences in functionality, refer this link to understand the differences between Docker ENV and ARG Command with examples.

# ONBUILD
ONBUILD instruction is used to specify a command that runs when the image in the Dockerfile is used as a base image for another image.

Examples:
onbuild add . /app/data
onbuild run yum install httpd


