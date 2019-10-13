#!/bin/bash

#based on https://fredfire1.wordpress.com/2017/03/19/setup-a-rpi-image-for-burning-on-linux-raspberrypi/

#file -s 20*raspbian-*lite.img #to check if the startsectors in later code still fit

cd ~/Downloads
sx=$(file -s 20*raspbian-*lite.img | grep -oP 'startsector \w+' | sed 's/.*startsector //' | head -1)
#sy=$(file -s 20*raspbian-*lite.img | grep -oP 'startsector \w+' | sed 's/.*startsector //' | tail -1)

sudo mkdir -p /mnt/sda2
cd ~/Downloads
sudo mount 20*raspbian-*lite.img /mnt/sda2 -o offset=$((sx*512))
cd /mnt/sda2/
sudo touch ssh
cd
sudo umount /mnt/sda2
#cd ~/Downloads
#sudo mount 20*raspbian-*lite.img /mnt/sda2 -o offset=$((sy*512))
#cd /mnt/sda2/etc/wpa_supplicant/
#sudo nano wpa_supplicant.conf

#echo 'now add your wlan at the end like:'
#echo 'network={'
#echo 'ssid="YOUR_WLAN_SSID"'
#echo 'psk="YOUR_WLAN_PASSWORD"'
#echo '}'

#echo 'after that unmount the image:'
#echo 'cd'
#echo 'sudo umount /mnt/sda2'
