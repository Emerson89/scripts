#!/bin/bash
user=$1
senha=$2

echo -e "Escolha a opção desejada: \n1 - Dump\n2 - Restore"

while :
do
  read INPUT
  case $INPUT in
       1)
         mysqldump -u $1 -p$2 zabbix | bzip2 > zbx-bkp.sql.bz2 | pv
         echo
         sleep 2
         echo "Backup Realizado"
         echo
         sleep 2
         echo "Aguarde copiando para S3"
         /usr/local/bin/aws s3 cp <source> <target>
         echo
         break
         ;;
       2)
         bunzip2 < zbx-bkp.sql.bz2 | /dev/null 1>&1 | mysqldump -u $1 -p$2 zabbix | pv
         echo
         echo "Restore realizado"
         break
         ;;
       *)
         echo  "Não existe está opção"
         ;;
  esac
done