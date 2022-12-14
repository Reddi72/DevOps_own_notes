u can setting up the kubernetes by many types.  in that 3tpyes are
1. kops - is recommended to setup on aws
Create bootstrap server
Create IAM Role
Configure Route53
Create Cluster State Storage (S3 Bucket)
Setup SSH Keys
Create cluster configuration
Modify cluster configuration(Optional)
Build cluster
Validate cluster
Delete cluster

2. eksctl
Create bootstrap server
Create IAM Role
Create cluster
Validate cluster
Delete cluster

3. kubeadm- is more convient to setup the cluster in onpremises.
Pre-Requisites
Configure K8s Master(Control Plane)
Enable Services to start after reboot
Start Docker services
Setup K8s Master(Control Plane)
Setup Worker Nodes
Delete cluster.
=======================================
## Installing kops "bootstrap" server ##
#aws --version
Bootstrapping refers to getting the initial cluster up and running. By bootstrapping you are defining which node is has the correct information, that all the other nodes should synchronize to (via SST).

1. Install Kubectl
#curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#chmod +x kubectl
#mv kubectl /usr/local/bin/kubectl
2. Install Kops
#curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
#chmod +x kops
#mv kops /usr/local/bin/kops
================
## Create IAM Role ##
Create IAM Role and attach the role to bootstrap server. IAM Role must have below policies attached.

AmazonEC2FullAccess
AmazonRoute53FullAccess
AmazonS3FullAccess
IAMFullAccess
AmazonVPCFullAccess
AmazonEventBridgeFullAccess
AmazonSQSFullAccess
# goto aws console -- iam-- create role--aws servcie--ec2--next--administrative access--next--role name[kopsrole]--create role.
# goto ec2--select vm--actions--security--modify iam role--choose kopsrole--update role.
Configure Route53
# goto route53--create hostedzone--dptcluster.k8s.local---
Create Cluster State Storage (S3 Bucket)
# goto--s3 bucket--create--bucket name--dptweb4s3--create bucket.

## Setup SSH Keys
goto vm cli-- #ssh-keygen -t rsa.
# Gossip Domain variable setup
#export NAME=dptcluster.k8s.local
#export KOPS_STATE_STORE=s3://dptweb4s3
## command to create cluster configuration
kops create cluster --zones=us-east-1a.us-east-1b,us-east-1c ${NAME}.
 ** ur cluster created. and ur master & wokers nodes have t3.medium configuration by default
 ==========================================
 #cd .kube
 #cat config --- this file have all configuration details
 #kubectl get nodes -- it shows all ur pods
========================================
1. take image from docker hub and create pod
# syntx: kubectl run [pod name] --image=docker image name
#kubectl run web1 --image=prasad72/dpt4web:1.0
    - pod created
#kubectl get pods  --> it shows ur pods
#kubectl get pods -o wide --> it shows more info of pod
#kubectl describe pod web1 --> it shows all info of pod
#kubectl exec -it web1 -- /bin/bash -->goto inside pod
#kubectl delete pod web1
======================================================
## deploying pod through menfest file/yml file ###
#vi pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: login
spec:
  containers:
  - name: login
    image: prasad72/dpt4web:1.0
    ports:
    - containerPort: 80
#kubectl apply -f pod.yaml  --> login pod created
#kubectl delete pod login or #kubectl delete -f pod.yaml
=====================================================
## how pods self healing is done ###
## Replica set:  
        is purpose is maintain a stable set of replica pods running at any given time as such it is ofter used to gurantee the aviablity of a specified number of identical pods..  
it always maintain replicas as ur giving number of replicas with ur lable name..
if in case one pod is deleted then repica set identify and create the another pod with ur existing pod name.
======================================
#replicaset.yaml

apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: login-rs
  
spec:
  # modify replicas according to your case
  replicas: 3
  selector:
    matchLabels:
      app: login-app
  
  template:
    metadata:
      name: login-pod
      labels:
        app: login-app

    spec:
      containers:
      - name: login-container
        image: prasad72/dpt4web:1.0
        ports:
        - containerPort: 80
===============
#kubectl apply -f replicaset.yaml
  --replicaset starts to create 3 pods and creating.
#kubectl get pods --> here shows ur 3 pods
** if in case pod is down/deleted, replica set created quickly another pod
#kubectl delete pod login-rs-4wnd --> delete pod
#kubectl get pods --> here shows 3 pods because of replica set quickly created pod in place of deletd pod
#kubectl get rs --> shows replica sets.
#kubectl describe rs login-rs
 
 #kubectl delete -f replicaset.yaml
========================================================
## Deployment yaml file ###
#vi deployment.yaml

#Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: login-rs

#replicaset controller 
spec:
  replicas: 3
  selector:
    matchLabels:
      app: login-app
#pod
  template:
    metadata:
      name: login-pod
      labels:
        app: login-app
#container
    spec:
      containers:
      - name: login-container
        image: prasad72/dpt4web:1.0
        ports:
        - containerPort: 80

#kubectl apply -f deployment.yaml
#kubectl get depoly -->here shows the deployment contrlr
#kubectl get rs --> here shows replicasets
#kubectl get pods --> here shows pods
=======================================================
### service discovery ###
## deploy node port service ###
kubernetes service act as a loadbalancer to route the traffic to the backend pods. that means some access the ur application that is running on a pod they have to access the application through a service. some one hit on service now the service will listen on specific port number the service will take the request the servcie will be distibuting traffic or forwarding traffic backend of pod.
kubernetes node port range 3000-32768

#nodeport.yaml
apiVersion: v1
kind: Service
metadata:
  name: login-service
  labels:
    app: login-app

spec:
  selector:
    app: login-app

type: NodePort
ports:
- nodePort: 31000
  port: 8080
  targetPort: 8080
==============
goto ur vm and allow the 31000 port 
#kubectl apply -f nodeport.yaml
#kubectl get service -- here shows nodeport with own ip
=========
access the ur application through google 
"anyworker node pubip:31000/dptweb-1.0"
================================================
## Health check of ur pod/app ##
## Liveness & readyness probes ##
readyness check all about checking the health state of pod when it is created.
          once pod is created healthy but one after one 
hour pod is unhealthy then liveness check coming to picture.. it will check the readyness of running pods.
is concept of configureing the health check settings into ur deployment to ensure the pod healthy or not.incase pod is not healthy it replace automatically.
 the deployment will check readiness of newly created pod whenever readiness check success newly created pod then immeditly turned into a healthy then immdtly service takescare routing of that.
if readiness check fail some reason for the newly created pod immdietly the deployment will terminate that pod and newly created another pod.
 
 ## add the readiness and liveness into ur deployment.yaml file under containers ###
 #vi deployment.yaml

 readinessProbe:
   tcpSocket:
     port: 8080
   initialDelaySeconds: 5
   periodSeconds: 10
  livenessProbe:
    tcpSocket:
      port: 8080
    initialDelaySeconds: 15
    periodSeconds: 20
============
#kubectl apply -f deployment.yaml
====================================================
### Name spaces ###
it is a logical separator to deploy ur group of applications in one cluster.
i can create one namespace for dev and one namespace for prod ..etc
if ur not give namespaces during the deploying of ur applications, kubernetes create defalut name spaces.
#kubectl get ns --> here shows ur defult namespaces.1.default 2.kube-node-lease 3.kube-public 4.kube-system
=======================
#vi namespace.yaml
apiVersion: v1
kind: namespace
metadata:
  name: prod

#kubectl apply -f namespace.yaml
#kubectl get ns -->here shows ur prod name space
 
 edit the ur deployment.yaml and add namespace line under name 
 
 #vi deployment.yaml
 apiVersion: v1
kind: namespace
metadata:
  name: login-prod
  namespace: prod  { add this line to ur deploy.yaml}

 
#kubectl apply -f deploy-prod.yaml
#kubectl get pods --> here not show ur prod pods
#kubectl get deploy --> here not show ur deploymnt cntrlr
#kubectl get ns --> here not show ur namespaces

u want see ur pods
#kubectl get pods -n prod --> here shows ur pods
#kubectl get deploy -n prod --> here show ur deploymnt cntrlrs
#kubectl get ns -n prod--> here show ur namespaces
=============================
## Deployment 0f Rolling upgrade & Rolling back ###
 it s service to used for u have to upgrade ur app with ur new versions.. add the ur latest version image in ur deployment file then apply deploy yaml file.. then deployment controller will create the new pods for new version when new pods are pass the livensess and readyness test then older pods are deleted automatically..
 Rolling back is a service  roll the ur app with older versions.. in this case new versions works not expected then roll back to ur older vesrsions..in this add ur old image in ur deploy file and apply that ...then deployment controller deploy older version and deleteing the new versions simutensuly..
=====================================================
## Networiking and Service discovery ####
1. if both containers in same pod both are commumicate though localhost.
2. if two containers in differnt pods one is webapp another sqldatabase,  webapp access to external world through nodeport and database pod coonect webapp by backend thorugh cluster ip.
 when webapp wanted to talk with a database .the webapp will be connecting to the kube-dns cluster ip service to get a resultion then kube-dns have database ip and connected to database.
 
 #kubectl get pods -n kube-system-- here shows ur dns contrller.
 #kubectl get service -n kube-system -> here show dns cluster ip.

 ## cluster ip yaml file ##
 it is a same as a nodeport yaml file just change is replce nodeport with clusterip.
 
 #vi cluster ip.yaml
