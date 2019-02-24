#!/bin/sh                                                                                                                                

# This script shows using several
# effects in combination to normalise and trim voice recordings that                                                                   
# may have been recorded using different microphones, with differing                                                                   
# background noise etc.                                                                                                                   

#http://auto-console.com/questions/5872/mussen-mit-sox-sound-noise-saubern

set -eu

SOX=/usr/bin/sox

if [ $# -lt 2 ]; then
  echo "Usage: $0 infile outfile"
  exit 1
fi

$SOX $1 -n trim 0 0.5  noiseprof /tmp/newprofile
$SOX $1 "$2" noisered /tmp/newprofile
rm -f /tmp/newprofile

#xdg-open "$2"