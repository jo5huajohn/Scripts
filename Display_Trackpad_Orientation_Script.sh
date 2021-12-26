#!/usr/bin/env bash

externalMouse="$(xinput list | awk '/Logitech Wireless Mouse/ {print $6}' | awk -F"id=" '{print $2}')"
trackpad="$(xinput list | awk '/Touchpad/ {print}' | awk -F"id=" '{print $2}' | awk -F" " '{print $1}')"

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
