#!/bin/bash
declare -A SENDER
SENDER["Hellweg Radio"]="http://87.118.64.215:8000/"
SENDER["Rock Antenne"]="http://mp3.webradio.rockantenne.de:80"
SENDER["Bayern 3"]="http://gffstream.ic.llnwd.net/stream/gffstream_w12b"
SENDER["Radio Berlin"]="http://rbb.ic.llnwd.net/stream/rbb_radioberlin_mp3_m_b"
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