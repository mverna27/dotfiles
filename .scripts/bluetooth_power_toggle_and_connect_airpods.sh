#!/usr/bin/env bash
if ( bluetoothctl show | grep "Powered: no" &>/dev/null )
then
    bluetoothctl power on &>/dev/null
    timeout 10 bluetoothctl connect C4:35:D9:1C:9D:85 &>/dev/null
    if [ $? -ne 0 ]
    then
        bluetoothctl power off &>/dev/null
        exit 1
    fi
    exit 0
else
    bluetoothctl power off &>/dev/null
    exit 0
fi
