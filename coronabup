#!/bin/sh
## Get current date ##
_now=$(date '+%Y%d%m')
## Appending a current date from a $_now to a filename stored in $_file ##
_file="/home/hirschy/.cache/coronastats/$_now"
curl -s 'https://corona-stats.online/states/us?&minimal=true&emojis=true' >  "$_file.log"
