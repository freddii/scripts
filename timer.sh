#!/bin/bash
#
REMINDER=`zenity --entry --title="Timer" \
 --text="What should I do?"`
WAIT=`zenity --entry --title="Timer" \
 --text="In how many seconds should i do this?"`
sleep "$WAIT"
zenity --info --title="Timer" --text="$REMINDER"