#!/bin/bash
if [ $(date +"%k") -lt 23 ]
then
#echo "smaller 22"
        if [ $(date +"%k") -gt 5 ]
        then
#        echo "fits"
	/home/fred/create_date_text.sh && /home/fred/pico_speak.sh "$(cat /home/fred/speaktest)"
#        else
#        echo "error < 5"
        fi
#else
#echo "error > 22"
fi
#
# this script will not work from 22:00 -6:00 
