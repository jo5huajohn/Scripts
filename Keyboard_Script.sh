#! /usr/bin/env bash

if kill -9 $(pgrep -f ${BASH_SOURCE[0]} | grep -v $$)
then
    echo "Killed previous process."
else
    echo "No previous process was found."
fi

internalKeyId="$(xinput list | awk '/keyboard/ {print}' | awk '/(8910)/ {print}' |  awk '/Keyboard/ {print $8}' | awk -F"id=" '{print $2}')"

clean()
{
    xinput enable $internalKeyId
    echo "Internal keyboard enabled."
    exit
}

trap clean SIGHUP SIGINT SIGTERM

while [ 1 ]
do
    bluetoothKeyId="$(xinput list | awk '/Keyboard K380 Keyboard/ {print $5}' \
            | awk -F"id=" '{found=1} {print $2} END {if (!found) print "0"}')"

    if [ $bluetoothKeyId -gt 0 ] 
    then
        xinput disable $internalKeyId
    else
        xinput enable $internalKeyId
    fi
done
