## Block Base Storage(EBS) ##
Elastic Block Storage (EBS) allows you to create storage volumes and attach them to Ec2 instances.once attached, you can create a file sytem on top of these volumes run a database or use them in any other way you would use a block device. EBS volumes are placed in a speicfic avilability zone,where they are automatically replicated to protct you from the failuere of a single component.
# EBS types #
1. Genaral purpose SSD(GP2):
genaral purpose balancs both price and performance.
Ratio of 3 IOPS per GB with up to 10,000 IOPS and the ability to burst up to 3000 IOPS for extended periods of time for volumes under 1gib
2. Provisioned IOPS SSD:
Designed for I/O intensive applications such as large relational or NoSql databases.
use if you need more than 10,000 IOPS
can provison up to 20,000 IOPS per volume
3. Through out Optimized HDD(ST1):
big data 
Data warehouses
Log processing 
cannot be a boot volume
4. Cold HDD (Sc1):
Lowest cost storage for infrequently accessed workloads 
file server 
cannot be a boot volume.
5. Magnetic(Standard)
Lowest cost per gigbyate of all EBS volumes types that is bootable. magntic voulmes are ideal for workloads where data is accessed infrequintly,and applications where lowest storage cost is important.