## Docker is the container engine that handles create,manage container 
docker engine is an open source conterinization technology for building and containerzation ur appliplications.
#### installing docker ###
#amazon-linux-extras install docker
#cd /var/lib/docker/
#service docker start
#service docker status
=========================
## install default images from dockerhub ##
goto docker hub--search for which u want image
# docker pull tomcat
    tomcat image downloaded
# docker images
  here shows ur docker name and docker image id
# docker container creation
 #docker run -d  --name appcon tomcat
 #docker ps
    here shows ur container id and name
# going inside into container ##
#docker exec -it cd379e038fd9 /bin/bash
# coming back from container 
 #exit
# create ur own continer/image by useing default image
 1. create the artificates by using maven and that war file copied into tomcat contaner 
 2. #cd javarepo/targets
 3. #docker cp dptweb-2.0.war cd379e038fd9:/usr/local/tomcat/webapps
 4. check the war file copied or not 
   #docker exec cd379e038fd9 ls -l /usr/local/tomcat/webapps
 5. docker exec -it cd379e038fd9 /bin/bash
============================================
 ## pushing the image to docker hub ## give ur docker id prasad72
 #docker commit cd379e038fd9 prasad72/dptweb:1.0
 #docker images 
 --here shows ur new image "prasad72/dptweb"
 # configureing docker hub to ur vm ##
 #docker login
  Username: prasad72 password:pras@1993
 #docker push prasad72/dptweb:1.0
     --ur images sucessfully pushed into docker hub
## note= when ur developer edit code then u agian build and copy war into tomcat container and again push an image to docker hub as version 3
====================================================
## deploy this image in build server ##
1. install docker and java
 goto docker hub copy the ur cutmzed image previsuly pushed into docker hub
#docker pull prasad72/dptweb:1.0
#docker run --name dev-web -d -p 8080:8080 prasad72/dptweb:1.0 (this is dev env)
 access the app "build server pubip:8080:dpt-web-1
=================================================
#docker build -t prasad72/amzntom_1.0 .
#docker run --name web1 -d dpteb
## docker port mapping ##
#docker run --name amzntom -d --port 8080:8080 prasad72/amzntom_1.0
#docker logs
#docker inspect 12cec385fc97
## deleteing images and containers ##
#docker rm containerid  --for delete container
#docker rmi imageid    -- for delete

## challanges of container
1. what will when container dies
2. what will happen when container crashed
3. how to scale compute resourses
4. what will happen when host os dies

## container orchestrtion tool ##
1. docker swarm
2. kubernetes
3. mesos
                         acting as a like management
 tool to manage a containers being a  created by the docker.it monitor,auto scaleing,auto loadbalancer the ur contaieners.
orchestrtion tool can't create a continers it acts as a manager will take decisions what to be done, why to be done why where to done ,how ensure ny applications run healthy.
1. provisoning and deployment of containers
2. rededuncy & avalibilty of containers
3. scale compute resources across host os
4. service discovery using load balancer service 
5. health check monitoring containers and hosts
6. networking between containers.
## Pattern of orchastration tool ##
virtual machine--host os [linux]--docker engine--container orchastration tool--containers..
