#!/bin/bash

# Infinite loop.
while true; do
    # Display a list of system info options to user. The selected choice is stored in the "choice" variable.
    choice=$(yad --list --text "Select a system info option" --radiolist --column "Pick" --column "Options" FALSE "Operating System Type" FALSE "CPU Info" FALSE "Memory Info" FALSE "Hard Disk Info" FALSE "File System Info" FALSE "Exit" --separator="" --width=500 --height=500 --fontname="Sans 14" --center --print-column=2)

    # Based on user's choice, perform the respective action.
    case $choice in
        "Operating System Type")
            # "uname -o" command to get the operating system type.
            os=$(uname -o)
            yad --info --text "Operating System: $os" --width=500 --height=500 --fontname="Sans 14" --center
            ;;
        "CPU Info")
            # "lscpu" command to get CPU information.
            cpu_info=$(lscpu)
            yad --info --text "CPU Information: $cpu_info" --width=500 --height=500 --fontname="Sans 14" --center
            ;;
        "Memory Info")
            # "free -h" command to get memory information.
            mem_info=$(free -h)
            yad --info --text "Memory Information: $mem_info" --width=500 --height=500 --fontname="Sans 14" --center
            ;;
        "Hard Disk Info")
            # "df -h" command to get hard disk information.
            disk_info=$(df -h)
            yad --info --text "Hard Disk Information: $disk_info" --width=500 --height=500 --fontname="Sans 14" --center
            ;;
        "File System Info")
            # "mount | column -t" command to get file system information.
            fs_info=$(mount | column -t)
            yad --info --text "File System (Mounted): $fs_info" --width=500 --height=500 --fontname="Sans 14" --center
            ;;
        "Exit")
            # If the user chose "Exit", end the script.
            exit 0
            ;;
    esac
done
