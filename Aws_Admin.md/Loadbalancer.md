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
