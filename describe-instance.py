#!/bin/python3
import boto3
import sys
import csv

try:
    accessKey = sys.argv[1]
    secretKey = sys.argv[2]
    nregion = sys.argv[3]

except:
    print ("Example: describe-address.py aws_access_key_id=accessKey aws_secret_access_key=secretKey REGION")
    sys.exit(1)

client = boto3.client('ec2',  aws_access_key_id=accessKey, aws_secret_access_key=secretKey, region_name=nregion)
responsedx = client.describe_instances()
for v in responsedx['Reservations']:
 for printout in v['Instances']:
     with open('ipaddress.csv', 'a') as file:
        w = csv.writer(file)
        w.writerow([printout['PrivateIpAddress']])
     print("Relatório gerado")