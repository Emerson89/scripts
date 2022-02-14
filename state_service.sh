#!/bin/bash
SERVICE=$1
STATE=`systemctl status $SERVICE | grep active | awk '{print $2}'`
if [ $STATE == "active" ]
   then
      echo "1"
elif [ $STATE == "inactive" ]
   then
      echo "0"
fi

## systemctl list-unit-files --all --state=enabled --type service | grep cron.service  | awk '{print $1}'
## systemctl list-unit-files --all --state=enabled --type service | awk '{print $1}' | sed -e '1d;37d;38d;39d'

#UserParameter=services.systemctl,echo "{\"data\":[$(systemctl list-unit-files --type=service|grep \.service|grep -v "@"|sed -E -e "s/\.service\s+/\",\"{#STATUS}\":\"/;s/(\s+)?$/\"},/;s/^/{\"{#NAME}\":\"/;$ s/.$//")]}"

#UserParameter=systemctl.status[*],systemctl status $1


