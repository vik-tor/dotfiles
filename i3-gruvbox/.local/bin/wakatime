#!/bin/sh
TOKEN="94a07d23-8ff9-4861-9fba-789dc855f17e"

while getopts w:o: option
do 
	case "${option}"
  	in
    w)work=${OPTARG};;
    o)out=${OPTARG};;
  esac
done
	
show() {
	wakatime_today="$(curl -sf --header "Authorization: Basic $(echo "$TOKEN" | base64)" https://wakatime.com/api/v1/users/current/status_bar/today | jq -r '.data.grand_total.text')"

	if [ -n "$wakatime_today" ]; then
	    echo "$wakatime_today"
	else
	    echo ""
	    exit 1
	fi
}

show
