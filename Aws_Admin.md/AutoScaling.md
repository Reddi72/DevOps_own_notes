## Autoscaleing ##
Auto Scaling groups are collections of Amazon EC2 instances that enable automatic scaling and fleet management features. These features help you maintain the health and availability of your applications.

# Load balancer
Elastic Load Balancing scales your load balancer capacity automatically in response to changes in incoming traffic.
# Create load balancer:
Ec2-->load balancing-->load balncer-->create load balncer-->select load balancer-->Load balancer name(new_lb)-->VPC-->choose ur vpc-->mappings-->choose minimum 2 avalability zones-->select security groups-->port 80-->create load balancer.
1. Application Load Balancer: Choose an Application Load Balancer when you need a flexible feature set for your applications with HTTP and HTTPS traffic. Operating at the request level, Application Load Balancers provide advanced routing and visibility features targeted at application architectures, including microservices and containers.
2. Network Load Balancer: Choose a Network Load Balancer when you need ultra-high performance, TLS offloading at scale, centralized certificate deployment, support for UDP, and static IP addresses for your applications. Operating at the connection level, Network Load Balancers are capable of handling millions of requests per second securely while maintaining ultra-low latencies.
3. Gateway Load Balancer: Choose a Gateway Load Balancer when you need to deploy and manage a fleet of third-party virtual appliances that support GENEVE. These appliances enable you to improve security, compliance, and policy controls.

# Auto Scaling group:
An Auto Scaling group is a collection of Amazon EC2 instances that are treated as a logical unit.Setting different minimum and maximum capacity values forms the bounds of the group, which allows the group to scale as the load on your application spikes higher or lower, based on demand.let Amazon EC2 Auto Scaling automatically add and remove capacity to meet changes in demand.

# launch configuration:
Creating a launch configuration allows you to create a saved instance configuration for EC2 Auto Scaling.
After creating a launch configuration and associating it with an Auto Scaling group.
# Create launch configuration:
ec2-->auto scaling-->lanuch configuration-->Launch configuration name(new_lc)-->Amazon machine image (AMI)-->choose ami-->choose Instance type(medium)-->Additional configuration-->IAM instance profile-->Monitoring -->EBS volumes-->Security groups-->Rules-->Key pair-->create launch configuration.

# Launch template
-->Create launch template-->Launch template name-->Amazon Machine Image--->Key pair name-->Security groups-->Advanced details-->lauch template

# Create Auto Scaling group:
Ec2-->Auto scaling-->Auto scaling groups-->Create Auto Scaling group-->group name(new_group)-->choose template-->group size(1)-->subnet-->Advanced details-->loadbalancing-->choose ur loadbalancer-->health check-->use scale policies to adjust the capacity of this group-->scale between minimum instances 1 and maximum instances4-->sample scaling policy-->increase group size-->add new alarm-->send notification to mailid-->cpu utilization>=70%-->consecutive period(5 minutes)-->create alarm-->take the action-->add-->1 instance when cpu utilization is above 70%.-->instance need 60 sec.
Decrese group size-->add new alarm-->send notification to mailid-->cpu utilization<=10%-->consecutive period(5 minutes)-->create alarm-->take the action-->remove-->1 instance when cpu utilization is less 10%.-->instance need 60 sec.-->create.
=========================================================
## Cloud Watch ##
# Rule:
Amazon Event bridge--->Rules-->create rule-->Name-->Rule type(1.Rule with an event pattern 2.Schedule)-->next-->Schedule-->cron *****-->targets-->ec2 creates snapshot API call-->volume id-->configure.

# Alarms:
Cloud watch-->all alarms-->create alarm-->metric-->select metric-->ec2-->cpu utilization-->selct metric-->Period-->5m-->Whenever CPUUtilization is-->Greater/Equal
>= threshold-->than…Define the threshold value(85)-->Datapoints to alarm(1-1)-->add notification-->Alarm state trigger-->In alarm-->Create new topic-->Email-->create topic-->alarm name(cpu)-->review and create.
# Billing alarm:
cloud watch-->alarms-->billing-->create alarm-->Conditions-->Whenever EstimatedCharges is.Greater/Equal>= threshold 40 usd dollars-->next-->email-->create.
# Createing Dashboard:
cloud watch-->dashboard-->name-->create dash board-->add widget-->choose template(ec2)-->create.
====================================================
## AWS Lambda #
is compute service where you can upload your code and create a lambda function. AWS lambda takes care of provisioning and manageing the servers that you use to run the code. You don't worry about operting systems,patching,scaling..etc.

