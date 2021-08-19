#!/bin/bash

giorno=`date`

start='gio ' ; end=', 09:50:38, CEST'

giorno=${giorno:${#start}:-${#end}}

# giorno=${giorno/ /-} replace 1

giorno=${giorno// /-} # replace all

read -p "enter for procede with $giorno"

cd /media/kaumi/\ BYPW473/Users/ADMIN/Documents

zip -r "/home/kaumi/Backups/$giorno.zip" . -x GHOST/IMAGE/*.tibx

sync

cp "/home/kaumi/Backups/$giorno.zip" ../backup-latest.zip

sync

cp "/home/kaumi/Backups/$giorno.zip" /var/www/html/backup-latest.zip

sync

cp "/home/kaumi/Backups/made.sh" /var/www/html/made.sh

sync
