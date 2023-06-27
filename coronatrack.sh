#!/bin/sh

for i in `exa --sort newest ~/.cache/coronastats`
do
	echo $i |sed -e 's/2020/2020 /g' -e 's/2021/2021 /g' -e 's/2022/2022 /g' -e 's/01\.log/ January/g' -e 's/02\.log/ February/g' -e 's/03.log/ March/g' -e 's/04\.log/ April/g' -e 's/05\.log/ May/g' -e 's/06\.log/ June/g' -e 's/07\.log/ July/g' -e 's/08\.log/ August/g' -e 's/09\.log/ September/g' -e 's/10\.log/ October/g' -e 's/11\.log/ November/g' -e 's/12\.log/ December/g' | awk '{ print $3" " $2 " " $1}'

	grep -E "Rank|Penn" ~/.cache/coronastats/$i
done
