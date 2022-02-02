#!/bin/bash
declare -i day_of_month
day_of_month=$(date +"%e")
STRING=""
rm /home/fred/speaktest
echo "es ist" >>/home/fred/speaktest
(date +"%A") >>/home/fred/speaktest
echo "der" >>/home/fred/speaktest
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
echo $STRING >>/home/fred/speaktest
(date +"%B") >>/home/fred/speaktest
echo " " >>/home/fred/speaktest
echo Uhrzeit: >>/home/fred/speaktest
(date +"%k") >>/home/fred/speaktest
echo Uhr >>/home/fred/speaktest
(date +"%M") >>/home/fred/speaktest
#
###aktuelle temperatur###
echo " " >>/home/fred/speaktest
echo Aktuelle Temperatur: >>/home/fred/speaktest
page="$(curl http://wetter.upb.de/handy.html)"
var2=$(echo "$page" | grep Temp: | sed 's/<hr>Temp:<br><b>//g' | sed 's/C<\/b><br>//g')
var2=${var2::-2}
var2=$var2" Grad"
echo $var2 >>/home/fred/speaktest
#
###temperatur heute###
echo " " >>/home/fred/speaktest
echo Maximaltemperatur heute: >>/home/fred/speaktest
page="$(curl www1.wdr.de/themen/infokompakt/wetter/wetter_nrw_ea100_eam-c4642254101f0bd19b08863662d7df79.html?eap=8oI34N4hym4RDV6dhKK0OnLYM%2FNzIoiKEQqHYZPZjFxpkU74v6xP%2Bd7htYRzReo%2BbDdl5sZUTmCuC2OmskTACpK2C4%2FEK5EjugWLsGnWIGP7RItF29dM86HhZLXhrbQ1tnr87UGExI1vtiKNnhRmU2qdGv5kb7wX)"
var3=$(echo "$page" | sed '/<td class="forecast-1" headers="max-temp forecast-1">/,$d' | sed -n '/<td class="forecast-0" headers="max-temp forecast-0">/,$p' | sed 's/<\/td><td class="forecast-0" headers="max-temp forecast-0">//g' | sed 's/<abbr title="Grad Celsius"> &deg\;C<\/abbr>/ Grad/g')
echo $var3 >>/home/fred/speaktest
#
###temperatur morgen###
echo " " >>/home/fred/speaktest
echo morgen: >>/home/fred/speaktest
var4=$(echo "$page" | sed '/<td class="forecast-2" headers="max-temp forecast-2">/,$d' | sed -n '/<td class="forecast-1" headers="max-temp forecast-1">/,$p' | sed 's/<\/td><td class="forecast-1" headers="max-temp forecast-1">//g' | sed 's/<abbr title="Grad Celsius"> &deg\;C<\/abbr>/ Grad/g')
echo $var4 >>/home/fred/speaktest
#
###temperatur uebermorgen###
echo " " >>/home/fred/speaktest
echo übermorgen: >>/home/fred/speaktest
var5=$(echo "$page" | sed '/<td class="forecast-3" headers="max-temp forecast-3">/,$d' | sed -n '/<td class="forecast-2" headers="max-temp forecast-2">/,$p' | sed 's/<\/td><td class="forecast-2" headers="max-temp forecast-2">//g' | sed 's/<abbr title="Grad Celsius"> &deg\;C<\/abbr>/ Grad/g')
echo $var5 >>/home/fred/speaktest
