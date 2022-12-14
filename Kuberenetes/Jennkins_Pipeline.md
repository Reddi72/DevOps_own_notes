## Jenkins Continous Integration ##
 git push----bitbucket---maven build---qulity check sonarqube---artifacts store jfrog artifactory---create custmized docker image useing artifact(docker)----push image to docker hub---create helm useing docker image----store the helm chart into jfrog
=============================================
## enkins ci lab ##
Jenkins Required Packages.
1. java-openjdk11
2. Jenkins
3. git
4. Maven
5. Docker
6. Kubectl
7. Helm
## Reqiure other services ##
Bit bucket-- Source code 
Sonarqube-- code quality checks
Jfrog artifactory-- store the artifactory
Docker hub--docker images stores
K8 api server--- for kubernetes cluster
## Authentication Require ##
Bitbucket
Sonar token
jfrog logins
Dockerhub logins
Kubeconfig
sudo access to jenkins users
Grant Permittions to jenkins user to run Docker -- add jenkins user to docker group
# Plugins 
jfrog
sonar
docker
maven
credentials binding
==================================================================================================================
### jenkins setup ##
#amazon-linux-extras install java-openjdk11=latest
#wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
#rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#yum install jenkins
#systemctl start jenkins
#chconfig jenkins on

goto google-- jenkinspubip:8080--open ur jenkins gui
---enter jenkins pwd--
#cat /var/lib/jenkins/InitialadminPassword

## installing maven ##
#cd /opt
#wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip
#unzip apache-maven-3.8.6-bin.zip
## install Docker ##
#yum install docker
#service start docker
## install kubectl ##
#curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#chmod +x kubectl
#mv kubectl /usr/local/bin
## installing helm ##
#wget https://get.helm.sh/helm-v3.10.0-linux-amd64.tar.gz
#gunzip  helm-v3.10.0-linux-amd64.tar.gz
#tar xvf helm-v3.10.0-linux-amd64.tar.gz
#cd linux-amd64
#ls -la
#helm version
## installing push artifctory plugin
#$ helm plugin install https://github.com/belitre/helm-push-artifactory-plugin --version v0.3.0
Downloading and installing helm-push-artifactory v0.3.0 ...
https://github.com/belitre/helm-push-artifactory-plugin/releases/download/v0.3.0/helm-push-artifactory_v0.3.0_darwin_amd64.tar.gz
Installed plugin: push-artifactory
## Authentcation ##

