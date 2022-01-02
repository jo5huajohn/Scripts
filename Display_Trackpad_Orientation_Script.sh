#!/usr/bin/env bash

trackpad=`xinput list | awk '/Touchpad/ { print $6 }' | awk -F"=" '{ print $2 }'`

while getopts "lrni" options
do
    case "${options}" in
        l)
            xrandr -o left
            xinput set-prop $trackpad 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1
            ;;
        r)
            xrandr -o right
            xinput set-prop $trackpad 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1
            ;;
        n)
            xrandr -o normal
            xinput set-prop $trackpad 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
            ;;
        i)
            xrandr -o inverted
            xinput set-prop $trackpad 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
    esac
done
