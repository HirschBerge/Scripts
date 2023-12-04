#!/usr/bin/env bash

dots="$(dirname "$(readlink -f "$0")")"
for i in "$dots"/*/; 
do 
    fixed=$(basename "$i")
    [[ "$fixed" = "nixos" ]] || echo "Copying $HOME/.config/$fixed to $dots"
    [[ "$fixed" = "nixos" ]] || rsync -rah --progress -i "$HOME/.config/$fixed/" "$dots/$fixed/" >/dev/null
done

rsync -rah --progress -i /etc/nixos/* nixos/
