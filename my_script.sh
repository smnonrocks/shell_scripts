#!/bin/bash
##########################################################################################
# Created By     : SUBHANKAR NEOGI
# Coder          : SUBHANKAR NEOGI
# Create Date    : 09/10/13
# Purpose        : TO POPULATE MIGRATION SCHEMA DATA DATA
# Version Number : 1
# Modified By           Date              Purpose
# Subhanakr Neogi	18/10/2013	  addition of new table backup
# Subhankar Neogi	09/12/2013	  Table Addition
# Subhankar Neogi	30/12/2013	  Table Addition
# Subhankar Neogi	07/01/2014	  Table Addition
# Subhankar Neogi	10/02/2014	  addition echo before each table data insertion
##########################################################################################
echo "------------MIGRATAION IN INTEGRATION WILL START SHORTLY PLEASE WT---------------------"
c=0
#ssh enterprisedb@X.X.X.X << ENDSSH
 cd /opt/backup/
 unzip -o Automation.zip
 cd /opt/cronjobs/
 source psql_env.sh
 c=$(echo "select 'MARKER '||count(*) from migration.tbl_entity" | psql | grep MARKER |awk '{print $2}')
 	if [ $c -ge 0 ] 
 	then
 		echo "Truncate table migration.tbl_entity;"| psql
 		echo "Total count in entity is $c"
 	fi 	
  c=$(echo "select 'MARKER '||count(*) from migration.tbl_asset" | psql | grep MARKER |awk '{print $2}')
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table migration.tbl_asset;"| psql
 		echo "Total count in entity is $c"
 	fi
  c=$(echo "select 'MARKER '||count(*) from migration.tbl_month_service" | psql | grep MARKER |awk '{print $2}')
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table migration.tbl_month_service;"| psql
 		echo "Total count in month_service is $c"
 	fi
  c=$(echo "select 'MARKER '||count(*) from migration.tbl_device_stock" | psql | grep MARKER |awk '{print $2}')	
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table migration.tbl_device_stock;"| psql
  		echo "Total count in device_stock is $c"		
 	fi
   c=$(echo "select 'MARKER '||count(*) from migration.tbl_node" | psql | grep MARKER |awk '{print $2}')	
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table migration.tbl_node;"| psql
  		echo "Total count in node is $c"		
 	fi
   c=$(echo "select 'MARKER '||count(*) from migration.tbl_node_entity_map" | psql | grep MARKER |awk '{print $2}')	
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table migration.tbl_node_entity_map;"| psql
  		echo "Total count in node_entity_map is $c"		
 	fi
    c=$(echo "select 'MARKER '||count(*) from V4TRIP.TBL_MAINTAIN" | psql | grep MARKER |awk '{print $2}')	
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table V4TRIP.TBL_MAINTAIN;"| psql
  		echo "Total count in V4TRIP.TBL_MAINTAIN is $c"		
 	fi
    c=$(echo "select 'MARKER '||count(*) from migration.tbl_user_role" | psql | grep MARKER |awk '{print $2}')	
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table migration.tbl_user_role;"| psql
  		echo "Total count in migration.tbl_user_role is $c"		
 	fi
    c=$(echo "select 'MARKER '||count(*) from migration.tbl_user" | psql | grep MARKER |awk '{print $2}')	
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table migration.tbl_user;"| psql
  		echo "Total count in migration.tbl_user is $c"		
 	fi
    c=$(echo "select 'MARKER '||count(*) from v4subsc.tbl_amc_activity" | psql | grep MARKER |awk '{print $2}')	
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table v4subsc.tbl_amc_activity;"| psql
  		echo "Total count in migration.tbl_user is $c"		
 	fi 
     c=$(echo "select 'MARKER '||count(*) from migration.tbl_role" | psql | grep MARKER |awk '{print $2}')	
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table migration.tbl_role;"| psql
  		echo "Total count in migration.tbl_role is $c"		
 	fi
     c=$(echo "select 'MARKER '||count(*) from migration.tbl_role_service" | psql | grep MARKER |awk '{print $2}')	
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table migration.tbl_role_service;"| psql
  		echo "Total count in migration.tbl_role_service is $c"		
 	fi
      c=$(echo "select 'MARKER '||count(*) from migration.tbl_entity_association" | psql | grep MARKER |awk '{print $2}')	
   	if [ $c -ge 0 ] 
   	then
 		echo "Truncate table migration.tbl_entity_association;"| psql
  		echo "Total count in migration.tbl_entity_association is $c"		
 	fi		
 cd /opt/backup/Automation
 	echo "tbl_entity"
 	psql < tbl_entity.sql
 	echo "tbl_asset" 	
 	psql < tbl_asset.sql
 	echo "tbl_month_service" 	
 	psql < tbl_month_service.sql
 	echo "ttbl_device_stock" 	
 	psql < tbl_device_stock.sql
 	echo "tbl_node" 	
 	psql < tbl_node.sql
 	echo "tbl_node_entity_map" 	
 	psql < tbl_node_entity_map.sql
 	echo "tbl_maintain" 	
 	psql < tbl_maintain.sql
 	echo "tbl_user" 	
 	psql < tbl_user.sql
 	echo "tbl_user_role" 	
 	psql < tbl_user_role.sql
 	echo "tbl_amc_activity" 	
 	psql < tbl_amc_activity.sql
 	echo "tbl_role" 	
 	psql < tbl_role.sql
 	echo "tbl_role_service" 	
 	psql < tbl_role_service.sql
 	echo "tbl_entity_association" 	
 	psql < tbl_entity_association.sql
	
  echo "select migration.fn_entity_migration();" |psql	
  echo "select migration.fn_month_service_migration();" |psql
  echo "select migration.fn_asset_migration();" |psql
  echo "select migration.fn_device_migration();" |psql
  echo "select migration.fn_node_migration();" |psql
  echo "select migration.fn_node_entity_migration();" |psql
  echo "select migration.fn_role_migration();" |psql
  echo "select migration.fn_role_service_migration();" |psql  
  echo "select migration.fn_user_migration ( );" |psql
  echo "select migration.fn_user_role_migration();" |psql
  echo "need to add" 
  echo "tbl_maintain Migration done"
  echo "select migration.fn_entity_association_migration();" |psql
  
   
#ENDSSH
 
EXIT

