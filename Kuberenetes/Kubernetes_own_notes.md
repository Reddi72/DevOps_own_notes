## Kubernetes ##
 is a portable,extensible,open source platform for manageing containerized workloads and services that facilities both declarative configuration and automation
 ## Kubernetes Architecture ##
 There are two types of node in each Kubernetes cluster:

### 1. Master node(s):hosts the Kubernetes control plane components and manages the cluster
Kubernetes Master
## ETCD:
 is a distributed reliable key-value store used by
Kubernetes to store all data used to manage the cluster. 
• When you have multiple nodes and multiple masters in 
your cluster, etcd stores all that information on all the 
nodes in the cluster in a distributed manner. 
• ETCD is responsible for implementing locks within the 
cluster to ensure there are no conflicts between the 
Masters 
Scheduler
## The scheduler 
is responsible for distributing work or containers across multiple 
nodes. 
• It looks for newly created containers and assigns them to Nodes
## API server manager:
Masters communicate with the rest of the cluster through 
the kube-apiserver, the main access point to the control 
plane.
## Controller manager:
They are responsible for noticing and responding when nodes, containers or endpoints goes down. 
The controllers makes decisions to bring up new containers in such cases. 
• The kube-controller-manager runs control loops that manage the state of the cluster by checking if 
the required deployments, replicas, and nodes are running in the cluster
## Kubectl
kubectl is the command line utility using which we can 
interact with k8s cluster
• Uses APIs provided by API server to interact.
• Also known as the kube command line tool or kubectl or 
kube control.
• Used to deploy and manage applications on a Kubernetes

### 2. Worker node(s): runs your containerized applications 
## Kubelet
• Worker nodes have the kubelet agent that is responsible for 
interacting with the master to provide health information of 
the worker node
• To carry out actions requested by the master on the worker 
nodes.
## Kube proxy
The kube-proxy is responsible for ensuring network traffic is routed properly to internal and external 
services as required and is based on the rules defined by network policies in kube-controller-manager 
and other custom controllers.

 ## Process in kubernetes= 
    through kubelet is send command line to create a pod--->it's will goto api and api tell to scheduler create a pod so schedulr will decide on which node should create that pod. where ever suffcient resources avialable it will go and deploy that particular pod specific node.
## if container crash or ur work node down then control manager notify that and tell to api, api tell to scheduler .scheduler checks the which woker node is good to recreate that crshed container.
## If manager node crashes or down or not avialble for some resaons worker node contuned to work there is no issue.ur business operations not down. 
only prblm is if want to  new application deployment can't do because api server not avialble or if something happens to ur containers one of that one container down or worker node down .it can't be recreate automatically becasue master is not avialble.
 here existing application runs as long as run there is no issue.
## uses of kubernetes ###
1. Automated container deployments with scaling load,load balncing,high availability capabilities.
2. Automated application deployments
3. service discovery and load balanceing
4. automated rollouts and rollbacks
5. selfhealing
6. secret and configuraation management.

## kubernetes components ##
## What is Kubectl?
Kubectl is a CLI (command-line interface) that is used to run commands against Kubernetes clusters. As such, it controls the Kubernetes cluster manager through different create and manage commands on the Kubernetes component

1. # kube-cotrollers #
 each controller is a separate process but to reduce complexity they are all compiled into a single binary and in a singel process

2. # Node controller #
 responsible for noticing and responding when nodes go down.

3. # Replication controller #
 is responsible for maintaing the correct number of pods for every replicaton controller object in the system.

4. # End points controller # 
populates the end points object that is joins services and pods.
5. # Service account & token controllers#
 create default accounts and API access tokens for new namespaces.

6. # Kube-api server #
 is a component of the kuberntes control plane that expose the kubernetes api.the api server is the front end for the kubernetes control plane.
this is designed to scale horizotally that is scale by deploying more instances.

7. # Kubelet #
 an agent that runs each node in the cluster it makes sure that containers are running in a pod.

8. # kube-proxy #
is a network proxy that runs on each node in your cluster.it maintains network rules on nodes .these network rules allow network communication to your pods from network sessions inside or outside of your cluster.

9. # Pods #
 is a basically scheduling unit in the kubernetes.wraper on the contianer.it is a basic excution unit of microservice application.
Pod characterstics= containers with in a pod share an ip address and port space and  can find each trough localhsot.
          usually a single pod contains only one container.but pod can have multiple containers when those are having dependcy each other to run.

10. # Kube-scheduler # 
control plane component that watches for newly created pods with no assigned node and selects a node for these run on.

11. # Etcd # 
consistent and highly-avialable key value store used as kubernetes backing store for all cluster data . if ur kubernetes cluster uses etcd as it's backing store make sure you have a backup plan for those data.

