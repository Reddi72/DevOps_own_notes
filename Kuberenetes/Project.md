## kubernetes project ####
it starts from docker image ready.
 ## Sts [shippment tracking system] project
 the project goal is has to provide location of shippment to my users. they will get location details of the where is delivery,current location
# Micro service deployment - planing #
goal is users should be able to track the shipment vechile with location history and speed of the vechile.
i want to deploy as a microserices so i will tell to my developer hey write the code for microservcies the developer split into different modules.
1. Position stimulator: is for sending a location.
every have gps locator its tracking the vechile location latitude and longitude 
2. Position tracker: for hisort and calculateing the speed of vechile
3. store history: save history in data base
4. Expose position tracking app
5. Web application: fronted app for it shows the beatyfull interface like map and vechile logo, moving vechile ..so on
=====================================================
1. Position stimulator: developer write the for this micro service and keep the code in bitbucket.i am clone the  code and build the war file by useing maven and check the code through sonarcube pushed the artifact to jfrog artifactory and create the default container and edit and copy that war file container build the image and that image pushed into dockerhub. then create a pod by useing that image by useing kubernetes
2. Position tracker: developer write the code and that will be in different bitbucket repo take the code prepare a artifact and create a docker image and pushed into dockerhub and deploy it as position traker as pod in kubernetes.
3. history storage: here i am take the mysql db for store the history. developer decided which db used for it and write teh code for that.

if in case stimulator send the data every 5 seconds but position tracker not recive the data speedly in that case we loss the some data so rectify it data lossing useing Active MQ
4. Active MQ: is for takeing the data from the sender keeping the data in que and that way all the data send by sender will be avialble in the mq msg que when consumer is ready that time consumer go and take the data one by one to starting the processing.
5. APi gateway: is like ngnix.highlevel proxy solution.to route traffic to backend.
6. webapp: final app interface.
======================================================
Deployment: here u can write manfest file for kubernetes and here u can discuss with ur manager to how many replicas in each service.
 Position stimulator--->Active mq--->Position tracker---->mysql db-->api gateway---->webapp--->load balncer--->user interface.
 ======================================================
 go to docker hub-- take the images -- create a pods

 1.  Deploy "active mq" micro service
 #vi mq.yaml
 apiVersion: apps/v1
kind: Deployment
metadata:
  name: queue
  labels:
    app: queue
spec:
  replicas: 1
  selector:
    matchLabels:
      app: queue
  template:
    metadata:
      labels:
        app: queue
    spec:
      containers:
      - name: sts-queue
        image: dpthub/sts-queue
        ports:
        - containerPort: 8161
        env:
        - name: SPRING_PROFILES_ACTIVE
          value: production-microservice
        imagePullPolicy: Always

#kubectl apply -f mq.yaml
#kubectl get pods --> mq pod is ready

#vi mq-service.yaml (nodeport service)
kind: Service
apiVersion: v1
metadata:
  name: sts-queue
spec:
  selector:
    app: queue
  ports:
  - name: console
    port: 8161
    targetPort: 8161
    nodePort: 30010

  - name: endpoint
    port: 61616
  type: NodePort

#kubectl apply mq-service.yaml
#kubectl get services --> sts service is ready
 now acces ur mq service tthrough internet with ur" ip:30010"
now open mq db enter used id admin password admin

2. Deploy "Position stimulator"

vi position-stimltr.yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: simulator
  labels:
    app: simulator
spec:
  replicas: 1
  selector:
    matchLabels:
      app: simulator
  template:
    metadata:
       labels:
         app: simulator
    spec:
      containers:
      - name: sts-position-simulator
        image: dpthub/sts-position-simulator
        env:
        - name: SPRING_PROFILES_ACTIVE
          value: production-microservice
        imagePullPolicy: Always

#kubectl apply -f position-stimltr.yaml
#kubectl get pods --> ur stimultr is ready

# now refresh the ur mq page u can see one que.. here stimulator connect to mq service ##

3. Deploying "mangodb" and "mangodb service" also
#vi mangodb.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongodb
  labels:
    app: mongodb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
      - name: sts-mongodb
        image: dpthub/sts-mongo
        imagePullPolicy: Always

#kubectl apply -f mangodb.yaml
#kubectl get pods --> mangodb is ready

#vi mangodb-service.yaml
kind: Service
apiVersion: v1
metadata:
  name: sts-mongodb
