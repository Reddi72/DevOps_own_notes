## *** Cloud Watch *** ##
# Rule:
Amazon Event bridge--->Rules-->create rule-->Name-->Rule type(1.Rule with an event pattern 2.Schedule)-->next-->Schedule-->cron *****-->targets-->ec2 creates snapshot API call-->volume id-->configure.

# Alarms:
Cloud watch-->all alarms-->create alarm-->metric-->select metric-->ec2-->cpu utilization-->selct metric-->Period-->5m-->Whenever CPUUtilization is-->Greater/Equal
>= threshold-->than…Define the threshold value(85)-->Datapoints to alarm(1-1)-->add notification-->Alarm state trigger-->In alarm-->Create new topic-->Email-->create topic-->alarm name(cpu)-->review and create.
# Billing alarm:
cloud watch-->alarms-->billing-->create alarm-->Conditions-->Whenever EstimatedCharges is.Greater/Equal>= threshold 40 usd dollars-->next-->email-->create.
# Createing Dashboard:
cloud watch-->dashboard-->name-->create dash board-->add widget-->choose template(ec2)-->create.
=================================