#!/bin/bash

QUERY=$1 
YEAR_START=$2 
YEAR_END=$3

touch "$QUERY.csv"
echo "year,publications" >> "$QUERY.csv"

for ((year = $YEAR_START ; year <= YEAR_END ; year++)); do
	curl -A 'Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0' -s "https://scholar.google.com/scholar?q=$QUERY&hl=en&as_sdt=0%2C5&as_ylo=$year&as_yhi=$year" > output.html
	parced=$(grep -oP 'About \K\d+,\d+' output.html)
	count=$(echo $parced | tr , .)
	echo "Количество публикаций за $year год: $count"
	echo "$year,$count" >> "$QUERY.csv"

done
