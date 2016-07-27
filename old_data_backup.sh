#!/bin/bash
##########################################################################################
# Created By     : SUBHANKAR NEOGI
# Coder          : SUBHANKAR NEOGI
# Create Date    : 14/12/13
# Purpose        : TO TAKE DUMP AND OF CURRENT DATA BACKUP IN DEVELOPMENT
# Version Number : 1
# Modified By           Date              Purpose
# Subhankar Neogi	30/12/2013	  Table Addition
#
##########################################################################################
 echo "########################################################################"
 echo "####		PREPAREING OLD DATA BACKUP OF DEVELOPMENT          #####"
 echo "########################################################################"
 #rm -fr /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup
 NOW=$(date +"%d-%m-%Y")
 NOWT=$(date +"%T")
 BACKUP_FOLDER="$NOW$NOWT"
 echo "BACKUP FOLDER HAS CREATED WITH NAME $BACKUP_FOLDER in location /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup"
 mkdir /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER
 #mkdir /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup
 
 pg_dump -a --format=plain --table=v4reg.tbl_entity --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_entity.sql
 pg_dump -a --format=plain --table=v4map.tbl_node --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_node.sql 
 pg_dump -a --format=plain --table=v4reg.tbl_entity --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_entity.sql 
 pg_dump -a --format=plain --table=v4reg.tbl_asset_driver --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_asset_driver.sql 
 pg_dump -a --format=plain --table=v4reg.tbl_user --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_user.sql 
 pg_dump -a --format=plain --table=v4ugm.tbl_role --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_role.sql 
 pg_dump -a --format=plain --table=v4ugm.tbl_module --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_module.sql 
 pg_dump -a --format=plain --table=v4ugm.tbl_service --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_service.sql 
 pg_dump -a --format=plain --table=v4ugm.tbl_role_service --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_role_service.sql 
 pg_dump -a --format=plain --table=v4trip.tbl_maintain --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_maintain.sql 
 pg_dump -a --format=plain --table=v4stock.tbl_lab_stock --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_lab_stock.sql
 pg_dump -a --format=plain --table=v4stock.tbl_lab_stock --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_amc_activity.sql
  pg_dump -a --format=plain --table=v4ugm.tbl_user_role --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_user_role.sql
  pg_dump -a --format=plain --table=schema_v3.tbl_mst_entity_user_map --inserts --attribute-inserts etrans > /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER/tbl_mst_entity_user_map.sql
  
  echo "TACKING OLDA DATA BACKUP HAS COMPLEATED TO CHECK IT PLESE FIND /opt/PostgresPlus/9.1AS/Desktop/Old_data_backup/$BACKUP_FOLDER derectery for detail"
 exit
 
