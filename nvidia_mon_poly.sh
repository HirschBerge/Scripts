
# Bold High Intensity
NoColor="\033[0m"
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

output=$(nvidia-smi --query-gpu=memory.used,utilization.gpu,temperature.gpu --format=csv,noheader,nounits | awk -F"," '{ print $1 $2 $3}')
# echo $output
mem=$(echo $output |awk '{ print $1 }')
util=$(echo $output |awk '{ print $2 }')
temp=$(echo $output |awk '{ print $3 }')

function color_mem() {
	if [ $mem -le "1000" ]
	then
		mem="$BIGreen$mem$NoColor"
	elif [ $mem -gt "1000" ] && [ $mem -le "3000" ]
	then
		mem="$BIPurple$mem$NoColor"
	elif [ $mem -gt "3001" ] && [ $mem -le "6000" ]
	then
		mem="$BIYellow$mem$NoColor"
	else
		mem="$BIRed$mem$NoColor"
	fi
}
function color_util() {
	if [ $util -le "30" ]
	then
		util="$BIGreen$util$NoColor"
	elif [ $util -gt "30" ] && [ $util -le "70" ]
	then
		util="$BIPurple$util$NoColor"
	elif [ $util -gt "70" ] && [ $util -le "85" ]
	then
		util="$BIYellow$util$NoColor"
	else
		util="$BIRed$util$NoColor"
	fi
}
function color_temp() {
	if [ $temp -le "40" ]
	then
		temp="$BIGreen$temp$NoColor"
	elif [ $temp -gt "40" ] && [ $temp -le "69" ]
	then
		temp="$BIPurple$temp$NoColor"
	elif [ $temp -gt "70" ] && [ $temp -le "79" ]
	then
		temp="$BIYellow$temp$NoColor"
	else
		temp="$BIRed$temp$NoColor"
	fi
}
color_mem
color_temp
color_util
printf "${BICyan}RTX 3060ti${NoColor} ${mem}Mb ${util}%% ${temp}°C"