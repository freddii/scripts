#!/bin/bash
#speak text
Test=$1
pico2wave --lang=de-DE --wave=/tmp/speak.wav "$Test" && aplay /tmp/speak.wav && rm /tmp/speak.wav