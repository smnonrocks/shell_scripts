#!/bin/bash
##########################################################################################
# Created By     : SUBHANKAR NEOGI
# Coder          : SUBHANKAR NEOGI
# Create Date    : 17/10/13
# Purpose        : TO MIGRATE V3 DATA IN V5
# Version Number : 1
# Modified By           Date              Purpose
# Subhankar Neogi	18/10/2013	  table addition
# Subhankar Neogi	09/12/2013	  Table Addition
# Subhankar Neogi	30/12/2013	  Table Addition
# Subhankar Neogi	30/12/2013	  Removing controll charecter
# Subhankar Neogi	07/02/2014	  forcemap table addition
##########################################################################################
c=0
ssh oracle@x.x.x.x << ENDSSH
	echo "EXEC sp_Export ('TBL_MST_ENTITY','UGM','tbl_mst_entity.txt','~');" | sqlplus trip/trip@gpstrn
	echo "EXEC sp_Export ('TBL_MONTH_SERVICE','SUBSC','tbl_month_service.txt','~');" | sqlplus trip/trip@gpstrn
	echo "EXEC sp_Export ('TBL_LOCATION_MASTER','TRIP','tbl_location_master.txt','~');" | sqlplus trip/trip@gpstrn
	echo "EXEC sp_Export ('TBL_ENTITY_LOCATION_MAPPING','TRIP','tbl_entity_location_mapping.txt','~');" | sqlplus trip/trip@gpstrn
	echo "EXEC sp_Export ('TBL_DRIVER_LIST','UGM','tbl_driver_list.txt','~');" | sqlplus trip/trip@gpstrn
	echo "EXEC sp_Export ('TBL_MST_ENTITY_USER','UGM','tbl_mst_entity_user.txt','~');" | sqlplus trip/trip@gpstrn
	echo "EXEC sp_Export ('TBL_NEW_ROLE','UGM','tbl_new_role.txt','~');" | sqlplus ugm/ugm@gpstrn
	echo "EXEC sp_Export ('TBL_NEW_MODULE','UGM','tbl_new_module.txt','~');" | sqlplus trip/trip@gpstrn
	echo "EXEC sp_Export ('TBL_NEW_SERVICES','UGM','tbl_new_services.txt','~');" | sqlplus trip/trip@gpstrn
	echo "EXEC sp_Export ('TBL_NEW_ROLE_SERVICE','UGM','tbl_new_role_service.txt','~');" | sqlplus trip/trip@gpstrn
	echo "TRUNCATE TABLE tbl_Model_v3;" | sqlplus subsc/subsc@gpstrn
	echo "INSERT INTO tbl_Model_v3 SELECT s_product_id,c_version,s_model_ver,i_port_no FROM tbl_stock_lab;" | sqlplus subsc/subsc@gpstrn
	echo "EXEC sp_Export ('TBL_MODEL_V3','SUBSC','tbl_stock_lab.txt','~');"| sqlplus trip/trip@gpstrn
	echo "EXEC sp_Export ('TBL_MAINTAIN','TRIP','tbl_maintain.txt','~');"| sqlplus trip/trip@gpstrn
	echo "EXEC sp_Export ('TBL_AMC_ACTIVITY','SUBSC','tbl_amc_activity.txt','~');"| sqlplus trip/trip@gpstrn
	echo "EXEC TRIP.SP_MIGRATION;"| sqlplus trip/trip@gpstrn
	
	cd /oracle01/oracle/v2/reports/db_process_log/
	cp tbl_mst_entity.txt v3_migration/tbl_mst_entity.txt
	cp tbl_month_service.txt v3_migration/tbl_month_service.txt
	cp tbl_location_master.txt v3_migration/tbl_location_master.txt
	cp tbl_entity_location_mapping.txt v3_migration/tbl_entity_location_mapping.txt
	cp tbl_driver_list.txt v3_migration/tbl_driver_list.txt
	cp tbl_mst_entity_user.txt v3_migration/tbl_mst_entity_user.txt
	cp tbl_new_role.txt v3_migration/tbl_new_role.txt
	cp tbl_new_module.txt v3_migration/tbl_new_module.txt
	cp tbl_new_services.txt v3_migration/tbl_new_services.txt
	cp tbl_new_role_service.txt v3_migration/tbl_new_role_service.txt
	cp tbl_stock_lab.txt  v3_migration/tbl_stock_lab.txt
	cp tbl_maintain.txt v3_migration/tbl_maintain.txt
	cp tbl_amc_activity.txt v3_migration/tbl_amc_activity.txt
	cp tbl_force_map.csv v3_migration/tbl_force_map.csv
	
	rm -fr /oracle01/oracle/v2/reports/db_process_log/v3_migration.zip
	zip -r v3_migration.zip v3_migration
	# tar -cvf v3_migration.tar v3_migration
