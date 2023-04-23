#!/bin/sh
[[ `ip a | grep nord` ]] && nordvpn c United_States && echo "Now connected to NordVpn"
