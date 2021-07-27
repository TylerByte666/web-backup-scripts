#!/bin/bash 
################################################################
##
##   HTML File Backup Script 
##   Written By: Tyler Geyser
##
################################################################ 
TODAY=`date +"%d%b%Y"`
################################################################
################## Update below values  ######################## 
HTML_BACKUP_PATH='/var/backups'
HTML_BACKUP_SRC='/var/www/html'
APP_NAME='myApp'
BACKUP_RETAIN_DAYS=120   ## Number of days to keep local backup copy
LOGFILE_NAME = 'html_backup_log'
LOGFILE="${HTML_BACKUP_PATH}/log/${LOGFILE_NAME}_$(date +'%Y_%m')".log
#################################################################

mkdir -p ${HTML_BACKUP_PATH}/${TODAY}
echo "Backup started for html files @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
echo "Backup retention: ${BACKUP_RETAIN_DAYS} days" >> "$LOGFILE"

cd ${HTML_BACKUP_PATH}/${TODAY}
tar -czf ${APP_NAME}-${TODAY}.tar.gz ${HTML_BACKUP_SRC}


echo "HTML backup successfully completed @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
echo "********************************************************************" >> "$LOGFILE"


##### Remove backups older than {BACKUP_RETAIN_DAYS} days  #####
 
DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`
 
if [ ! -z ${HTML_BACKUP_PATH} ]; then
      cd ${HTML_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
            echo "Deleted older backup: ${DBDELDATE} @ $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOGFILE"
            echo "********************************************************************" >> "$LOGFILE"
      fi
fi
 
### End of script ####