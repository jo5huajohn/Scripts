#!/usr/bin/env bash

conservation_mode="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
fn_lock="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/fn_lock"
touchpad="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/touchpad"
usb_charging="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/usb_charging"

while getopts "cfhtu" options
do
    case "${options}" in
        c)
            if (( $(echo $(( $(cat $conservation_mode) ^ 1 )) | sudo tee $conservation_mode) == 1 )); then
                echo Conservation mode on
            else
                echo Conservation mode off
            fi
            ;;

        f)
            if (( $(echo $(( $(cat $fn_lock) ^ 1 )) | sudo tee $fn_lock) == 0 )); then
                echo Fn-Lock on
            else
                echo Fn-Lock off
            fi
            ;;

        t)
            if (( $(echo $(( $(cat $touchpad) ^ 1 )) | sudo tee $touchpad) == 1 )); then
                echo Touchpad on
            else
                echo Touchpad off
            fi
            ;;

        u)
            if (( $(echo $(( $(cat $usb_charging) ^ 1 )) | sudo tee $usb_charging) == 1 )); then
                echo USB charging on
            else
                echo USB charging off
            fi
            ;;

        h)
            echo "Usage:
c: Toggles Conservation mode.
f: Toggles Fn-Lock.
t: Toggles Touchpad.
u: Toggles USB charging.
h: Prints usage."
                ;;

        \?) echo Invalid option. Please use --help or -h for correct usage.
            ;;
    esac
done
