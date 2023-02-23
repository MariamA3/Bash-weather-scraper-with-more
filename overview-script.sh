#!/bin/bash/
PathForCron=$HOME/project/overview-script.sh

#This script generates a HTML overview page for all the  available city pages
#file.txt has the names of the cities in them

set -eu
date=$( date +%Y-%m.%d )
time=$( date +%H:%M )

echo "<!DOCTYPE html>
<html>
<head>
<style>
h1 {text-align:center;}
ol {text-align:center;   list-style-type: none;}
p {text-align:center;}
li::first-letter {text-transform:uppercase;}
</style>
<title>Weather forecast</title>
</head>

<body>
<h1> Weather forecasts </h1>


<p>Forecast updated at $date $time </p>
<ol> " > overview.html

        for line in {1..5}; do
        city=$( cat file.txt | head -n $line | tail -n1 )
        temp1=$( cat $city.txt | head -n2 | tail -n1 )
        temp2=$( cat $city.txt | head -n3 | tail -n1 )
        temp3=$( cat $city.txt | head -n4 | tail -n1 )
        percipitation=$( cat $city.txt | head -n5  | tail -n1 )
        humidity=$( cat $city.txt | head -n7 | tail -n1 )
echo "
        <li><a href="../home/project/$city.html">$city:</a> ($percipitation) $temp1, $temp2, $temp3,  $humidity</li> " >> overview.html
        done
echo "
</ol>

</body>

</html>" >> overview.html