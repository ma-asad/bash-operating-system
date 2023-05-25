#!/bin/bash

while true; do
    choice=$(yad --list --text "Select an option" --radiolist --column "Pick" --column "Options" FALSE "Date/time" FALSE "Calendar" FALSE "Delete" FALSE "System Info" FALSE "Play a game" FALSE "Exit" --separator="" --width=500 --height=500 --fontname="Sans 14" --center --print-column=2)

    if [ "$choice" == "" ]; then
        continue
    fi

    case $choice in
        "Date/time")
            yad --info --text "$(date)" --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
            ;;
        "Calendar")
            chosen_date=$(yad --calendar --width=500 --height=500 --fontname="Sans 14" --center)
            if [ "$chosen_date" != "" ]; then
                yad --info --text "You chose the date: $chosen_date" --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
            fi
            ;;
        "Delete")
            del_choice=$(yad --list --text "Select an option" --radiolist --column "Pick" --column "Options" FALSE "File" FALSE "Directory" --separator="" --width=400 --height=300 --fontname="Sans 14" --center --print-column=2)
            if [ "$del_choice" != "" ]; then
                path=$(yad --entry --text "Enter full path of file or directory" --width=400 --height=100 --fontname="Sans 14" --center)
                if [ "$path" != "" ]; then
                    if [[ "$path" == /sys/* || "$path" == /proc/* || "$path" == /boot/* || "$path" == /bin/* || "$path" == /sbin/* ]]; then
                        yad --info --text "Warning: System files cannot be deleted." --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
                    else
                        if [ -d "$path" ] && [ "$del_choice" == "Directory" ]; then
                            if yad --question --text "Are you sure you want to delete $path?" --width=400 --height=300 --fontname="Sans 14" --center; then
                                rm -rf "$path"
                            fi
                        elif [ -f "$path" ] && [ "$del_choice" == "File" ]; then
                            if yad --question --text "Are you sure you want to delete $path?" --width=400 --height=300 --fontname="Sans 14" --center; then
                                rm "$path"
                            fi
                        elif [ -d "$path" ] && [ "$del_choice" == "File" ]; then
                            if [ "$(ls -A $path)" ]; then
                                file=$(yad --list --column "Files" $(ls $path) --separator="" --width=400 --height=300 --fontname="Sans 14" --center)
                                if [ "$file" != "" ]; then
                                    if yad --question --text "Are you sure you want to delete $file?" --width=400 --height=300 --fontname="Sans 14" --center; then
                                        rm "$path/$file"
                                    fi
                                fi
                            else
                                yad --info --text "Directory is empty." --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
                            fi
                        else
                            yad --info --text "The provided path does not exist." --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
                        fi
                    fi
                fi
            fi
            ;;
        "System Info")
            "/home/asad/Documents/CST1500/Coursework 2/Coursework2 - Bash/sys_info.sh"
            ;;
        "Play a game")
            game=$(yad --list --text "Choose a game" --radiolist --column "Pick" --column "Game" FALSE "Dunnet" FALSE "Game 1" FALSE "Game 2" --separator="" --width=500 --height=500 --fontname="Sans 14" --center --print-column=2)
            if [ "$game" != "" ]; then
                case $game in
                    "Dunnet")
                        emacs -batch -l dunnet
                        ;;
                    "Game 1")
                        /path/to/game1.sh
                        ;;
                    "Game 2")
                        /path/to/game2.sh
                        ;;
                esac
            fi
            ;;
        "Exit")
            exit 0
            ;;
    esac
done
