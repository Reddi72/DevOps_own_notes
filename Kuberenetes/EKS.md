# Managed kubernets cluster ##
it is mean by when ever you have a kubernetes cluster got setup that management something will be taken care by the cloud service provider only 
# types of managed services ##
1. amazon elastic kubernetes service (EKS)
2. Azure kubernetes service (AKS)
3. IBM cloud kubernetes service
4. Google kubernetes engine

# Advantages of Managed kubernets cluster #
1. Pay as a go service 
2. Easy application deployment 
3. Eliminate operatinal overhead with auto-repair,auto upgrade,and realese channels

## EKS setup ##
 ## pre-requsites 
 For this tutorial, you will need:

1. an AWS account
2. the AWS CLI, installed and configured
3. AWS IAM Authenticator
4. the Kubernetes CLI, also known as kubectl

goto amazon console--search for eks--add clucster--create cluster.

## setup the EKS through Terraform ##
1. setup bootstrap server
  create bootstrap server
  create IAm role and attached that role to bootstrap server

#aws --version
#curl -o aws-iam-authenticator https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
#curl -o aws-iam-authenticator.sha256 https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator.sha256
#openssl sha1 -sha256 aws-iam-authenticator
#chmod +x ./aws-iam-authenticator
#mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
#echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
#aws-iam-authenticator help
#aws-iam-authenticator version

# nstall kubectl binary with curl on Linux #
#curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#chmod +x kubectl
#mv kubectl /usr/local/bin
#kubectl version

# Set up and initialize your Terraform workspace #
#git clone https://github.com/hashicorp/learn-terraform-provision-eks-cluster
#cd learn-terraform-provision-eks-cluster

## installing terraform on ur server ##
#sudo yum install -y yum-utils
#sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
#sudo yum -y install terraform

#terraform init
#terraform apply

## Configure kubectl ##
#aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)

### HELM ##
#wget https://get.helm.sh/helm-v3.10.0-linux-arm64.tar.gz
#tar xvf helm-v3.10.0-linux-arm64.tar.gz
#mv helm /usr/local/bin

#vi helm chart.yaml
apiVersion: v2
name: dpt-web-app
description: A Helm chart for Kubernetes
version: 1.0
appVersion: "1.16.0"

#vi valuse.yaml
deployment:
  replicaCount: 3
service:
  nodePort: 32000
  port: 80
  targetPort: 80

#vi deployment.yaml
# Deploy Nginx application with Liveness and Readiness Probe
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
  labels:
    app: nginx-app
spec:
  replicas: {{ .Values.deployment.replicaCount }}
  selector:
    matchLabels:
      app: nginx-app
  template:
    metadata:
      labels:
        app: nginx-app
    spec:
      containers:
      - name: nginx-container
        image: docker.io/nginx:1.18
        ports:
        - containerPort: 80
        readinessProbe:
          tcpSocket:
            port: 80
        livenessProbe:
          tcpSocket:
            port: 80

vi nodeport.yaml
# Deploy nodePort Services
apiVersion: v1
kind: Service
metadata:
  name: my-service
  labels:
    app: nginx-app

spec:
  selector:
    app: nginx-app

  type: NodePort
  ports:
  - nodePort: {{ .Values.service.nodePort }}
    port: {{ .Values.service.port }}
    targetPort: {{ .Values.service.targetPort }}

#helm package "helm folder name"
-- helm chart created
#helm install [deployment name ex-dptweb]  helm chart anme
-- helm chart deployed
#helm list  --> here shows ur helm list

## Deployment flow ##
whenever developer is giveing source code push into bit bucket repository then asking a deveops engineer go and build and deploy the application in kubernetes cluster ..
as devops enginner u can take the code and go with ur maven build process and push build to the sonarqube for doing the code quility checks once code quility passed then u can push the artifacts to jfrog artifactory and then u develope ur docker file and do the docker build process and after docker build process as part of the build process i has to pull the war file from the jfrog and then that has to add maven artifacts into a new custom container image the image will be pushed into docker hub then u need to develope the yaml file to deploy the it into a kubernetes container orachastration engine that is where manfest file reference has to use deploy along with other specifications as per ur experting ur worker loads and once manfest file is ready because  i have many manfests files there to manage the my workloads all of the manfests now packaged into a helm chart so u need a create a hlm chart with the helm package binary the helm chart that created that helm chart will be again pushed back to the jfrog because that is the final chart that i need do the deployment keep it into the jfrog whenever do the deployments u take the helm chart jfrog and do deployment into ur kubernetes cluster.
===============================================================================================================

 Now i want to store the helm chart in jfrog
 open jfrog-- choose helm from the list---create helm repositoery ---give name of the helm chart--create
 ----and follow the jfrog cmnds