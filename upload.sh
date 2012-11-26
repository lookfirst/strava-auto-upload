#!/bin/bash

set -e

SETTINGS="$HOME/.strava-auto-upload"
TO="upload@strava.com"

source "$SETTINGS/config"

log() {
	DATE=`date +"%D %T: "`
	echo $DATE $1
	echo $DATE $1 >> "$SETTINGS/strava-auto-upload.log"
}

if [ ! -d "$SETTINGS" ]; then
	mkdir -p $SETTINGS
fi

log "Started upload.sh script..."

if [ ! -d "$ACTIVITIES" ]; then
	log "Could not find your garmin folder: $ACTIVITIES"
	exit
fi

if [ -e "$SETTINGS/last_file" ]; then
	LAST_FILE=`cat $SETTINGS/last_file`
	log "Looking for files after... $LAST_FILE"
fi

cd $ACTIVITIES

if [ ! -z "$LAST_FILE" ]; then
	FOUND=`find . -name "*.fit" -mnewer $LAST_FILE`
else
	FOUND=`find . -name "*.fit"`
fi

if [ -z "$FOUND" ]; then
	log "No new files to upload."
else
	log "Found: $FOUND"
	for i in $FOUND
	do
		log "Emailing: $i"
		HEAD="MIME-Version: 1.0\nFrom: $FROM\nTo: $TO\nContent-Type: multipart/mixed; boundary=STRAVA\n\n--STRAVA\nContent-Type: application/octet-stream; name=\"$i\"\n"
		HEAD2="Content-Disposition: attachment; filename=\"$i\"\nContent-Transfer-Encoding: base64\n\n"
		DATA=`base64 $i`
		printf "%b%b%s" "$HEAD" "$HEAD2" "$DATA" | sendmail -t
	done

	if [ ! -z $i ]; then
		log "Setting last_file to: $i"
		echo -n $i > "$SETTINGS/last_file"
	fi
fi

log "Finished upload.sh script."
