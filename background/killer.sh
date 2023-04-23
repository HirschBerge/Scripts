 pkill -9 `ps -aux | grep ~/.scripts/background/background.sh |grep "/bin\|sh " |awk '{ print $2 }'`