apiVersion: v1
kind: Service
metadata:
  name: login-service
  labels:
    app: login-app

spec:
  selector:
    app: login-app

type: clusterPort
ports:
-port: 8080
  targetPort: 8080

#kubectl apply -f clusterip.yaml
===============================================
## Load balancer ##
kubernetes have 4 services 1.cluster ip service 2.node port service 3. load balancer servcie 4.External Name Creation service 
 ur deployment file will ensure that aws loadbalncer for u and all the wokers nodes added as a target ,all the health checks are configured in load balancer all the setup will be automatically for u.
    when ur use service load balncer it will do 2 things  for u 1 is it will create balancer for u and also deploy node ports for u.
this load balncer for cloud type infrastruture not suitable for on premise.
API server is responsible to create aws loadbalancer in kubernetes.
#vi loadbalncer.yaml

apiVersion: v1
kind: Service
metadata:
  name: login-service
  labels:
    app: login-app

spec:
  selector:
    app: login-app

type: loadbalancer
ports:
-port: 8080
  targetPort: 8080
====================================================
change ur image and again deploy yaml 
#kubectl apply -f deloyment.yaml
#kubectl apply -f loadbalancer.yaml
===============================================
## Resources ##
1. Cpu represents compute processing and is specified in units of kubernetes cpu's
2. Memory is specified in units of bytes.
lets say i am running a app container my app container atleast require 1gb of ram. if ur container not able supply the 1gb memory for u because not getting memory from host os then ur app can't comeup.
so now little improvements done in deployment yaml file
here say to deployment hey i need 1gb of memory. this type memory allocation add. that is called a adding line is requsets and limits.

vi deployment file.

apiVersion: apps/v1
kind: Deployment
metadata:
  name: login-rs

#replicaset controller 
spec:
  replicas: 3
  selector:
    matchLabels:
      app: login-app
#pod
  template:
    metadata:
      name: login-pod
      labels:
        app: login-app
#container
    spec:
      containers:
      - name: login-container
        image: prasad72/dpt4web:1.0
        resources:
          requests:
            memory: "64Mi"
            cpu: "250m"
        limits:
            memory: "128Mi"
        cpu: "500m"
        readinessProbe:
          tcpSocket:
            port: 8080
          intialDelaySeconds: 5
          periodSeconds: 10
        livenessProbe:
          tcpSocket:
            port: 8080
          intialDelaySeconds: 15
          periodSeconds: 20
-----------------------------------------------
#kubectl apply -f deployment.yaml

## Metric Server ##
You can use Metrics Server for:

CPU/Memory based horizontal autoscaling (learn more about Horizontal Autoscaling)
Automatically adjusting/suggesting resources needed by containers (learn more about Vertical Autoscaling).

u want deploy the metric server by defult thorugh kubernetes docs
#kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

#kubectl top nodes -- here shows u all nodes cpu and memory details 
#kubectl top pod podname --> it shows pod cpu,memory usge

## Horizontal pod auto scaling ##
 HorizontalPodAutoscaler automatically updates a workload resource (such as a Deployment or StatefulSet), with the aim of automatically scaling the workload to match demand.
 Horizontal scaling means that the response to increased load is high  to deploy more Pods.
 If the load decreases, and the number of Pods is above the configured minimum

#vi horizontalpodautoscaling[hpa].yaml

apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: login-deploy
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: login-deploy
  minReplicas: 1
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50

#kubectl apply -f hpa.yaml
============================================
## Config map ## application.properties
ConfigMaps are helpful for storing and sharing non-sensitive, unencrypted configuration data. Like Secrets, you’ll be able to produce config maps from files and with yaml declaration.

#vi configfile.yaml
apiVersion: v1
kind: ConfigMap  
metadata:
  name: app-config 
data:
  application.properties: |
    spring.mvc.view.prefix=/pages/
    spring.mvc.view.suffix=.jsp
    spring.datasource.url = jdbc:mysql://dpt3-rds-01.cikw6aborn1z.us-east-1.rds.amazonaws.com:3306/UserDB
    spring.datasource.username = admin
    spring.datasource.password = admin12345
#kubectl apply -f configfile.yaml
#kubectl get configmap --> here shows ur config map

 add ur config file to ur deployment file at the last of file
 
 volumeMounts:
        - name: app-config
          mountPath: "/etc/config"
          readOnly: true
      volumes:
      - name: app-config
        configMap:
          name: app-config
