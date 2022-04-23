###################################################################
#Script Name : cron.sh
#Description : Script that creates a cron job for the backup script to run every midnight.
#Author : Sahana Sreedhar
#Version : 1.0
#Usage : ./cron.sh
###################################################################

#!/bin/sh

# Copy Current Crontab file to another temporary file cron_bkp
sudo crontab -l > cron_bkp

# Add new cronjob to the temporary file
# Check if the backup script is present at the location /opt
# The cron needs to run at midnight hence it will be set as '0 0 * * *'
sudo echo "0 0 * * * sudo /opt/backup.sh >/dev/null 2>&1" >> cron_bkp

# Update crontab
sudo crontab cron_bkp

# Delete the temporary file since we don't need it
sudo rm cron_bkp
