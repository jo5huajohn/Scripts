#!/usr/bin/env bash

if  kill `pgrep -f $0 | grep -v $$`; then
    echo Killed previous process.
else
    echo No previous process was found.
fi

bluetooth_key_id=`xinput list | awk '/Keyboard K380 Keyboard/ { print $5 }' | awk -F"=" '{ found=1 } { print $2 } END { if (!found) print "0" }'`
internal_key_id=`xinput list | awk '/keyboard/ && /8910) Keyboard/ { print $8 }' | awk -F"=" '{ print $2 }'`

clean()
{
    xinput enable $internal_key_id
    echo Internal keyboard enabled.
    exit
}

trap clean SIGHUP SIGINT SIGTERM SIGKILL

while [ 1 ]; do
    if [ $bluetooth_key_id -gt 0 ]; then
        xinput disable $internal_key_id
    else
        xinput enable $internal_key_id
    fi
done
