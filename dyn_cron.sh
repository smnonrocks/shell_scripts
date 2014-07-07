#!/bin/bash
##########################################################################################
# Created By     : SUBAHNAKR NEOGI
# Coder		 : PRADIPTA PAUL
# Create Date    : 26/03/14
# Purpose        : To populate table v4track.tbl_daily_gps_status 
# Version Number : 1
# Modified By           Date              Purpose
# 
#
##########################################################################################
rm /home/subhankar/Desktop/my_cron.txt
crontab -l > /home/subhankar/Desktop/my_cron.txt
echo "* * * * * /home/subhankar/Desktop/create_folder.sh" >> /home/subhankar/Desktop/my_cron.txt
line1=$(cat /home/subhankar/Desktop/my_cron.txt | grep create_folder.sh)
sed -i '/create_folder.sh/d' /home/subhankar/Desktop/my_cron.txt 
echo "#$line1" >> /home/subhankar/Desktop/my_cron.txt
echo "crontab set"
line1=$(cat /home/subhankar/Desktop/my_cron.txt | grep screen.sh)
sed -i '/screen.sh/d' /home/subhankar/Desktop/my_cron.txt 
line1=${line1//#/}
echo "$line1"
echo "$line1" >>/home/subhankar/Desktop/my_cron.txt
crontab /home/subhankar/Desktop/my_cron.txt
#rm my_cron


* * * * * /opt/etrans/cronjobs/run_gps.sh > /opt/etrans/cronlog/run_gps.log 2>&1
