#!/bin/bash

#This script will read the information stored in the files created by the scraping script and create a series of HTML pages, one for each city

city=$( cat file.txt | head -n 1 )
temp1=$( cat file.txt | head -n 2 | tail -n 1 )
temp2=$( cat file.txt | head -n 3 | tail -n 1 )
temp3=$( cat file.txt | head -n 4 | tail -n 1 )
percipitation=$( cat file.txt | head -n 5 | tail -n 1 )
datefetched=$( cat file.txt | head -n 6 | tail -n 1 )
humidity=$( cat file.txt | head -n 7 | tail -n 1 )


date=$( date +%Y-%m-%d )
hour=$( date  +%H: )
nexthour=$( date +%H:%M -d '1 hour' )
afterhours=$( date +%H:%M -d '2 hour' )
time=$( date +%H:%M )




for line in {1..5}; do
        location=$(cat file.txt | head -n $line | tail -n1)
        temp1=$(cat $location.txt | head -n2 | tail -n1 )
        temp2=$( cat $location.txt | head -n3 | tail -n1 )
        temp3=$( cat $location.txt | head -n4 | tail -n1 )
        percipitation=$( cat $location.txt | head -n5 | tail -n1 )
        datefetched=$( cat $location.txt | head -n6 | tail -n1 )
        humidity=$( cat $location.txt | head -n7 | tail -n1 )


echo "<!DOCTYPE html>
<html>
<head>
<title>$location</title>
</head>

<body>
<h1> Weather forecast for $location </h1>

<h2>Temperatures:</h2>

<ol>
<li>$time: $temp1</li>
<li>$nexthour: $temp2</li>
<li>$afterhours: $temp3</li>
</ol>

<p>Forecast: $percipitation </p>
<p>Date fetched: $datefetched </p>
<p><a href="/home/project/overview.html">Weather forecast for Norwegian cities </a></p>
</body>

</html>" > $location.html
done