#!/bin/bash

QUERY=$1 
YEAR_START=$2 
YEAR_END=$3
GOOGLE_QUERY=$(echo $QUERY | tr " " +)
echo $GOOGLE_QUERY
touch "$QUERY.csv"
echo "year,publications" >> "$QUERY.csv"


for ((year = $YEAR_START ; year <= YEAR_END ; year++)); do
	adress="https://scholar.google.com/scholar?q=$GOOGLE_QUERY&hl=en&as_sdt=0%2C5&as_ylo=$year&as_yhi=$year"
	agent="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0" 
	echo "Чтобы увидеть результат запроса перейдите по адресу: $adress"
	curl -s -A $agent $adress > output.html
	parced=$(grep -oP 'About \K\d+(?:,\d+)?' output.html)
	count=$(echo $parced | tr -d ,)
	echo "Количество публикаций за $year год: $count"
	echo "$year,$count" >> "$QUERY.csv"
	sleep 0.1
done
