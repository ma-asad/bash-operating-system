#!/bin/bash

# Function to display date and time
date_time() {
    yad --info --text "$(date)" --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
}

# Function to display the calendar and view events if any exist
view_calendar() {
    # Asks user for which date to view
    search_date=$(yad --calendar --width=500 --height=300 --fontname="Sans 14" --center)
    if [ "$search_date" != "" ]; then
        # Searches the file "events.txt" for any dates matching the variable search_date
        # grep is used to search the text file for a variable equal to search_date
        matching_events=$(grep "^$search_date:" events.txt)

        # if -n means that if the string matching_events is NOT empty
        if [ -n "$matching_events" ]; then
            yad --info --text=$matching_events --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
        else
            yad --info --text="No events found on $search_date" --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
        fi
    fi
}

# Function to display the calendar and add an event on a specific date
set_event_calendar() {
    # Asks user for which date to view
    chosen_date=$(yad --calendar --width=500 --height=300 --fontname="Sans 14" --center)
    if [ "$chosen_date" != "" ]; then
        additional_info=$(yad --form --title="Additional Information" --field="Additional Information":TXT --width=400 --height=300 --fontname="Sans 14" --center)

        if [ "$additional_info" != "" ]; then
            # if user selects a date, write what user typed inside input box into the file called "events.txt"
            echo "$chosen_date:$additional_info" >>events.txt
            yad --info --text="You chose the date: $chosen_date\n\nAdditional Information: $additional_info" --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
        else
            # else if user didn't write anything inside the input box, don't save anything in the "events.txt" file
            yad --info --text="You chose the date: $chosen_date" --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
        fi
    fi
}

# Function to display the calendar and delete all events on a specific date
delete_event_calendar() {
    # Asks user for which date to view
    search_date=$(yad --calendar --width=500 --height=200 --fontname="Sans 14" --center)
    if [ "$search_date" != "" ]; then
        # Searches the file "events.txt" for any dates matching the variable search_date
        # grep is used to search the text file for a variable equal to search_date
        matching_events=$(grep "^$search_date:" events.txt)
        # -n $matching_events is used here instead of if ["$matching_events" != "" ]; to prevent empty strings issues ""
        if [ -n "$matching_events" ]; then
            # grep -v copies everything from the events.txt except for the anything that is equal to the variable in $search_date
            grep -v "^$search_date:" events.txt >events_tmp.txt
            # mv renames "events_tmp.txt" back into "events.txt"
            mv events_tmp.txt events.txt
            yad --info --text="Events on $search_date have been deleted" --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
        else
            yad --info --text="No events found on $search_date" --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
        fi
    fi
}

# Function to handle the Calendar menu
calendar() {
    while true; do
        calendar_choice=$(yad --list --text "Pick an option" --radiolist --column "Pick" --column "Option" FALSE "View Calendar" FALSE "Set Event" FALSE "Delete Event" FALSE "Return" --separator="" --width=400 --height=220 --fontname="Sans 14" --center --print-column=2)
        case $calendar_choice in
        "View Calendar")
            view_calendar
            ;;
        "Set Event")
            set_event_calendar
            ;;
        "Delete Event")
            delete_event_calendar
            ;;
        "Return")
            break
            ;;
        "")
            break
            ;;
        esac
    done
}


# Function to delete files and directories
delete_item() {
    local path=$1

    # Check if it is a directory
    if [ -d "$path" ]; then
        # Check if there are directories inside the directory
        if [ "$(find "$path" -mindepth 1 -type d)" ]; then
            dir_list=$(find "$path" -mindepth 1 -type d)
            yad --info --text "Warning: There are directories inside the directory:\n$dir_list" --width=400 --height=300 --fontname="Sans 14" --center --button="Return":0
        else
            # Ask user for confirmation and delete the directory
            if yad --question --text "Are you sure you want to delete $path?" --width=400 --height=300 --fontname="Sans 14" --center; then
                rm -rf "$path" || yad --error --text "Failed to delete directory: $path"
            fi
        fi
    fi

    # Check if it is a file
    if [ -f "$path" ]; then
        # Ask user for confirmation and delete the file
        if yad --question --text "Are you sure you want to delete $path?" --width=400 --height=300 --fontname="Sans 14" --center; then
            rm "$path" || yad --error --text "Failed to delete file: $path"
        fi
    fi
}