## Load balanceing #
User--->Webserver--->Load balancer
                          |
                |"""|"""""|""""|"""|"""|"""|
                   EC2 Ec2   Ec2  Ec2 Ec2 Ec2 Ec2
here load balancer distribute load throughwards ec2 as per end user demand.
# Create Load balancer #
AWS-->Ec2-->Load balancing-->Load balncers-->create load balancer-->classic loadbalncer-->Load Balancer name-->select vpc-->Listener Configuration-->port-->next-->Assign Security Groups-->choose security group of webserver and select it-->next-->Configure Health Check-->Ping Protocol-->HTTP
Ping Port-->80-->Ping Path-->/index.html-->Advanced Details-->Advanced Details-->Response Timeout(5sec)
-->Interval(30 seconds)-->Unhealthy threshold(2)-->Healthy threshold(10)-->next-->Add EC2 Instances-->select instances-->Next & Add Tags-->Review and create..
# Configure Health Check
Your load balancer will automatically perform health checks on your EC2 instances and only route traffic to instances that pass the health check. If an instance fails the health check, it is automatically removed from the load balancer. Customize the health check to meet your specific needs.
======
Now create security groups with allow httpd 80 port add this security group to instnces.
create 2 instnces and attch this load balancer to this instancs.
login to 2 servers thorugh putty/gitbash
#sudo su -
#yum install httpd -y
#cd /var/www/html
#echo "<html><h1>This is my home page from aws cloud2<h1><html>" > index.html
#systemctl start httpd
#chconfig httpd on
 Then
goto loadbalncer-->instances-->status-->inservice.
then -->descrption-->copy dns address and searcgh in google here shows web page and refresh it shows 2diffrent output for 

# Auto Scaleing #
# Placement group:
it is a logical grouping of instances within a single availability zone. useing placement groups enables applications to paritcipate in a low-latency, 10 gbps network. placement groups are recommend for applications that low network latency,high network thorughpoint or both.
1. A placement group can't span multiple avialable zones.
2. The name you specify for a placement  group must be unique with in your aws account.
3. only certain types of instncs can be launched in a placement group(compute optimizes,GPU,memory optimized,storage optimized)
4. Aws recommend homogenous instances within placement groups
5. u can't merge placement groups.
6. u can't move an existing instance into a placement group.you can create an ami from existing instance and then launch a new instance from the ami into placement group.

Ec2-->Network nd security--->placement groups-->create placement group-->name(First_plcgrp)-->Placement strategy-->cluster-->  

# EFS:
Amazon Elastic File System (Amazon EFS) provides a simple, scalable, elastic file system for general purpose workloads for use with AWS Cloud services and on-premises resources.

aws--->EFS-->create file system-->Name-->choose vpc-->storage-->select avialability zones-->security groups-->create.
go to ec2 and create instnces and attch same security groups to all and create.
login ur servers thorugh putty..
#sudo yum install amazon-efs-utils -y
#mkdir efs
#cd /
#ls  --L here shows efs
#mount -t nfs4 -o nfserver=4.1,rsize=1048576,wsize=1048567,hard,time0=600,retrsns....etc
#cd efs
#cat file1 -->server1
#cat file2 -->server2
above 2 files shows in both servers.
============================
# Auto Scaleing #
# Placement group:
it is a logical grouping of instances within a single availability zone. useing placement groups enables applications to paritcipate in a low-latency, 10 gbps network. placement groups are recommend for applications that low network latency,high network thorughpoint or both.
1. A placement group can't span multiple avialable zones.
2. The name you specify for a placement  group must be unique with in your aws account.
3. only certain types of instncs can be launched in a placement group(compute optimizes,GPU,memory optimized,storage optimized)
4. Aws recommend homogenous instances within placement groups
5. u can't merge placement groups.
6. u can't move an existing instance into a placement group.you can create an ami from existing instance and then launch a new instance from the ami into placement group.

Ec2-->Network nd security--->placement groups-->create placement group-->name(First_plcgrp)-->Placement strategy-->cluster-->  
