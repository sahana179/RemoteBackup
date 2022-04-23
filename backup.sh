###################################################################
#Script Name : backup.sh
#Description : Script that makes an incremental backup of the user's home directory using rsync and runs every midnight.
#Author : Sahana Sreedhar
#Version : 1.0
#Usage : ./backup.sh
###################################################################


#!/bin/bash
# A script to perform incremental backups using rsync
set -eu pipefail
readonly SOURCE_DIR=$HOME
readonly BACKUP_DIR=/tmp/backup
readonly BACKUP_HOST="backup_server"

#Banner function to show the start and stop of script.
banner(){
echo "+------------------------------------------+"
printf "| %-40s |\n" "`date`"
echo "| |"
printf "| %-40s |\n" "$@"
echo "+------------------------------------------+"
}

#To check if the Source and Destination servers have ssh connection
ssh_check(){
ssh -q -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 backup1 'exit 0'
if [ "$?" -ne 0 ]
then
echo "Setup connection with the remote server"
else
echo "Connection Successful"
fi
}

#Create the backup directory on the remote server if it does not exists
dircheck(){
if [ ! -d $BACKUP_DIR ]
then
ssh backup "mkdir -p $BACKUP_DIR"
else
echo "$BACKUP_DIR directory exists"
fi
}

#Create backup using rsync
main(){
ssh_check
dircheck
banner "Backup Started....."
rsync -avz $SOURCE_DIR $BACKUP_HOST:$BACKUP_DIR
banner "Backup Completed!!!!"
}

#Calling main function which calls other functions inside it
main