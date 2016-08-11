#!/bin/sh
SERVICE='mariadb'

while true
do
	if [ "`systemctl is-active $SERVICE`" != "active" ]
	then
	    attemptcount=0
	    while [ $attemptcount -lt 3 ]
	    do
	        #echo "$SERVICE is not running"
	        systemctl start $SERVICE.service
	        if [ "`systemctl is-active $SERVICE`" = "active" ]
	        then
	                #echo "$SERVICE service restarted and running, everything is fine"
	                echo "$SERVICE service is restarted!" | mail -s "$SERVICE service is restarted" tejbahadur.singh@clique.sg prashant.kawe@clique.sg nikhil.karmokar@clique.sg 
	                break
	        else
	           attemptcount=`expr $attemptcount + 1`
	        fi

	        if [ $attemptcount -eq 3 ]
	        then
	                systemctl restart php-fpm.service
			systemctl restart nginx.service
			systemctl start $SERVICE.service
	                if [ "`systemctl is-active $SERVICE`" = "active" ]
	                then
	                        #echo "whole service restarted and running, everything is fine"
				echo "$SERVICE ,php-fpm, mariadb are restarted!" | mail -s "whole service is restarted" tejbahadur.singh@clique.sg prashant.kawe@clique.sg nikhil.karmokar@clique.sg
	                else
	                        echo "$SERVICE is not running!" | mail -s "$SERVICE is down" tejbahadur.singh@clique.sg prashant.kawe@clique.sg nikhil.karmokar@clique.sg
	                fi
	        fi
	    done
	fi
	sleep 5
done
