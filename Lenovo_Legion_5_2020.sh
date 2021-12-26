#!/usr/bin/env bash

conservation_mode="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
usb_charging="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/usb_charging"

while getopts "cu" options 
do
    case "${options}" in
        c)
            if (($(echo $(($(cat $conservation_mode) ^ 1)) | sudo tee $conservation_mode) == 1))
            then
                echo Conservation mode on
            else
                echo Conservation mode off
            fi
            ;;
        u)
            if (($(echo $(($(cat $usb_charging) ^ 1)) | sudo tee $usb_charging) == 1))
            then
                echo USB charging on
            else
                echo USB charging off
            fi
            ;;
        \?) echo Invalid option. Please use --help for correct usage.
            ;;
    esac
done
