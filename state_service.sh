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