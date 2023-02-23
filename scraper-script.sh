#!/bin/bash

#This script scrapes from met api, and ouputs results into city.txt files.
#This is a variable for the API for weather
API="https://api.met.no/weatherapi/locationforecast/2.0/classic?"

set -eu

#cities
tromso="lat=69.6492&lon=18.9553"
gjovik="lat=60.8941&lon=10.5001"
oslo="lat=59.9139&lon=10.7522"
trondheim="lat=63.4305&lon=10.3951"
bergen="lat=60.3913&lon=5.3221"
kristiansand="lat=58.1599&lon=8.0182"

#Variables to be able to fetch the correct data
date=$( date +%Y-%m-%d )
hour=$( date +%H: )
nexthour=$( date +%H: -d '1 hour' )
afterhours=$( date +%H: -d '2 hour' )
time=$( date +%H:%M )

#Loops through the cities and puts the name in city file, then grabs the API data and outputs the temperature to the city file
for CITY in tromso gjovik oslo trondheim bergen ; do
    echo ${CITY} > ${CITY}.txt

if [ $CITY = "tromso" ]
then
     #get data for today and output that in a tmp file"
     curl -s "${API}lat=69.6492&lon=18.9553" | grep -A10 -E '[0-9]{2}-[0-9]{2}-[0-9]{2}' >> tromso.tmp
     #get temperature
     cat tromso.tmp | grep -A5 "$date""T""$hour" | grep "celsius" | grep -E -o '[-]?[0-9]{1,2}.[0-9]{1,2}' | head -n 1 >> tromso.txt
     cat tromso.tmp | grep -A5 "$date" | grep -A3 "$nexthour" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> tromso.txt
     cat tromso.tmp | grep -A5 "$date" | grep -A3 "$afterhours" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> tromso.txt
     #get percipitation
     cat tromso.tmp | grep -A21 "$date"| grep -oP '(?<=code=").*?(?=")' | head -n 1 >> tromso.txt
     #get time and date data was fetched
     echo "$date $time" >> tromso.txt
     #get humidity for today DOES NOT WORK! Double check
     cat tromso.tmp | grep -A21 "$date" | grep -A21 "$hour" | grep "humidity" | grep -oP '(?<=value=").*?(?=")' | head -n 1 >> tromso.txt

elif [ $CITY = "gjovik" ];
then
     curl -s "${API}lat=60.8941&lon=10.5001" | grep -A10 -E '[0-9]{2}-[0-9]{2}-[0-9]{2}' >> gjovik.tmp
     cat gjovik.tmp | grep -A5 "$date" | grep -A3 "$hour" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> gjovik.txt
     cat gjovik.tmp | grep -A5 "$date" | grep -A3 "$nexthour" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> gjovik.txt
     cat gjovik.tmp | grep -A5 "$date" | grep -A3 "$afterhours" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> gjovik.txt
     cat gjovik.tmp | grep -A21 "$date"| grep -oP '(?<=code=").*?(?=")' |head -n 1 >> gjovik.txt
     echo "$date $time" >> gjovik.txt
     cat gjovik.tmp | grep -A21 "$date" | grep -A21 "$hour" | grep "humidity" | grep -oP '(?<=value=").*?(?=")' | head -n 1 >> gjovik.txt

elif [ $CITY = "oslo" ]
then
     curl -s "${API}lat=59.9139&lon=10.7522" | grep -A10 -E '[0-9]{2}-[0-9]{2}-[0-9]{2}' >> oslo.tmp
     cat oslo.tmp | grep -A5 "$date" | grep -A3 "$hour" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> oslo.txt
     cat oslo.tmp | grep -A5 "$date" | grep -A3 "$nexthour" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> oslo.txt
     cat oslo.tmp | grep -A5 "$date" | grep -A3 "$afterhours" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> oslo.txt
     cat oslo.tmp | grep -A21 "$date"| grep -oP '(?<=code=").*?(?=")' |head -n 1 >> oslo.txt
     echo "$date $time" >> oslo.txtcat oslo.tmp | grep -A21 "$date" | grep -A21 "$hour" | grep "humidity" | grep -oP '(?<=value=").*?(?=")' | head -n 1 >> oslo.txt

elif [ $CITY = "trondheim" ]
then
     curl -s "${API}lat=63.4305&lon=10.3951" | grep -A10 -E '[0-9]{2}-[0-9]{2}-[0-9]{2}' >> trondheim.tmp
     cat trondheim.tmp | grep -A5 "$date" | grep -A3 "$hour" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> trondheim.txt
     cat trondheim.tmp | grep -A5 "$date" | grep -A3 "$nexthour" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> trondheim.txt
     cat trondheim.tmp | grep -A5 "$date" | grep -A3 "$afterhours" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> trondheim.txt
     cat trondheim.tmp | grep -A21 "$date"| grep -oP '(?<=code=").*?(?=")' |head -n 1 >> trondheim.txtecho "$date $time" >> trondheim.txt
     cat trondheim.tmp | grep -A21 "$date" | grep -A21 "$hour" | grep "humidity" | grep -oP '(?<=value=").*?(?=")' | head -n 1 >> trondheim.txt
else
     curl -s "${API}lat=60.3913&lon=5.3221" | grep -A10 -E '[0-9]{2}-[0-9]{2}-[0-9]{2}' >> bergen.tmp
     cat bergen.tmp | grep -A5 "$date" | grep -A3 "$hour" | grep "celsius" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> bergen.txt
     cat bergen.tmp | grep -A5 "$date" | grep -A3 "$nexthour" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> bergen.txt
     cat bergen.tmp | grep -A5 "$date" | grep -A3 "$afterhours" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >> bergen.txt
     cat bergen.tmp | grep -A21 "$date"| grep -A21 "$hour" | grep -oP '(?<=code=").*?(?=")' | head -n 1 >> bergen.txtecho "$date $time" >> bergen.txt
     cat bergen.tmp | grep -A21 "$date" | grep -A21 "$hour" | grep "humidity" | grep -oP '(?<=value=").*?(?=")' | head -n 1 >> bergen.txt
fi
done

#This scrapes the kristiansand data if the day is even

if [[ $((date % 2)) -eq 0 ]];
then
     echo "kristiansand" > kristiansand.txt 
     curl -s "${API}lat=58.1599&lon=8.0182" | grep -A5 -E '[0-9]{2}-[0-9]{2}-[0-9]{2}' >> kristiansand.tmp 
     cat kristiansand.tmp | grep -A5 "$date" | grep -A3 "$hour" | grep "temperature" | grep -E -o '[-]?[0-9].[0-9]' | head -n 1 >> kristiansand.txt
     cat kristiansand.tmp | grep -A5 "$date" | grep -A3 "$nexthour" | grep "temperature" | grep -E -o '[-]?[0-9].[0-9]' | head -n 1 >> kristiansand.txt
     cat kristiansand.tmp | grep -A5 "$date" | grep -A3 "$afterhours" | grep "temperature" | grep -E -o '[-]?[0-9].[0-9]' | head -n 1 >> kristiansand.txt
     cat kristiansand.tmp | grep -A21 "$date" | grep -oP '(?<=code=").*?(?=")' |head -n 1 >> kristiansand.txt
     echo "$date $time" >> kristiansand.txt
     cat kristiansand.tmp | grep -A21 "$date" | grep -A21 "$hour" | grep "humidity" | grep -oP '(?<=value=").*?(?=")' | head -n 1 >> kristiansand.txt
fi
