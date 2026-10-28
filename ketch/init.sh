#! /bin/sh

function get_artist_url() { 
	result=$(ketch search --limit 1 --minimal "site:music.apple.com/us/artist $1")
	echo $result | cut -d " " -f1
}

function get_artist_id() { 
	get_artist_url "$1" | rev | cut -d "/" -f1 | rev;
}

function get_artist_songs() {
	ketch 
}

function scrape_artist() {
	ketch scrape --no-cache --force-browser --raw https://music.apple.com/us/artist/$1/$(get_artist_id $1)
}

echo $(get_artist_id "fraxiom")
