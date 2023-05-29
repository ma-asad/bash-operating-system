while true; do
    # Prompt the user to select an option: Local file or YouTube URL
    choice=$(yad --list --text "Select an option" --radiolist --column "Pick" --column "Option" FALSE "Local file" FALSE "YouTube URL" --separator="" --width=400 --height=220 --fontname="Sans 14" --center --print-column=2)
    case $choice in
    "Local file")
        # If "Local file" option is chosen, let the user choose a video file
        path=$(yad --file-selection --title="Choose a video file")
        if [ -z "$path" ]; then
            continue
        fi
        ;;
    "YouTube URL")
        # If "YouTube URL" option is chosen, let the user enter a YouTube URL
        url=$(yad --entry --text "Enter the YouTube URL" --width=400 --height=100 --fontname="Sans 14" --center)
        if [ -z "$url" ]; then
            continue
        fi
        # Download the audio from the YouTube URL using yt-dlp and save it as a temporary file
        path=$(mktemp --suffix=".m4a")
        ~/.local/bin/yt-dlp --no-continue -o "$path" -f 'bestaudio[ext=m4a]' "$url"
        ;;
    *)
        # If neither "Local file" nor "YouTube URL" is chosen, exit the loop
        break
        ;;
    esac

    if [ -f "$path" ]; then
        # If the chosen file exists, let the user select a location to save the output audio file
        output_audio=$(yad --file-selection --save --title="Choose a location for the output audio file" --filename="$HOME/Downloads/example.m4a")
        if [ -z "$output_audio" ]; then
            continue
        fi
        # Convert the input file to AAC format and save it to the chosen location
        ffmpeg -i "$path" -vn -c:a aac "$output_audio"
    else
        # If the chosen file does not exist, show an error message
        yad --info --text "The provided file does not exist." --width=400 --height=200 --fontname="Sans 20" --center --button="Return":0
    fi
done
