#!/usr/bin/python3
import sys
import boto3
import json
try:
    nregion = sys.argv[1]

except:
    print ("Example: sns-custo.py REGION")
    sys.exit(1)

client = boto3.client('sns', region_name=nregion)
responsedx = client.get_sms_attributes()
print(json.dumps(responsedx))