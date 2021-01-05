#!/bin/bash

# threads is based on number of cpus
#THDS=`nproc`
THDS=10

SOCK=""
if [[ "$MYSQL_HOST" == "localhost" ]]
then
  SOCK="--mysql-socket=$MYSQL_SOCK"
fi

sysbench --threads=$THDS --rate=0 --report-interval=1 --db-driver=mysql \
         $SOCK \
         --mysql-host=$MYSQL_HOST --mysql-port=$MYSQL_PORT --mysql-db=$MYSQL_DB \
         --mysql-user=$MYSQL_USER --mysql-password=$MYSQL_PASSWD \
         --mysql-storage-engine=innodb \
         $SYSBENCH_LUA_SCRIPT_LOCATION/oltp_insert.lua --tables=$TABLES --table-size=$TABLE_SIZE prepare
