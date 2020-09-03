#!/bin/bash

# from TuxNix and Mis see https://wiki.archlinux.de
# script under GPLv3 with no garanty at all
# https://wiki.archlinux.de/title/Live-Tv

script_path="$(dirname "$0")"
script_name="$(basename "$0")"
#response=$(zenity --height=640 --width=320 --text 'a simple appimages download gui' --list --checklist \
 #  --title='get-appimages-gui' --column=Selection --column=Task \
#stream_url="$(zenity --title "Live-Tv" --radiolist "Sender wählen und OK drücken!" \
stream_url=$(dialog --stdout --backtitle freddii --title get-appimages-gui \
--checklist "a simple appimages download gui" 0 0 0 \
"https://derste247livede.akamaized.net/hls/live/658317/daserste_de/master.m3u8"   "ARD-Das-Erste"                  off \
"https://brlive-lh.akamaihd.net/i/bralpha_germany@119899/master.m3u8"             "ARD-alpha"                      off \
"https://onelivestream-lh.akamaihd.net/i/one_livestream@568814/master.m3u8"       "ARD-one"                        off \
"https://tagesschau-lh.akamaihd.net/i/tagesschau_3@66339/master.m3u8"             "ARD-Tagesschau24"               off \
"https://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8"             "ARD-Tagesschau24-International" off \
"https://artelive-lh.akamaihd.net/i/artelive_de@393591/master.m3u8"               "Arte-DE"                        off \
"https://artelive-lh.akamaihd.net/i/artelive_fr@344805/master.m3u8"               "Arte-FR"                        off \
"https://brlive-lh.akamaihd.net/i/bfsnord_germany@119898/master.m3u8"             "BR-Nord"                        off \
"https://brlive-lh.akamaihd.net/i/bfssued_germany@119890/master.m3u8"             "BR-Süd"                         off \
"https://brlive-lh.akamaihd.net/i/bfssued_worldwide@119891/master.m3u8"            "BR-Süd-International"           off \
"https://dwstream72-lh.akamaihd.net/i/dwstream72_live@123556/master.m3u8"         "DW"                             off \
"https://dwstream52-lh.akamaihd.net/i/dwstream52_live@500528/master.m3u8"         "DW-Plus"                        off \
"https://dwstream1-lh.akamaihd.net/i/dwstream1_live@120422/master.m3u8"           "DW-English"                     off \
"https://live1_hr-lh.akamaihd.net/i/hr_fernsehen@75910/master.m3u8"               "hr"                             off \
"https://kikageohls-i.akamaihd.net/hls/live/1006268/livetvkika_de/master.m3u8"    "KiKA"                           off \
"https://kikahls-i.akamaihd.net/hls/live/1006267/livetvkika_ww/master.m3u8"       "KiKA-International"             off \
"https://mdrsahls-lh.akamaihd.net/i/livetvmdrsachsenanhalt_de@513999/master.m3u8" "mdr-SA"                         off \
"https://mdrsnhls-lh.akamaihd.net/i/livetvmdrsachsen_de@513998/master.m3u8"       "mdr-S"                          off \
"https://mdrthuhls-lh.akamaihd.net/i/livetvmdrthueringen_de@514027/master.m3u8"   "mdr-T"                          off \
"https://ndrfs-lh.akamaihd.net/i/ndrfs_hh@430231/master.m3u8"                     "NDR-HH"                         off \
"https://ndrfs-lh.akamaihd.net/i/ndrfs_mv@430232/master.m3u8"                     "NDR-MV"                         off \
"https://ndrfs-lh.akamaihd.net/i/ndrfs_nds@430233/master.m3u8"                    "NDR-NDS"                        off \
"https://ndrfs-lh.akamaihd.net/i/ndrfs_sh@430234/master.m3u8"                     "NDR-SH"                         off \
"https://orf1.mdn.ors.at/out/u/orf1/qxb/manifest.m3u8"                            "ORF-1"                          off \
"https://orf2.mdn.ors.at/out/u/orf2/qxb/manifest.m3u8"                            "ORF-2"                          off \
"https://orf2e.mdn.ors.at/out/u/orf2e/qxb/manifest.m3u8"                          "ORF-2-Europe"                   off \
"https://orf3.mdn.ors.at/out/u/orf3/qxb/manifest.m3u8"                            "ORF-3"                          off \
"https://orfs.mdn.ors.at/out/u/orfs/qxb/manifest.m3u8"                            "ORF-Sport-Plus"                 off \
"https://zdf-hls-19.akamaized.net/hls/live/2016502/de/high/master.m3u8"           "phoenix"                        off \
"https://rbblive-lh.akamaihd.net/i/rbb_berlin@144674/master.m3u8"                 "rbb-Berlin"                     off \
"https://rbblive-lh.akamaihd.net/i/rbb_brandenburg@349369/master.m3u8"            "rbb-Brandenburg"                off \
"https://zdf-hls-18.akamaized.net/hls/live/2016501/dach/high/master.m3u8"         "3sat"                           off \
"https://live2_sr-lh.akamaihd.net/i/sr_universal02@107595/master.m3u8"            "SR"                             off \
"https://swrbwhls-i.akamaihd.net/hls/live/667638/swrbwd/master.m3u8"              "SWR-BW"                         off \
"https://swrrphls-i.akamaihd.net/hls/live/667639/swrrpd/master.m3u8"              "SWR-RP"                         off \
"https://wdrfsgeo-lh.akamaihd.net/i/wdrfs_geogeblockt@530016/master.m3u8"         "WDR"                            off \
"https://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/master.m3u8"              "WDR-International"              off \
"https://zdf-hls-15.akamaized.net/hls/live/2016498/de/high/master.m3u8"           "ZDF"                            off \
"https://zdf-hls-17.akamaized.net/hls/live/2016500/de/high/master.m3u8"           "ZDF info"                       off \
"https://zdf-hls-16.akamaized.net/hls/live/2016499/de/high/master.m3u8"           "ZDF neo"                        off)
if(($? == 0)); then
	vlc "${stream_url}"
	exec "${script_path}/${script_name}"
else
	echo "Live-Tv wurde beendet"
fi