#kubectl apply -f deploy.yml
#kubectl get pods
#kubectl exec -it podname -- /bin/bash
#ls -l /etc/config --> here shows ur application.properties file -- in this shows u what data add in ur configfile.yaml previsouly
#exit
=========================================================
### Statefull vs stateless apps ###
 1. the stateless sense ur not depending on the pod related data it means maybe ur apache tomcat app is runnig stateless behaviour why incase pod terminated new pod will be created i don't show any issues.
 2. Statefull means ur pod will crashes u will loss a important data if pod wiil be recreated only service will be created not comeback ur data.
 exmple: database app
in this case i will tell to database app hey don't store the data in pod. i give u external volume memory to store the data.
if database pod will terminated i hav't loss the data. and when recreated database pod then i will attach previous volume to pod.then pod have the same data and work from where it stop.
## how to supply this external memory ###
1. persistent volume 2. persistent volume claim
persistent volume means external volume takes from aws/azure..cloud  store the app data.
persistent volume claims measn that persistent volume reback add to ur recreate pod.
Vi pv.yaml
# PV
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: aws-ebs-pv
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  zones: us-east-1a
#kubectl apply -f pv.yaml --> pv created

vi pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: login-pvc
spec:
  storageClassName: aws-ebs-pv
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 7Gi
#kubectl apply -f pvc.yaml
#kubectl get pvc --> shows ur pvc

## u can see the pvc volume in ur aws in ebs volume.
now this pvc add to pod .. ur pod tell hey here pvc created use it for store the data.

vi pvc deploy.yaml
add this lines to ur deploy file at the last
volumeMounts:
        - name: pvc-storage
          mountPath: "/mnt"
          readOnly: true
      volumes:pvc-storage
      - name: 
        perisistentVolumeClaim:
          claimname: login-pvc
#kubectl apply -f pvc deploy.yaml
#kubectl get pods --> here pvcdeploy pod
#kubectl exec -it pvcdeploypod -- /bin/bash
#df -h --> here shows /mnt file
===========================================
## Logging ##
all pods create a logs. i want see all pod logs at one place.by useing fluntee u cam do this
fluntd:is the application which is responsible to collecting the log data of running pods on specific worker nodes.and store it in elasticsearch database
flunted deploy in all pods..
1. kibana:popular application which is well intregated to elasticeserach databases.. 
kibana responsible in collecting the data stored in elasticserach database and that data will be shows in beautyfull graphical presentation.
u want see the logging informstion then no need to run cmnds on node .. goto kibana dashboard in this dashboard u can all loggig data of all pods running cluster.is called as centralized logging system.
flunted deployed as a deamon set.
Deamon set: all about make sure that pod is running in each worked nodes in each worked nodes it will create.

#vi flunted config.yaml
#kubectl apply -f flunted config.yaml
#kubectl get configmap -n kube-system --> here shows ur cnfig map
#vi elastic-stack.yaml
#kubectl apply -f elastic-stack.yaml
#kubectl get service -n kube-system  -> here shows ur kibana as a loadbamcer and elastic stack as a service

kibana as a loadbalancer u can access it 
aws --> loadbalancer-->copy the dns-->goto route53--hosted zone-->craete record-->give record name kibana-->value--here copy ur dns-->create record--
now acces ur kibana --kibanakloude.com--here shows ur kibana database.
u want see ur data -- kibana--discover--u can see table where ur data stored--copy it paste at index--see ur data now.

### Monitoring ##
monitor the ur pod useing grafana tool.install the grafana app as a pod monitor the real traffic of ur netowrks of ur pods. but grafana not collecting data it is just show the ur data in garph.
so u can use another tool for collecting the data that is promotheus app.
promotheus tool responsible in collecting the live data and store the data in promotheus database.
## promotheus and elastic search both are can do same work ##
but in real time most favrble combination is promotheus and grafana.
# git https://github.com/prometheus-operator/kube-prometheus.git
download the manifest file from kubernetes offical github account.
#cd manfest  #cd promotheus-grafana-stack
#cd manifests
u can insatll first setup  yaml files these are prerequsties.
 #cd setup
#kubectl apply -f .
#cd ../  [come back to manifests]
#kubectl apply -f .
all are insatlled
#kubectl get pods -n monitoring
here u can see grafana and promotheus pods
#kubectl get services -n monitoring

grafana port number is 3000
## Ingress controller ##
it routes the traffic of all  kibana and grafan pods in one cluster by useing one aws loadbalancer
ingress is b/w loadbalncer and clustr  kibana,grafana pods 
#vi ingress_cotroller.yaml
#kubectl apply -f ingress_cotroller.yaml


