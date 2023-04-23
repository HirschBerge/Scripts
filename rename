#!/bin/sh
echo "This is what would happen:"
paste OLD NEW
echo -e "Would you like to continue? \nIf No, hit ^C, continuing in 5 seconds"
sleep 5
while IFS= read -r old <&3 && IFS= read -r new <&4; do
	mv -i -- "$old" "$new"
done 3< OLD 4< NEW
