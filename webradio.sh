#!/bin/bash
declare ‑A SENDER
SENDER["Hellweg Radio"]="http://87.118.64.215:8000/"
SENDER["Rock Antenne"]="http://mp3.webradio.rockantenne.de:80"
SENDER["Bayern 3"]="http://gffstream.ic.llnwd.net/stream/gffstream_w12b"
SENDER["Radio Berlin"]="http://rbb.ic.llnwd.net/stream/rbb_radioberlin_mp3_m_b"
SENDER["Musicalradio"]="http://mp3.musicalradio.de/musicalradio.mp3"

clear
echo "Radiosender auswählen:"

select ENTRY in "${!SENDER[@]}"; do
  TITLE="${ENTRY}"
  URL=${SENDER[${ENTRY}]}
  ffplay ‑x 300 ‑y 100 ‑window_title "${TITLE}" ${URL} &>/dev/null
done
