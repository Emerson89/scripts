#!/usr/bin/python3
import sys
import datetime
import boto3

try:
    metName = sys.argv[1]
    funcName = sys.argv[2]
    nameSpace = sys.argv[3]
    nregion = sys.argv[4]

    if (len(sys.argv) > 5):
      period = int(sys.argv[5])
    else:
      period = 4

except:
    print ("Example: cloudwatch-sns.py METRIC FUNCNAME NAMESPACE REGION")
    sys.exit(1)

client = boto3.client('cloudwatch', region_name=nregion)
end = datetime.datetime.utcnow()
start = end - datetime.timedelta(minutes=period)
r = client.get_metric_statistics(
    Namespace=nameSpace,
    MetricName=metName,
    StartTime=start,
    EndTime=end,
    Period=period*60,
    Statistics=[funcName])

try:
   if (r.get("Datapoints")) == []:
    print (0)
   else:
    print(r.get("Datapoints")[0].get(funcName))
except Exception as e:
    print(e)