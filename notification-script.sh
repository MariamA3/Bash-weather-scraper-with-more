#!/bin/bash 
#This is a script that sends summary of the weather to https://ntfy.sh/idg1100-587231

for line in {1..5}; do
city=$( cat file.txt | head -n $line | tail -n1 )
        temp1=$( cat $city.txt | head -n2 | tail -n1 )
        temp2=$( cat $city.txt | head -n3 | tail -n1 )
        temp3=$( cat $city.txt | head -n4 | tail -n1 )
        percipitation=$( cat $city.txt | head -n5  | tail -n1 )
        humidity=$( cat $city.txt | head -n7 | tail -n1 )

        curl -s "Here's the weather in $city : The temperature for now is $temp1, in an hour it will be $temp2, and in three hours it will be $temp3, the percipitation is $percipitation, 
        and the humidity is $humidity." ntfy.sh/idg1100-587231
        done