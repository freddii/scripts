#!/bin/bash

#crontab -e
#*/15 * * * * /home/xxfreddyxx/.local/bin/talking-clock.sh >/dev/null 2>&1
#*/15 * * * * /home/xxfreddyxx/talking-clock/talking-clock.sh >/dev/null 2>&1

weatherurl=https://www1.wdr.de/wetter/wettervorhersage/wetter_nrw_ea100~_eam-fd15f2da32f7fc440a5f751f30d05d71.html?eap=8oI34N4hym4RDV6dhKK0OnLYM%2FNzIoiKEQqHYZPZjFxpkU74v6xP%2Bd7htYRzReo%2BbDdl5sZUTmCuC2OmskTACpK2C4%2FEK5EjugWLsGnWIGP7RItF29dM8y8lfx2S07vkwDj%2BdptBvBj0lq3Fm%2BG8vwHbBYF%2BViPb
sleep_at_night=true

create_date_hour()
{
declare -i day_of_month
day_of_month=$(date +"%e")
STRING=""
rm /tmp/speech.txt
echo "es ist" >>/tmp/speech.txt
(date +"%A") >>/tmp/speech.txt
echo "der" >>/tmp/speech.txt
if [ $day_of_month = 1 ];
    then
        STRING="erste"
elif [ $day_of_month = 3 ];
    then
        STRING="dritte"
elif [ $day_of_month = 7 ];
    then
        STRING="siebte"
else
    STRING=$day_of_month"te"
fi
echo $STRING >>/tmp/speech.txt
(date +"%B") >>/tmp/speech.txt
echo " " >>/tmp/speech.txt
echo Uhrzeit: >>/tmp/speech.txt
(date +"%k") >>/tmp/speech.txt
echo Uhr >>/tmp/speech.txt
(date +"%M") >>/tmp/speech.txt
}


create_temperature()
{
###Maximaltemperatur heute###
echo " " >>/tmp/speech.txt
echo "Maximaltemperatur heute:" >>/tmp/speech.txt
# for essen (germany)
weatherpage="$(curl $weatherurl)"
maxtemptoday=$(echo "$weatherpage" | sed '/<td class="forecast-1" headers="max-temp forecast-1">/,$d' | sed -n '/<td class="forecast-0" headers="max-temp forecast-0">/,$p' | sed 's/<\/td><td class="forecast-0" headers="max-temp forecast-0">//g' | sed 's/<abbr title="Grad Celsius"> &deg\;C<\/abbr>/ Grad/g')
echo $maxtemptoday >>/tmp/speech.txt
#
###Maximaltemperatur morgen###
echo " " >>/tmp/speech.txt
echo "morgen:" >>/tmp/speech.txt
maxtemptomorrow=$(echo "$weatherpage" | sed '/<td class="forecast-2" headers="max-temp forecast-2">/,$d' | sed -n '/<td class="forecast-1" headers="max-temp forecast-1">/,$p' | sed 's/<\/td><td class="forecast-1" headers="max-temp forecast-1">//g' | sed 's/<abbr title="Grad Celsius"> &deg\;C<\/abbr>/ Grad/g')
echo $maxtemptomorrow >>/tmp/speech.txt
#
###Maximaltemperatur uebermorgen###
echo " " >>/tmp/speech.txt
echo "übermorgen:" >>/tmp/speech.txt
maxtemdayaftertomorrow=$(echo "$weatherpage" | sed '/<td class="forecast-3" headers="max-temp forecast-3">/,$d' | sed -n '/<td class="forecast-2" headers="max-temp forecast-2">/,$p' | sed 's/<\/td><td class="forecast-2" headers="max-temp forecast-2">//g' | sed 's/<abbr title="Grad Celsius"> &deg\;C<\/abbr>/ Grad/g')
echo $maxtemdayaftertomorrow >>/tmp/speech.txt

}


pico_speak()
{
pico2wave -l=de-DE -w=/tmp/speak.wav "$1"
aplay /tmp/speak.wav
rm /tmp/speak.wav
}


if [ "$sleep_at_night" = true ]
        then
# this snippet will not work from 22:00 -6:00
        if [ $(date +"%k") -lt 23 ]
        then
                if [ $(date +"%k") -gt 5 ]
                then
                create_date_hour && create_temperature && pico_speak "$(cat /tmp/speech.txt)"
                fi
        fi
else
        create_date_hour && create_temperature && pico_speak "$(cat /tmp/speech.txt)"
fi
#
