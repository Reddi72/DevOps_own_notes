## ROUTE53 ##
# DNS: 
if u have used the internet you have used DNS. DNS is used to convert human friendly domain names(such as http://example.com) into an internet protocol(IP) address (such as http://12.4.433.4).
IP addresses are used by computers to identify each other on the network. IP addess commonly come in 2 different forms ,IPv4,IPv6
# IPv4 vs IPv6:
The IPv4 space is a 32 bit field and has over 4 billion different addresses (4,294,967,296 to be precise).

The IPv6 was created to solve this depletion issue and has an addresses space of 128bits which in theory is
340,282,366,920,938,463,463,374,607,431,768,211,456 addresses  or 340 undecillion addresses
# Top level domains # 
if we look at common domains names such as google.com,bbc.co.uk etc.. u will notice a string of character separeated by dots(periods). the last word in a domain name represents the "top level domain"the  second word in a domain name(this is optional thorugh and depends on the domain name) like .com .edu .gov .co.uk .gov.uk .com.au
these top level domain names are controlled by the internet assigned numbers authority(IANA) in a root zone database which is essentially a database of all avilable top level domains.u can view this database by visiting.
http://www.iana.org/domains/root/db
# Domain Registars:
because all of the names in a given domain name have to be unique there needs to be a way to orgnise this all so that   domain names aren't duplicated. this is where domain registars come in.A register is an authority that can assign domain names directly under one or more top-level domains. theses domains are registered with InterNIC, a service of ICAN,which enforces uniqueness of domain names across the internet.each domain name becomes registred in a central database known as the whois database.
Popular domain registars include Godaddy.com, 123-reg.co.uk ..etc
# SOA records #
The name of the server that supplied the data for the zone.
The adminstrator of the zone
The current version of the data file
the default number of seconds for the time-to-live file on resource records.
# NS record:
NS stands for name server records   and are used by top level domain severs to direct traffic to the content DNS server which contains the authorative DNS records.
# A records:
An 'A'record is the fundmental type of DNS record and the 'A' in A record stands for 'Address'.The A record by a computer to translate the name of the domain to the IP address. for Exmple http://www.exmple.com   might point http://123.44.443.80
# TTL(Time To Live):
The length that a DNS record is cashed on either the Resloving server or the users own local PC is equal to the value of the "time to live" in seconds. the lower the time to live,the fast changes to DNS records take to propagate throughout the internet.
# CNAMES:
A canonical Name(CNAME) can be used to resolve one domain name to another. for example you may have a mobile website with the domain name http://facebook.com
that is used for when users browse to ur domain name on their mobile devices.you may also want the name http://fb.com to resolve to this same address. 
fb is canonical name facebook.com
# Alias records:
Alias records are used to map resource record sets in ur hosted zone to elastic load balancer, cloud front distributions, or S3 buckets that are configured as websites.
Alias records work like a CNAME record in that u can map one DNS name (www.facebook.com) to another 'target' DNS name (elb1234.elb.amazonaws.com)
key difference - A CNAME can't be used for naked domain names (zone apex). you can't have a CNAME for http://facebook.com. it must be either an A record or an alias.

# LAB #
# Flow Chart:
Domain Register-->Domain hosting-->NS records--> A record-->Alias Load balancer-->Ec2 instnace Webserver.

# Step1: Purchase Domain
Purchase the domain from "freenom.com" in this domain purchaser .ml domains are free.
freenom.com-->Search-->Reddi.ml-->checkout-->3 months free-->continue-->ask ur gmail for sign in-->enter ur mail-->verify link will sedn to ur mail-->verify it-->enter basic details-->continue-->purchased-->again login to freenom.com-->login-->services-->my domains-->reddi.ml-->manage domain-->management tools-->name servers
# Step2: Create a hosting in amazon route53
Aws-->Route53-->Hostedzones-->created hostzones-->domain name(reddi.ml)-->created hosted zone-->here u can see 2 records NS,SOA-->copy NS names-->goto freenom-->mydomains-->reddi.ml-->manage domain-->management tools-->name servers-->customize-->paste here NS names.

# Step3: Verify the following records-(SOA & NS)
# Step4: map NS records from Route 53 Hosted zone into place we have purchased Domain 
# Step5: Create an Ec2 instance
creat new instance for httpd webserver.
# Step6: Create a load balancer and map it with ec2 instance
Aws-->Ec2-->loadbalancing-->load blancer-->create loadbalancer-->classic loadbalancer-->name(mywebLB)-->next-->add webserver security group-->next-->configure health check-->ping path(/healthy.html)-->next add to Ec2instance-->select ur webserver-->add tags-->key(Teams)-->value(Development)-->review and create.
check ur loadbalancer useing DNS url search in google.
# Step7: Create an a record and map the naked domain with alias - ELB(load balancer)
aws-->Route53-->hosted zones-->select hosteszone-->create record-->alias on-->Route traffic to-->Alias to Application and classic loadbalancer-->region(us-east(n.viragia))-->load balancer-->select ur loadbalancer-->Routing policy-->simple-->create record.

# Step8: Create one or more A record with 'www' and map it with the existing hosted zone
aws-->Route53-->hosted zones-->select hosteszone-->create record-->name(www)-->alias on-->Route traffic to-->choose endpoint-->Alias to another record in this hosted zone-->choose record-->reddi.ml-->create record

goto google-->www.reddi.il.
# Step9: Test the hosting with naked domain/apex record and with full domain name.
========================================================
## Route53 Routing Policies ##
1. Simple:
           This is the defult routing policy when create
a new record set.This is most commonly used when u have a single resources that performs a given function for your domain,for example, one web server that servers content for the http://exmple.com website.
In this exmple Route53 will respond to DNS queries that are only in the record set(ie there is no intellgence built in to this response)
2. Weighted:
            this policies let you spilt your traffic
based on different weights assigned.
for exmple u can set 10% of ur traffic to go to US-EAST-1 and 90% to go EU-WEST1
3. Latency:
           it allows you to route ur traffice based on
the lowest network latency for ur end user(ie which region will give them the fastest response time)
to use latency-based routing you create a latency   resource record set for the amazon Ec2(or ELB) resource in each region that hosts ur website.when amazon route53 recieves a query for ur site,it selects the latency resource record set  for the region that gives the user the lowest latency. Route53 then responds with the value associated with resource record set.  
Ex: user from india access my website but i have hosted us-east1 and us-west1, Route53 decides which is the least and fastest  way to reach the server for enduser.
depending on latency as we see here 53milli seconds us-west1 server and 104ms for us-east1. then user automatically divert to the uswest1 in this latency based routing.

4. Failover:
            this polices are used when you want to crea
te an active/passive setup.
Ex:u may want ur primary site to be in US-West-1 and ur secondary DR site in US-East1.
Route53 will monitor the health of ur primary site using a health check.
A health check monitors the health of ur end points.

5. Geolocation:
               Lets choose where ur traffic will be sent 
based on the geographic location of ur users(ie the location from which DNS quires orginate).
Ex: u might want all quries from Europe to be routed to a fleet of Ec2 instnces that are specifically configured for ur Europen customers. These servers may have the local language of ur Europen customers and all prices are displyd i Euros.
=====================================================





