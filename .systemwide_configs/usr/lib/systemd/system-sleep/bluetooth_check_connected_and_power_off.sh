#!/usr/bin/env bash
if [[ ! $(bluetoothctl devices Connected) ]]
then
    bluetoothctl power off &>/dev/null
    exit 0
fi