ENDSSH

scp oracle@X.X.X.X:/oracle01/oracle/v2/reports/db_process_log/v3_migration.zip /opt/PostgresPlus/9.1AS/Desktop/flat_file

cd /opt/PostgresPlus/9.1AS/Desktop/flat_file
unzip -o v3_migration.zip
cd /opt/PostgresPlus/9.1AS/Desktop/flat_file/v3_migration
cp tbl_mst_entity.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_mst_entity.txt
cp tbl_month_service.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_month_service.txt
cp tbl_location_master.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_location_master.txt
cp tbl_entity_location_mapping.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_entity_location_mapping.txt
cp tbl_driver_list.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_driver_list.txt
cp tbl_mst_entity_user.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_mst_entity_user.txt
cp tbl_new_role.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_new_role.txt
cp tbl_new_module.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_new_module.txt
cp tbl_new_services.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_new_services.txt
cp tbl_new_role_service.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_new_role_service.txt
cp tbl_stock_lab.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_stock_lab.txt
cp tbl_maintain.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_maintain.txt
cp tbl_amc_activity.txt /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_amc_activity.txt
cp tbl_force_map.csv /opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_force_map.csv

cd /opt/PostgresPlus/9.1AS/Desktop/flat_file
tr -cd '\11\12\15\40-\176' < tbl_mst_entity.txt > tbl_mst_entity_tmp.txt
rm -fr tbl_mst_entity.txt 
mv tbl_mst_entity_tmp.txt tbl_mst_entity.txt
tr -cd '\11\12\15\40-\176' < tbl_month_service.txt > tbl_month_service_tmp.txt 
rm -fr tbl_month_service.txt 
mv tbl_month_service_tmp.txt tbl_month_service.txt
tr -cd '\11\12\15\40-\176' < tbl_location_master.txt > tbl_location_master_tmp.txt
rm -fr tbl_location_master.txt 
mv tbl_location_master_tmp.txt tbl_location_master.txt
tr -cd '\11\12\15\40-\176' < tbl_entity_location_mapping.txt > tbl_entity_location_mapping_tmp.txt 
rm -fr tbl_entity_location_mapping.txt 
mv tbl_entity_location_mapping_tmp.txt tbl_entity_location_mapping.txt
tr -cd '\11\12\15\40-\176' < tbl_driver_list.txt > tbl_driver_list_tmp.txt 
rm -fr tbl_driver_list.txt 
mv tbl_driver_list_tmp.txt tbl_driver_list.txt
tr -cd '\11\12\15\40-\176' < tbl_mst_entity_user.txt > tbl_mst_entity_user_tmp.txt 
rm -fr tbl_mst_entity_user.txt 
mv tbl_mst_entity_user_tmp.txt tbl_mst_entity_user.txt
tr -cd '\11\12\15\40-\176' < tbl_new_role.txt > tbl_new_role_tmp.txt
rm -fr tbl_new_role.txt
mv tbl_new_role_tmp.txt tbl_new_role.txt
tr -cd '\11\12\15\40-\176' < tbl_new_module.txt > tbl_new_module_tmp.txt
rm -fr tbl_new_module.txt
mv tbl_new_module_tmp.txt tbl_new_module.txt
tr -cd '\11\12\15\40-\176' < tbl_new_services.txt > tbl_new_services_tmp.txt
rm -fr tbl_new_services.txt
mv tbl_new_services_tmp.txt tbl_new_services.txt
tr -cd '\11\12\15\40-\176' < tbl_new_role_service.txt > tbl_new_role_service_tmp.txt
rm -fr tbl_new_role_service.txt
mv tbl_new_role_service_tmp.txt tbl_new_role_service.txt
tr -cd '\11\12\15\40-\176' < tbl_stock_lab.txt > tbl_stock_lab_tmp.txt
rm -fr tbl_stock_lab.txt
mv tbl_stock_lab_tmp.txt tbl_stock_lab.txt
tr -cd '\11\12\15\40-\176' < tbl_maintain.txt > tbl_maintain_tmp.txt
rm -fr tbl_maintain.txt
mv tbl_maintain_tmp.txt tbl_maintain.txt
tr -cd '\11\12\15\40-\176' < tbl_amc_activity.txt > tbl_amc_activity_tmp.txt
rm -fr tbl_amc_activity.txt
mv tbl_amc_activity_tmp.txt tbl_amc_activity.txt

