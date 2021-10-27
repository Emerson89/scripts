#!/usr/bin/python3

import datetime,time,sys
from zabbix_api import ZabbixAPI

url=sys.argv[1]
user=sys.argv[2]
password=sys.argv[3]
actiontyp=sys.argv[4]
actionrtyp=sys.argv[5]
userlist=sys.argv[6].split(',')
timemin=int(sys.argv[7])

try:
    zapi = ZabbixAPI(url, timeout=15,)
    zapi.login(user,password)
except Exception as err:
    print(f'Failed to connect to API:\n\n {err}')

date = datetime.datetime.now() - datetime.timedelta(minutes = timemin)
end = int(time.mktime(date.timetuple()))
lista=[]
try:
    checkaudit = zapi.auditlog.get({
        "output": 'extend',
        "selectDetails": 'extend',
        "time_from": end,
        "filter": {
            "action": actiontyp,
            "resourcetype": actionrtyp
        }
    })
    for audit in checkaudit:
        if audit.get("userid") not in userlist:
            lista.append(audit)
    print(len(lista))
except Exception as err:
    print(f'Failed to capture:\n\n{err}')