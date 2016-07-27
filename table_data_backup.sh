#!/bin/bash
##########################################################################################
# Created By     : SUBHANKAR NEOGI
# Coder          : SUBHANKAR NEOGI
# Create Date    : 08/10/13
# Purpose        : TO TAKE DUMP AND UPLOAD MIGRATION SCHEMA DATA IN INTEGRATION AND MY SYSTEM
# Version Number : 1
# Modified By           Date              Purpose
# Subhankar Neogi	09/12/2013	  Table Addition
# Subhankar Neogi	30/12/2013	  Table Addition
##########################################################################################
start_date=$(date +"%T")
cd /opt/PostgresPlus/9.1AS/Desktop/crons
 sh old_data_backup.sh
	####################################################### Shell for import data from v3 to v5
 echo "########################################################################"
 echo "####		WILL WANT ORACLE WINEAPPS PASSWORD	           #####"
 echo "########################################################################"
	sh V3_TO_V5_Migration.sh
	
rm -fr /opt/PostgresPlus/9.1AS/Desktop/Automation
mkdir /opt/PostgresPlus/9.1AS/Desktop/Automation
pg_dump -a --format=plain --table=v4reg.tbl_entity --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_entity.sql
pg_dump -a --format=plain --table=v4reg.tbl_asset --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_asset.sql
pg_dump -a --format=plain --table=v4subsc.tbl_month_service --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_month_service.sql
pg_dump -a --format=plain --table=v4stock.tbl_device_stock --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_device_stock.sql
pg_dump -a --format=plain --table=v4map.tbl_node --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_node.sql
pg_dump -a --format=plain --table=migration.tbl_node_entity_map --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_node_entity_map.sql
pg_dump -a --format=plain --table=V4TRIP.TBL_MAINTAIN --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_maintain.sql
pg_dump -a --format=plain --table=v4reg.tbl_user --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_user.sql
pg_dump -a --format=plain --table=v4ugm.tbl_user_role --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_user_role.sql
pg_dump -a --format=plain --table=v4ugm.tbl_role --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_role.sql
pg_dump -a --format=plain --table=v4subsc.tbl_amc_activity --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_amc_activity.sql
pg_dump -a --format=plain --table=v4ugm.tbl_role_service --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_role_service.sql
pg_dump -a --format=plain --table=v4ugm.tbl_entity_association --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_entity_association.sql


sed -i 's/v4reg/migration/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_entity.sql
sed -i 's/v4reg/migration/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_asset.sql
sed -i 's/v4subsc/migration/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_month_service.sql
sed -i 's/v4stock/migration/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_device_stock.sql
sed -i 's/v4map/migration/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_node.sql
sed -i 's/v4reg/migration/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_user.sql
sed -i 's/v4ugm/migration/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_user_role.sql
sed -i 's/v4ugm/migration/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_role.sql
sed -i 's/v4ugm/migration/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_role_service.sql
sed -i 's/v4ugm/migration/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_entity_association.sql
#sed -i 's/migration/v4map/g' /opt/PostgresPlus/9.1AS/Desktop/Automation/tbl_node_entity_map.sql

rm -fr /opt/PostgresPlus/9.1AS/Desktop/Automation.zip
cd /opt/PostgresPlus/9.1AS/Desktop/
zip -r Automation.zip Automation

scp Automation.zip subhankar@192.168.10.109:/home/subhankar/Desktop/NEW_DATA
scp Automation.zip enterprisedb@x.x.x.x:/opt/etrans/backup

#rm -fr /opt/PostgresPlus/9.1AS/Desktop/Automation
#rm -fr Automation.zip
 cd /opt/PostgresPlus/9.1AS/Desktop/crons
 echo "########################################################################"
 echo "####		WILL WANT INTEGRATION'S PASSWORD	          #####"
 echo "########################################################################"
 sh my_script.sh
 sh psql_env.sh
 cd /opt/PostgresPlus/9.1AS/Desktop/crons
scp enterprisedb@14.140.228.94:/opt/etrans/backup/tbl_lastdata.sql.zip .
unzip -o tbl_lastdata.sql.zip
echo "truncate table syn_lastdata;"| psql
psql < tbl_lastdata.sql
ssh subhankar@192.168.10.109 << ENDSSH
 		cd /home/subhankar/Desktop/NEW_DATA
 		unzip -o Automation.zip
 		cd /home/subhankar/Desktop/
ENDSSH
  end_date=$(date +"%T")
  echo "Start Date Time was $start_date and end date time is $end_date"
diff_sec=$(($end_date-$start_date))
echo "$(($diff_sec / 60)) minutes and $(($diff_sec % 60)) seconds elapsed."
 
EXIT