# File management function (includes the delete_item function)
file_management() {
    while true; do
        del_choice=$(yad --list --text "Select an option" --radiolist --column "Pick" --column "Options" FALSE "Delete Item" FALSE "Explorer mode" --separator="" --width=400 --height=200 --fontname="Sans 14" --center --print-column=2)
        if [ -z "$del_choice" ]; then
            break
        fi

        if [ "$del_choice" == "Explorer mode" ]; then
            nautilus
            if [ -z "$path" ]; then
                continue # return to the previous menu
            fi
        else
            action=$(yad --entry --text "Enter the directory path or press okay to use the current directory" --width=400 --height=100 --fontname="Sans 14" --center --button=Cancel:1 --button=Okay:0)

            ret=$?

            if [ $ret -eq 1 ]; then
                continue # return to the previous menu
            fi

            if [ -z "$action" ]; then
                dir_path=$(pwd)
            else
                dir_path="$action"
            fi

            if [ ! -d "$dir_path" ]; then
                yad --info --text "The provided directory path does not exist." --width=400 --height=200 --fontname="Sans 20" --center --button="Return":0
                continue
            fi

            path=$(yad --list --column "Files and Directories" $(ls "$dir_path") --separator="" --width=400 --height=300 --fontname="Sans 14" --center)
            if [ -z "$path" ]; then
                continue # return to the previous menu
            fi

            path="$dir_path/$path"

            delete_item "$path"
        fi
    done
}


# Function to display System Info
sys_info() {
    "/home/asad/Documents/CST1500/Coursework 2/Coursework2 - Bash/main/sys_info.sh"
}

# Function to play different games
games() {
    # Allow the user to select a game to play.
    game=$(yad --list --text "Choose a game" --radiolist --column "Pick" --column "Game" FALSE "Dunnet" FALSE "Tetris" FALSE "Snake" FALSE "Gomoku" FALSE "Guess The Number" FALSE "Tic-Tac-Toe" --separator="" --width=400 --height=300 --fontname="Sans 14" --center --print-column=2)
    # If the user picked a game, start it.
    if [ "$game" != "" ]; then
        case $game in
        # Each game is started differently.
        # The "emacs -f" command starts emacs and calls a function.
        # The "full-path/game/*.exe" starts the game executable.
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
            "$PWD/guess_the_num.exe"
            ;;
        "Tic-Tac-Toe")
            "$PWD/tic_tac_toe.exe"
            ;;
        esac
    fi
}

web_browse() {
    # Ask the user for a URL or a keyword to search for.
    url=$(yad --entry --text "Enter keyword or URL" --width=400 --height=100 --fontname="Sans 14" --center)
    # If the user entered something, open it in a web browser.
    if [ "$url" != "" ]; then
        if [[ $url == http* ]]; then # it's a URL
            xdg-open "$url"
        else # it's a keyword, search with Google
            xdg-open "https://www.google.com/search?q=$url"
        fi
    fi
}

# Function to exit the script
quit() {
    exit 0
}

# Main function to display options and handle user choices
main() {
    # Start an infinite loop. The user will make choices until they choose to exit.
    while true; do
        # Display a dialog with several options for the user to pick from.
        # The result of their selection is stored in the variable "choice".
        choice=$(yad --list --text "Select an option" --radiolist --column "Pick" --column "Options" FALSE "Date/time" FALSE "Calendar" FALSE "File Management" FALSE "System Info" FALSE "Play a game" FALSE "Browse the web" FALSE "Git Options" FALSE "Convert MP4 to MP3" FALSE "Exit" --separator="" --width=400 --height=400 --fontname="Sans 14" --center --print-column=2)

        # If the user didn't make a selection (closed the dialog), restart the loop.
        if [ "$choice" == "" ]; then
            break
        fi

        # Handle the user's selection based on what they chose
        case $choice in
        "Date/time")
            date_time
            ;;
        "Calendar")
            calendar
            ;;
        "File Management")
            file_management
            ;;
        "System Info")
            sys_info
            ;;
        "Play a game")
            games
            ;;
        "Browse the web")
            web_browse
            ;;
        "Git Options")
            "/home/asad/Documents/CST1500/Coursework 2/Coursework2 - Bash/main/git_options.sh"
            ;;
        "Convert MP4 to MP3")
            "/home/asad/Documents/CST1500/Coursework 2/Coursework2 - Bash/main/extract_audio.sh"
            ;;
        "Exit")
            quit
            ;;
        esac
    done
}


# Call the main function to start the script
main
