#!/bin/bash
declare -A SENDER
SENDER["WDR2"]="http://wdr-wdr2-rheinland.icecast.wdr.de/wdr/wdr2/rheinland/mp3/128/stream.mp3"
SENDER["WDR5"]="http://wdr-wdr5-live.icecast.wdr.de/wdr/wdr5/live/mp3/128/stream.mp3"
SENDER["Rock Antenne"]="http://mp3.webradio.rockantenne.de:80"
SENDER["Musicalradio"]="http://mp3.musicalradio.de/musicalradio.mp3"
SENDER["Radio Swiss Jazz"]="http://stream.srg-ssr.ch/rsj/mp3_128.m3u"
SENDER["lautFM JazzLoft"]="http://stream.laut.fm/jazzloft"
SENDER["lautFM EuroSmoothJazz"]="http://stream.laut.fm/eurosmoothjazz"

clear
echo "Sender wählen:"

select ENTRY in "${!SENDER[@]}"; do
  TITLE="${ENTRY}"
  echo "es wird gespielt:" ${TITLE}
  echo "Neuer Sender: STRG+C und dann neue Nummer wählen"
  URL=${SENDER[${ENTRY}]}
  cvlc ${URL} &>/dev/null
done