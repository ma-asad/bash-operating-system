#!/bin/bash

while true; do
    choice=$(yad --list --text "Select a system info option" --radiolist --column "Pick" --column "Options" FALSE "Operating System Type" FALSE "CPU Info" FALSE "Memory Info" FALSE "Hard Disk Info" FALSE "File System Info" FALSE "Exit" --separator="" --width=500 --height=500 --fontname="Sans 14" --center --print-column=2)

    case $choice in
        "Operating System Type")
            os=$(uname -o)
            yad --info --text "Operating System: $os" --width=500 --height=500 --fontname="Sans 14" --center
            ;;
        "CPU Info")
            cpu_info=$(lscpu)
            yad --info --text "CPU Information: $cpu_info" --width=500 --height=500 --fontname="Sans 14" --center
            ;;
        "Memory Info")
            mem_info=$(free -h)
            yad --info --text "Memory Information: $mem_info" --width=500 --height=500 --fontname="Sans 14" --center
            ;;
        "Hard Disk Info")
            disk_info=$(df -h)
            yad --info --text "Hard Disk Information: $disk_info" --width=500 --height=500 --fontname="Sans 14" --center
            ;;
        "File System Info")
            fs_info=$(mount | column -t)
            yad --info --text "File System (Mounted): $fs_info" --width=500 --height=500 --fontname="Sans 14" --center
            ;;
        "Exit")
            exit 0
            ;;
    esac
done
