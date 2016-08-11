# IMP-SCRIPTS
This repo currently maintains two important script.

#backup_all_db.sh
This script needs the username and password of database and it will backup all mysql tables

#mardb-service-monitor.sh
This script will monitor mariadb  service on centos. If that service is down then it will try to restart that service and if it fails 3 times to start  that service then it will restart php-fpm,nginx and start the mariadb service. In this statement also if it fails then it will mail the service down issue to specified members
