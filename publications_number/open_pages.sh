#!/bin/bash

QUERY=$1 
YEAR_START=$2 
YEAR_END=$3
GOOGLE_QUERY=$(echo $QUERY | tr " " +)

for ((year = $YEAR_START ; year <= YEAR_END ; year++)); do
	adress="https://scholar.google.com/scholar?q=$GOOGLE_QUERY&hl=en&as_sdt=0%2C5&as_ylo=$year&as_yhi=$year"
	firefox $adress	
	sleep 0.1
done
