#!/usr/bin/python
import sys
import datetime
import boto3
import json

try:    
    nregion = sys.argv[1]
except:    
    print ("Example: asg-discovery.py REGION")    
    sys.exit(1)

def targetname():    
    client = boto3.client('elbv2', region_name=nregion)
    responsedx = client.describe_target_groups()    
    services = []    
    for v in responsedx['TargetGroups']:
        services.append({
                       "{#NAMELOAD}": v['LoadBalancerArns'],            
                       "{#TARGETNAME}": v['TargetGroupName']
                     })
        raw = {"data": services}    
        print(json.dumps(raw))
        
targetname()
