#!/bin/bash

#This script scrapes from met api, and ouputs results into city.txt files.
#This is a variable for the API for weather
API="https://api.met.no/weatherapi/locationforecast/2.0/classic?"
set -eu
# declare arrays
declare -a positions=("lat=69.6492&lon=18.9553" "lat=60.8941&lon=10.5001" "lat=59.9139&lon=10.7522" "lat=63.4305&lon=10.3951" "lat=60.3913&lon=5.3221" "lat=58.1599&lon=8.0182")
cities=("tromso" "gjovik" "oslo" "trondheim" "bergen" "kristiansand")
#Variables to be able to fetch the correct data
date=$(date +%Y-%m-%d)
hour=$(date +%H:)
nexthour=$(date +%H: -d '1 hour')
afterhours=$(date +%H: -d '2 hour')
time=$(date +%H:%M)
arraylength=${#cities[@]}
#Loops through the cities and puts the name in city file, then grabs the API data and outputs the temperature to the city file
for ((i = 0; i < ${arraylength}; i++)); do
    # if its kristiansand and $((date % 2)) -eq 0  is true than continue
    if [[ "${cities[$i]}" == "kristiansand" ]]; then #&& [[ ! $((date % 2)) -eq 0 ]]; then
        continue
    fi
    #get data for today and output that in a tmp file"
    curl -s "${API}${positions[$i]}" | grep -A10 -E '[0-9]{2}-[0-9]{2}-[0-9]{2}' >>${cities[$i]}.tmp
    #get temperature
    cat ${cities[$i]}.tmp | grep -A5 "$date""T""$hour" | grep "celsius" | grep -E -o '[-]?[0-9]{1,2}.[0-9]{1,2}' | head -n 1 >>${cities[$i]}.txt
    cat ${cities[$i]}.tmp | grep -A5 "$date" | grep -A3 "$nexthour" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >>${cities[$i]}.txt
    cat ${cities[$i]}.tmp | grep -A5 "$date" | grep -A3 "$afterhours" | grep "temperature" | grep -E -o '[-]?[0-9]{1,2}.[0-9]' | head -n 1 >>${cities[$i]}.txt
    #get percipitation
    cat ${cities[$i]}.tmp | grep -A21 "$date" | grep -oP '(?<=code=").*?(?=")' | head -n 1 >>${cities[$i]}.txt
    #get time and date data was fetched
    echo "$date $time" >>${cities[$i]}.txt
    #get humidity for today DOES NOT WORK! Double check
    cat ${cities[$i]}.tmp | grep -A21 "$date" | grep -A21 "$hour" | grep "humidity" | grep -oP '(?<=value=").*?(?=")' | head -n 1 >>${cities[$i]}.txt
done