spec:
  selector:
    app: mongodb
  ports:
  - name: mongoport
    port: 27017
  type: ClusterIP

#kubectl apply -f mangodb-service.yaml
#kubectl get services --> db service is ready

4. # Deploying "position tracker" pod ##
vi pstion-trck.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tracker
  labels:
    app: tracker
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tracker
  template:
    metadata:
      labels:
        app: tracker
    spec:
      containers:
      - name: sts-position-tracker
        image: dpthub/sts-position-tracker
        env:
        - name: SPRING_PROFILES_ACTIVE
          value: production-microservice
        imagePullPolicy: Always

#kubectl apply -f pstion-trck.yaml
#kubectl get pods --> here shows position trcker pod

5. ## Deploying position-tracker.yaml Service ###
vi position-trcker.yaml
kind: Service
apiVersion: v1
metadata:
  name: sts-position-tracker
spec:
  selector:
    app: tracker
  ports:
  - name: http
    port: 8080
  type: ClusterIP

#kubectl apply -f position-trckr.yaml
#kubectl get services --> shows position trcker service

refresh ur web page then u can see number of consumers 1
## Deploying Api Gateway ###
#vi Api-gateway.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-gateway
  labels:
    app: api-gateway
spec:
  replicas: 1
  selector:
    matchLabels:
      app: api-gateway
  template:
    metadata:
      labels:
        app: api-gateway
    spec:
      containers:
      - name: sts-api-gateway
        image: dpthub/sts-api-gateway
        env:
        - name: SPRING_PROFILES_ACTIVE
          value: production-microservice
        imagePullPolicy: Always

#kubectl apply -f Api-gateway.yaml
#kubectl get pods --> ur gateway pod

## Deploying Api-gateway Service ##
vi Api-gatwy-Servce.yaml
kind: Service
apiVersion: v1
metadata:
  name: sts-api-gateway
spec:
  selector:
    app: api-gateway
  ports:
  - name: http
    port: 8080
  type: ClusterIP

#kubectl apply -f Api-gatwy-Servce.yaml
#kubectl get services --> see api-gt-servs 

## Deploying Webapp pod ##
vi webapp.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
  labels:
    app: webapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
      - name: sts-webapp
        image: dpthub/sts-webapp-angular
        env:
        - name: SPRING_PROFILES_ACTIVE
          value: production-microservice
        imagePullPolicy: Always

#kubectl apply -f webapp.yaml
#kubectl get pods --> here webapp pod
## Deploying webapp-service ##
vi webap-service.yaml
kind: Service
apiVersion: v1
metadata:
  name: sts-webapp
spec:
  selector:
    app: webapp
  ports:
  - nodePort: 31000
    port: 80
    targetPort: 80
  type: LoadBalancer

#kubectl apply -f webapp-service.yaml
#kubectl get services -->see webapp service
webapp service deploy as a loadbalacner then copy the loadbalancer end point add to ur route53.
route53--creata record--record [sts]--values--copy ur loadbalncer end point--create record.

Now entire web application is ready to acceble.
==================================================
 all details which service connect with which service write by developer in properties file.

 ## prblms occuring above deployments ##
 1. all the vechile history stored in mango db
 in case mango db pod deleted. the pod recreated because u give replica 1 but here prblm is when pod deleted previous history also deleted. so here we loss the vechile history data.
     here understand about statefull behavior of the application and that is where u can see the pv and pvc concept.
for ur mangodb supply the pv and pvc concept to store the data externally then the mangodb pod recreated u don't see any data loss of previosly created history.
## createing pv and pvc ##
vi pv.yaml
# Persistent Volume Claims
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: sts-mongo-pvc
spec:
  storageClassName: sts-aws-gp2
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
---
# Persistent Volume
#vi pv.yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: sts-aws-gp2
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  zones: us-east-1a

#kubectl apply -f pv.yaml
#kubectl get pvc --> see ur pvc here

Now use this pv for my mangodb
i modify my mangodb.yaml file 
vi mangodb.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongodb
  labels:
    app: mongodb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
      - name: sts-mongodb
        image: iwayqdockertest/sts-mongo
        imagePullPolicy: Always
        volumeMounts:
          - name: mongo-persistent-storage
            mountPath: /data/db
      volumes:
        - name: mongo-persistent-storage
          # pointer to the configuration of HOW we want the mount to be implemented
          persistentVolumeClaim:
            claimName: sts-mongo-pvc

#kubectl apply -f mangodb.yaml




