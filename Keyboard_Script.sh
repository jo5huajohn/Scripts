#! /usr/bin/env bash

internalKeyId="$(xinput list | awk '/(8910)/ {print $8}' | awk -F"id=" '/id/{print $2}')"

clean()
{
    xinput enable $internalKeyId
    echo "Internal Keyboard Enabled."
    exit
}

trap clean SIGHUP SIGINT SIGTERM

while [ 1 ]
do
    bluetoothKeyId="$(xinput list | awk '/Keyboard K380 Keyboard/ {print $5}' | awk -F"id=" '{found=1} {print $2} END {if (!found) print "0"}')"

    if [ $bluetoothKeyId -gt 0 ] 
    then
        xinput disable $internalKeyId
    else
        xinput enable $internalKeyId
    fi
done
