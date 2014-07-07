#!/bin/bash
##########################################################################################
# Created By     : SUBHANKAR NEOGI
# Coder          : SUBHANKAR NEOGI
# Create Date    : 14/03/2014
# Purpose        : TO MIGRATE V3 DATA IN V5 Dianamicaly
# Version Number : 1
# Modified By           Date              Purpose
# 
##########################################################################################
c=0
FILE_NAME=$(echo "select S_FILE_NAME||', data' from tbl_migration; "| sqlplus trip/trip@gpstrn | grep data |awk '{print $1}')
TABLE_NAME=$(echo "select S_TABLE_NAME||', data' from tbl_migration; "| sqlplus trip/trip@gpstrn | grep data |awk '{print $1}')
DIRECTORY_NAME=$(echo "select S_DIRECTORY||', data' from tbl_migration; "| sqlplus trip/trip@gpstrn | grep data |awk '{print $1}')
ABS_PATH=$(echo "select S_ABS_PATH||', data' from tbl_migration; "| sqlplus trip/trip@gpstrn | grep data |awk '{print $1}')
cntr=$(echo "select count(*)||', data' from tbl_migration; "| sqlplus trip/trip@gpstrn | grep data |awk '{print $1}')
IFS=',
'
FILE_ary=($FILE_NAME)
TABLE_ary=($TABLE_NAME)
DIRECTORY_ary=($DIRECTORY_NAME)
ABS_PATH_ary=($ABS_PATH)
i=0
echo "$cntr"
while [ $i -lt $cntr ]
do
file_name_path="${ABS_PATH_ary[$i]}/${FILE_ary[$i]}"
cp $file_name_path /oracle01/oracle/v2/reports/db_process_log/v3_migration/${FILE_ary[$i]}
echo "File name is $file_name_path"
i=`expr $i + 1`
done
rm -fr /oracle01/oracle/v2/reports/db_process_log/v3_migration.zip
cd /oracle01/oracle/v2/reports/db_process_log/
zip -r v3_migration.zip v3_migration
