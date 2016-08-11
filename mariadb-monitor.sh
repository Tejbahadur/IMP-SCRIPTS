#!/bin/sh
SERVICE='httpd'
 
if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
    echo "$SERVICE service running, everything is fine"
else
    attemptcount=0
    while [ $attemptcount -lt 3 ]
    do
	echo "$SERVICE is not running"
	service $SERVICE start
	if ps ax | grep -v grep | grep $SERVICE > /dev/null
	then
		echo "$SERVICE service restarted and running, everything is fine"
		echo "$SERVICE is restarted!" | mail -s "$SERVICE is restarted" tejbahadur.singh@clique.sg
		break
	else
	   attemptcount=`expr $attemptcount + 1`
	fi
	
	if [ $attemptcount -eq 3 ]
	then
		service $SERVICE restart		   	
		if ps ax | grep -v grep | grep $SERVICE > /dev/null
		then
	    		echo "whole service restarted and running, everything is fine"
		else
			echo "$SERVICE is not running!" | mail -s "$SERVICE is down" tejbahadur.singh@clique.sg
		fi

	fi
    done
fi
