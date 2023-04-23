#!/bin/sh

function main {
 for i in 60 1440 10080 43800 525600
 do
   if [ $i == 60 ];
   then
     #`cat /var/www/html/log.txt | tail -60 > /var/www/html/hour.txt`
     echo hour
   elif [ $i == 1440 ];
   then
     #`cat /var/www/html/log.txt | tail -1440 > /var/www/html/day.txt`
     echo day
   elif [ $i == 10080 ];
   then
     #`cat /var/www/html/log.txt | tail -10080 > /var/www/html/week.txt`
     echo week
   elif [ $i == 43800 ];
   then
     #`cat /var/www/html/log.txt | tail -43800 > /var/www/html/month.txt`
     echo month
   elif [ $i == 525600 ];
   then
     #`cat /var/www/html/log.txt | tail -525600 > /var/www/html/year.txt`
     echo year
   else
     echo broke
   fi
   done
}
main
