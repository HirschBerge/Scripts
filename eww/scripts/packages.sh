#!/usr/bin/env bash
tacos=$(expr $(nix-store -qR --requisites /run/current-system/sw |wc -l) + $(nix-store -qR /etc/profiles/per-user/"$USER" |wc -l)); echo $tacos
