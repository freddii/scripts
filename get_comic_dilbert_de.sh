###########################################################################
##                                                                       ##
##                  Download German Dilbert Comic Strip                  ##
##                                                                       ##
## Creation:    15.07.2012                                               ##
## Last Update: 04.06.2019                                               ##
##                                                                       ##
## Copyright (c) 2012-2019 by Georg Kainzbauer <http://www.gtkdb.de>     ##
##                                                                       ##
## This program is free software; you can redistribute it and/or modify  ##
## it under the terms of the GNU General Public License as published by  ##
## the Free Software Foundation; either version 2 of the License, or     ##
## (at your option) any later version.                                   ##
##                                                                       ##
###########################################################################
#!/bin/bash

# Local directory to store the comic strip
#DIR=/var/www/html/comics/Dilbert_DE/
DIR=$HOME/Documents/Dilbert_DE/

# Who will be informed in case of new comic strip is available
# MAIL="georg@home.lan"

# Mail subject
SUBJECT="Neuer Dilbert Comic Strip"

# Web server URL
URL=https://www.ingenieur.de/unterhaltung/dilbert/

# URL of the comic strip
#IMGURL=$(/usr/bin/wget -q ${URL} -O - 2>/dev/null | /bin/grep -i "src=\"https://www.ingenieur.de/wp-content/uploads/" | /usr/bin/head -n1 | /bin/cut -d\" -f6)
IMGURL=$(wget -q ${URL} -O - 2>/dev/null | /bin/grep -i "src=\"https://www.ingenieur.de/wp-content/uploads/" | head -n1 | cut -d\" -f6)

# File name of the comic strip on the web server
#FILE=$(/bin/echo ${IMGURL} | /bin/cut -d/ -f8)
FILE=$(echo ${IMGURL} | cut -d/ -f8)

###################################################################
# NORMALLY THERE IS NO NEED TO CHANGE ANYTHING BELOW THIS COMMENT #
###################################################################

function log()
  {
    /bin/echo "LOG:" $1
  }

function error()
  {
    /bin/echo "ERROR:" $1
    exit 1
  }

# Check variables
if [ -z "${DIR}"  ] ; then
  error "Please specify the local comic strip directory."
fi

if [ -z "${URL}" ] ; then
  error "Please specify the web server URL."
fi

if [ -z "${IMGURL}" ] ; then
  error "Please specify the image URL."
fi

if [ -z "${FILE}" ] ; then
  error "Please specify the file name on the web server."
fi

# Create local comic strip directory if it does not exist
if [ ! -d ${DIR} ] ; then
  log "Creating local comic strip directory ${DIR}."
  /bin/mkdir -p ${DIR}
fi

# Check for new comic strip
if [ -f "${DIR}${FILE}" ] ; then
  log "No new comic strip found."
  /usr/bin/notify-send --icon=${DIR}${FILE} "No new comic strip found."
  exit 0
else
  log "Downloading new comic strip from the web server."
  /usr/bin/wget -q "${IMGURL}" -P ${DIR}

  if [ -f "${DIR}${FILE}" ] ; then
    log "Download successful."
#    if [ -n "${MAIL}" ] ; then
#      log "Sending new comic strip to the mailing list."
#      /usr/bin/mutt -s "${SUBJECT}" -a "${DIR}${FILE}" -- ${MAIL} < /dev/null;
#    fi
	/usr/bin/notify-send --icon=${DIR}${FILE} "new dilbert comic"
	#xdg-open ${DIR}${FILE}
  else
    error "Download failed."
  fi
fi

exit 0