cnt=00
for i in `cat $1`
do
  let cnt=$(( cnt+10#1 ))
  echo $i S0$2E`printf "%02d\n" "$cnt"`.mp4 | tail -c 75 |awk -F"/" '{print $2 }' |sed -e 's/+-+/E/g' -e 's/+/ /g' -e 's/\.mp4\.mp4?stream=1//g'
  wget $i -O S0$2E`printf "%02d\n" "$cnt"`.mp4 --show-progress -q -nc
done