cd /opt/PostgresPlus/9.1AS/Desktop/crons
source psql_env.sh
psql $env <<END
	----------- start of entity migration-----------
	select 'ENTITY MIGRATION STARTED';
	drop table schema_v3.tbl_mst_entity_bak;
	CREATE TABLE schema_v3.tbl_mst_entity_bak AS SELECT * FROM schema_v3.tbl_mst_entity;
	truncate table schema_v3.tbl_mst_entity;
	select schema_v3.Fn_LoadAll('schema_v3.tbl_mst_entity','/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_mst_entity.txt','~');
	SELECT schema_v3.Entity_Control();
	SELECT schema_v3.fn_manual_update();
	SELECT v3_to_v5.fn_entity_population();
	update syn_entity set i_entity_parent_id=100 where i_entity_id=7481;
	
	-------------Start of Month service------------
	select 'MONTH SERVICE MIGRATION STARTED';
	drop table schema_v3.tbl_month_service_bak;
	CREATE TABLE schema_v3.tbl_month_service_bak AS SELECT * FROM schema_v3.tbl_month_service;
	TRUNCATE TABLE schema_v3.tbl_month_service;
	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_month_service','/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_month_service.txt','~');
	SELECT schema_v3.Fn_Month_Service_Map() ;
	SELECT v3_to_v5.fn_month_service_insertion();
	
	-------------Start of NODE ------------
	select 'NODE MIGRATION STARTED';
	DROP TABLE schema_v3.tbl_location_master_bak;
	CREATE TABLE schema_v3.tbl_location_master_bak AS SELECT * FROM schema_v3.tbl_location_master;
	TRUNCATE TABLE schema_v3.tbl_location_master;
	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_location_master',
	'/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_location_master.txt','~');
	SELECT schema_v3.fn_location_master_map();
	SELECT v3_to_v5.fn_actual_master_data_population();
	
	-------------Start of Entity Node------------
	select 'ENTITY NODE MIGRATION STARTED';
	DROP TABLE schema_v3.tbl_entity_location_mapping_bak;
	CREATE TABLE schema_v3.tbl_entity_location_mapping_bak AS SELECT * 
	FROM schema_v3.tbl_entity_location_mapping;
	TRUNCATE TABLE schema_v3.tbl_entity_location_mapping;
	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_entity_location_mapping',
	'/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_entity_location_mapping.txt','~');
	SELECT schema_v3.fn_Entity_Node_Map();
	SELECT v3_to_v5.fn_entity_node_map_population();
			
	-------------Start of Asset Driver------------
	select 'ASSET DRIVER MIGRATION STARTED';
	drop table schema_v3.tbl_driver_list_bak;
	CREATE TABLE schema_v3.tbl_driver_list_bak AS SELECT * FROM schema_v3.tbl_driver_list;
	TRUNCATE TABLE schema_v3.tbl_driver_list;
	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_driver_list','/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_driver_list.txt','~');
	SELECT schema_v3.fn_asset_driver_map();
	SELECT schema_v3.Fn_AssetDriver_Update();
	
	-------------Start of User Table------------
	select 'USER MIGRATION STARTED';
	DROP TABLE schema_v3.tbl_mst_entity_user_bak;
	CREATE TABLE schema_v3.tbl_mst_entity_user_bak AS SELECT * FROM schema_v3.tbl_mst_entity_user;
    	TRUNCATE TABLE schema_v3.tbl_mst_entity_user;
    	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_mst_entity_user',
    	'/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_mst_entity_user.txt','~');
    	select schema_v3.fn_mst_entity_user_map ();
    	select schema_v3.fn_create_new_user();
    	--SELECT v3_to_v5.fn_user_population ();
    	
	-------------Start of Role Table------------
	select 'ROLE MIGRATION STARTED';
	DROP TABLE schema_v3.tbl_new_role_bak;
    	CREATE TABLE schema_v3.tbl_new_role_bak AS SELECT * FROM schema_v3.tbl_new_role;
    	TRUNCATE TABLE schema_v3.tbl_new_role;
    	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_new_role','/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_new_role.txt','~');
    		
	-------------Start of Module Table------------
	select 'MODULE MIGRATION STARTED';
	DROP TABLE schema_v3.tbl_new_module_bak;
	CREATE TABLE schema_v3.tbl_new_module_bak AS SELECT * FROM schema_v3.tbl_new_module;
	TRUNCATE TABLE schema_v3.tbl_new_module;
	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_new_module','/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_new_module.txt','~');
	
	-------------Start of Service Table------------
	select 'SERVICE MIGRATION STARTED';
	DROP TABLE schema_v3.tbl_new_services_bak;
	CREATE TABLE schema_v3.tbl_new_services_bak AS SELECT * FROM schema_v3.tbl_new_services;
	TRUNCATE TABLE schema_v3.tbl_new_services;	
	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_new_services','/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_new_services.txt','~');
	
	-------------Start of Role Service Table------------
	select 'ROLE SERVICE MIGRATION STARTED';    	
    	DROP TABLE schema_v3.tbl_new_role_service_bak;
	CREATE TABLE schema_v3.tbl_new_role_service_bak AS SELECT * FROM schema_v3.tbl_new_role_service;
	TRUNCATE TABLE schema_v3.tbl_new_role_service;
	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_new_role_service',
	'/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_new_role_service.txt','~');
	
	-------------Start of Accident/Break Down/maintainence ------------
	select 'Accident/Break Down/maintainence MIGRATION STARTED';
	DROP TABLE  SCHEMA_V3.TBL_MAINTAIN_BAK;
	CREATE TABLE SCHEMA_V3.TBL_MAINTAIN_BAK AS SELECT * FROM SCHEMA_V3.TBL_MAINTAIN; 
	TRUNCATE TABLE SCHEMA_V3.TBL_MAINTAIN;
	select schema_v3.Fn_LoadAll('schema_v3.tbl_maintain','/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_maintain.txt','~');
	SELECT SCHEMA_V3.FN_MAINTAIN_MAP_POPULATE ();
	TRUNCATE V4TRIP.TBL_MAINTAIN;
	INSERT INTO V4TRIP.TBL_MAINTAIN(I_MAINTAIN_SEQ,I_ENTITY_ID,I_ENTITY_TYPE,S_ASSET_ID,DT_START,DT_END,C_VEHICLE_STATUS,C_IS_ACTIVE)
	SELECT I_MAINTAIN_SEQ,I_ENTITY_ID,I_ENTITY_TYPE,S_ASSET_ID,DT_START,DT_END,C_VEHICLE_STATUS,C_IS_ACTIVE
	FROM SCHEMA_V3.TBL_MAINTAIN_MAP;
	
	-------------Start of tbl_stock_lab ------------
	select 'tbl_stock_lab MIGRATION STARTED';
	DROP TABLE schema_v3.tbl_stock_lab_bak;
	CREATE TABLE schema_v3.tbl_stock_lab_bak AS SELECT * FROM schema_v3.tbl_stock_lab;
	TRUNCATE TABLE schema_v3.tbl_stock_lab;
	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_stock_lab',
	'/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_stock_lab.txt','~');
	------------Start of AMC ACTIVITY ------------
	select 'AMC ACTIVITY MIGRATION STARTED';
	DROP TABLE schema_v3.tbl_amc_activity_bak;
	CREATE TABLE schema_v3.tbl_amc_activity_bak as select * from schema_v3.tbl_amc_activity;
	TRUNCATE TABLE schema_v3.tbl_amc_activity;
	SELECT schema_v3.Fn_LoadAll('schema_v3.tbl_amc_activity',
	'/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_amc_activity.txt','~');	
	SELECT schema_v3.fn_amc_activity ();
	------------Start of FORCE MAP ------------
	Select 'FORCE MAP ACTIVITY MIGRATION STARTED';
	DROP TABLE schema_v3.tbl_force_map_bak;	
	CREATE TABLE schema_v3.tbl_force_map_bak AS SELECT * FROM schema_v3.tbl_force_map;
	TRUNCATE TABLE schema_v3.tbl_force_map;
	SELECT schema_v3.Import_All('schema_v3.tbl_force_map','s_entity_id,s_lov,c_is_deleted',
	'/opt/PostgresPlus/9.1AS/Desktop/flat_file/tbl_force_map.csv');	
	SELECT schema_v3.Fn_Update_Entity_Association();    	
    	
END
echo "------------MIGRATAION COMPLETED SUCCESSFULLY IN DEVELOPMENT WILL TAKE SOME TIME FOR INTEGRATION POPULATION---------------------"

