#!/usr/bin/env bash
if ( bluetoothctl show | grep "Powered: no" &>/dev/null )
then
	bluetoothctl power on &>/dev/null
	bluetoothctl connect C4:35:D9:1C:9D:85 &>/dev/null
else
	bluetoothctl power off &>/dev/null
fi
