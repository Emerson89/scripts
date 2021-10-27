#!/bin/bash
user=$1
#senha=$2

echo -e "Escolha a opção desejada: \n1 - Dump\n2 - Restore"

rpm -qs pv &> /dev/null
if [ $? -ne 0 ]
   then
      echo "Pacote pv não instalado"
      sudo yum install pv -y
   else
      echo "Pacote pv instalado"
fi

while :
do
  read INPUT
  case $INPUT in
       1)
         mysqldump -u $1 zabbix --single-transaction | pv | bzip2 > zbx-bkp.sql.bz2
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
         bunzip2 < zbx-bkp.sql.bz2 | pv | mysql -u $1 zabbix 
         echo
         echo "Restore realizado"
         break
         ;;
       *)
         echo  "Não existe está opção"
         ;;
  esac
done