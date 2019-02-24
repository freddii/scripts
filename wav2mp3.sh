#!/bin/bash
# got it from https://github.com/braindef/installation-scripts/
for i in *.wav; do lame -b 320 -h "${i}" "${i%.wav}.mp3" & done