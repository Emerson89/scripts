#!/usr/bin/python3
import sys
import datetime
import boto3
import json
try:    nregion = sys.argv[1]

except:    
    print ("Example: rds-discovery.py REGION")    
    sys.exit(1)

client = boto3.client('sqs', region_name=nregion)
responsedx = client.list_queues()
services = []
for v in responsedx['QueueUrls']:        
    services.append(v)
    raw = services
    print(raw)
    print()
    print ("Filtro")
    print()
    
    def check_even(x):    
        if x == "https://queue.amazonaws.com/579054269000/fullcond-test":
           return True

        return False

even = filter(check_even, services)
even_filtar = list(even)
print(even_filtar)