12. # REPLICASET #
 is purpose is maintain a stable set of replica pods running at any given time as such it is ofter used to gurantee the aviablity of a specified number of identical pods..  
it always maintain replicas as ur giving number of replicas with ur lable name..
if in case one pod is deleted then repica set identify and create the another pod with ur existing pod name

### Name spaces ###
it is a logical separator to deploy ur group of applications in one cluster.
i can create one namespace for dev and one namespace for prod ..etc
if ur not give namespaces during the deploying of ur applications, kubernetes create defalut name spaces.

13.  ## Liveness & readyness probes ##
readyness check all about checking the health state of pod when it is created.
          once pod is created healthy but one after one 
hour pod is unhealthy then liveness check coming to picture.. it will check the readyness of running pods.
is concept of configureing the health check settings into ur deployment to ensure the pod healthy or not.incase pod is not healthy it replace automatically.
 the deployment will check readiness of newly created pod whenever readiness check success newly created pod then immeditly turned into a healthy then immdtly service takescare routing of that.
if readiness check fail some reason for the newly created pod immdietly the deployment will terminate that pod and newly created another pod.

## Deployment 0f Rolling upgrade & Rolling back ###
 it s service to used for u have to upgrade ur app with ur new versions.. add the ur latest version image in ur deployment file then apply deploy yaml file.. then deployment controller will create the new pods for new version when new pods are pass the livensess and readyness test then older pods are deleted automatically..
 Rolling back is a service  roll the ur app with older versions.. in this case new versions works not expected then roll back to ur older vesrsions..in this add ur old image in ur deploy file and apply that ...then deployment controller deploy older version and deleteing the new versions simutensuly..

## Load balance ##
kubernetes have 4 services 1.cluster ip service 2.node port service 3. load balancer servcie 4.External Name Creation service 
 ur deployment file will ensure that aws loadbalncer for u and all the wokers nodes added as a target ,all the health checks are configured in load balancer all the setup will be automatically for u.
    when ur use service load balncer it will do 2 things  for u 1 is it will create balancer for u and also deploy node ports for u.
this load balncer for cloud type infrastruture not suitable for on premise.
API server is responsible to create aws loadbalancer in kubernetes.

## Metric Server ##
You can use Metrics Server for:

CPU/Memory based horizontal autoscaling (learn more about Horizontal Autoscaling)
Automatically adjusting/suggesting resources needed by containers (learn more about Vertical Autoscaling).

## Horizontal pod auto scaling ##
 HorizontalPodAutoscaler automatically updates a workload resource (such as a Deployment or StatefulSet), with the aim of automatically scaling the workload to match demand.
 Horizontal scaling means that the response to increased load is high  to deploy more Pods.
 If the load decreases, and the number of Pods is above the configured minimum

 ## Statefull vs stateless apps ###
 1. the stateless sense ur not depending on the pod related data it means maybe ur apache tomcat app is runnig stateless behaviour why incase pod terminated new pod will be created i don't show any issues.
 2. Statefull means ur pod will crashes u will loss a important data if pod wiil be recreated only service will be created not comeback ur data.
 exmple: database app
in this case i will tell to database app hey don't store the data in pod. i give u external volume memory to store the data.
if database pod will terminated i hav't loss the data. and when recreated database pod then i will attach previous volume to pod.then pod have the same data and work from where it stop.

## how to supply this external memory ###
1. persistent volume 2. persistent volume claim
persistent volume means external volume takes from aws/azure..cloud  store the app data.
persistent volume claims measn that persistent volume reback add to ur recreate pod.

## Logging ##
all pods create a logs. i want see all pod logs at one place.by useing fluntee u can do this
fluntd:is the application which is responsible to collecting the log data of running pods on specific worker nodes.and store it in elasticsearch database
flunted deploy in all pods..
1. kibana:popular application which is well intregated to elasticeserach databases.. 
kibana responsible in collecting the data stored in elasticserach database and that data will be shows in beautyfull graphical presentation.
u want see the logging informstion then no need to run cmnds on node .. goto kibana dashboard in this dashboard u can all loggig data of all pods running cluster.is called as centralized logging system.
flunted deployed as a deamon set.
Deamon set: all about make sure that pod is running in each worked nodes in each worked nodes it will create.

## Monitoring ##
monitor the ur pod useing grafana tool.install the grafana app as a pod monitor the real traffic of ur netowrks of ur pods. but grafana not collecting data it is just show the ur data in garph.
so u can use another tool for collecting the data that is promotheus app.
promotheus tool responsible in collecting the live data and store the data in promotheus database.

## Ingress controller ##
it routes the traffic of all  kibana and grafan pods in one cluster by useing one aws loadbalancer
ingress is b/w loadbalncer and clustr  kibana,grafana pods 
#vi ingress_cotroller.yaml

