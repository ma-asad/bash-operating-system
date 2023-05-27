#!/bin/bash

# Start an infinite loop. The user will make choices until they choose to exit.
while true; do
    # Display a dialog with several options for the user to pick from.
    # The result of their selection is stored in the variable "choice".
    choice=$(yad --list --text "Select an option" --radiolist --column "Pick" --column "Options" FALSE "Date/time" FALSE "Calendar" FALSE "Delete" FALSE "System Info" FALSE "Play a game" FALSE "Browse the web" FALSE "Exit" --separator="" --width=400 --height=350 --fontname="Sans 14" --center --print-column=2)

    # If the user didn't make a selection (closed the dialog), restart the loop.
    if [ "$choice" == "" ]; then
        continue
    fi

    # Handle the user's selection based on what they chose.
    case $choice in
        "Date/time")
            # Display the current date and time in a new dialog.
            yad --info --text "$(date)" --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
            ;;
        "Calendar")
            # Show a calendar dialog. The selected date is stored in "chosen_date".
            chosen_date=$(yad --calendar --width=500 --height=500 --fontname="Sans 14" --center)
            # If the user picked a date, show it in a new dialog.
            if [ "$chosen_date" != "" ]; then
                yad --info --text "You chose the date: $chosen_date" --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
            fi
            ;;
        "Delete")
            # Allow the user to select whether they want to delete a file or a directory.
            del_choice=$(yad --list --text "Select an option" --radiolist --column "Pick" --column "Options" FALSE "File" FALSE "Directory" --separator="" --width=400 --height=300 --fontname="Sans 14" --center --print-column=2)
            # If the user made a selection, ask for the path to delete.
            if [ "$del_choice" != "" ]; then
                path=$(yad --entry --text "Enter full path of file or directory" --width=400 --height=100 --fontname="Sans 14" --center)
                # If the user entered a path, proceed with the deletion.
                if [ "$path" != "" ]; then
                    # Prevent deletion of critical system directories.
                    if [[ "$path" == /sys/* || "$path" == /proc/* || "$path" == /boot/* || "$path" == /bin/* || "$path" == /sbin/* ]]; then
                        yad --info --text "Warning: System files cannot be deleted." --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
                    else
                        # The rest of this block handles the deletion based on the type of the path (file or directory)
                        # and the user's choice ("File" or "Directory").
                        # The rm command is used to delete files and directories.
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
            # Run a separate script that presumably displays system information.
            "/home/asad/Documents/CST1500/Coursework 2/Coursework2 - Bash/sys_info.sh"
            ;;
        "Play a game")
            # Allow the user to select a game to play.
            game=$(yad --list --text "Choose a game" --radiolist --column "Pick" --column "Game" FALSE "Dunnet" FALSE "Tetris" FALSE "Snake" FALSE "Gomoku" FALSE "Guess The Number" FALSE "Tic-Tac-Toe" --separator="" --width=400 --height=400 --fontname="Sans 14" --center --print-column=2)
            # If the user picked a game, start it.
            if [ "$game" != "" ]; then
                case $game in
                    # Each game is started differently.
                    # The "emacs -f" command starts emacs and calls a function.

                    "Dunnet")
                        xfce4-terminal -e 'emacs -f dunnet'
                        ;;
                    "Tetris")
                        xfce4-terminal -e 'emacs -f tetris'
                        ;;
                    "Snake")
                        xfce4-terminal -e 'emacs -f snake'
                        ;;
                    "Gomoku")
                        xfce4-terminal -e 'emacs -f gomoku'
                        ;;
                    "Guess The Number")
                        "full-path/game/guess_the_num.exe"
                        ;;
                    "Tic-Tac-Toe")
                        "full-path/game/tic_tac_toe.exe"
                        ;;
                    # The "full-path/game/*.exe" starts the game executable.
                esac
            fi
            ;;
        "Browse the web")
            # Ask the user for a URL or a keyword to search for.
            url=$(yad --entry --text "Enter keyword or URL" --width=400 --height=100 --fontname="Sans 14" --center)
            # If the user entered something, open it in a web browser.
            if [ "$url" != "" ]; then
                if [[ $url == http* ]]; then  # it's a URL
                    xdg-open "$url"
                else  # it's a keyword, search with Google
                    xdg-open "https://www.google.com/search?q=$url"
                fi
            fi
            ;;
        "Exit")
            # Exit the script.
            exit 0
            ;;
    esac
done
