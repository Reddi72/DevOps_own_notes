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