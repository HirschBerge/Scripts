#!/bin/zsh

filesys(){
	date
	echo -n "Drive:\t  FileSystem:\t Size: Used: Avl:  Use:  Mount Point\n"
	sudo df -hT |grep -v tmp | grep -v File| sort -nrk 6
}
filesys
