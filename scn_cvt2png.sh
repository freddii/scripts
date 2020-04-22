#!/bin/bash
STR=`date +%s`
scanimage --mode Color --resolution 150 --progress > ~/Desktop/$STR.pnm
pnmtopng ~/Desktop/$STR.pnm > ~/Desktop/$STR.png
rm ~/Desktop/$STR.pnm
