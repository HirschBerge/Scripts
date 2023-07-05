#!/usr/bin/env bash

BAR_ICON=""
NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg
while $True; do
    get_total_updates() { UPDATES=$(checkupdates 2>/dev/null | wc -l); }


    get_total_updates

    # notify user of updates
    if hash notify-send &>/dev/null; then
        if (( UPDATES > 50 )); then
            notify-send -u critical -i $NOTIFY_ICON \
                "You really need to update!!" "$UPDATES New packages"
                sleep 300
        elif (( UPDATES > 25 )); then
            notify-send -u normal -i $NOTIFY_ICON \
                "You should update soon" "$UPDATES New packages"
                sleep 600
        elif (( UPDATES > 2 )); then
            notify-send -u low -i $NOTIFY_ICON \
                "$UPDATES New packages"
                sleep 600
        fi
    fi

    # when there are updates available
    # every 10 seconds another check for updates is done

    if (( UPDATES == 1 )); then
        echo " $UPDATES Update"
    elif (( UPDATES > 1 )); then
        echo " $UPDATES Updates"
    else
        echo $BAR_ICON
    fi
    # sleep 10
    get_total_updates


    # when no updates are available, use a longer loop, this saves on CPU
    # and network uptime, only checking once every 30 min for new updates
    while (( UPDATES == 0 ));
    do
        echo "$BAR_ICON 0"
        sleep 1800
        get_total_updates
    done
done