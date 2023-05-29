while true; do
    choice=$(yad --list --text "Select an option" --radiolist --column "Pick" --column "Option" FALSE "Local file" FALSE "YouTube URL" --separator="" --width=400 --height=220 --fontname="Sans 14" --center --print-column=2)
    case $choice in
    "Local file")
        path=$(yad --file-selection --title="Choose a video file")
        if [ -z "$path" ]; then
            continue
        fi
        ;;
    "YouTube URL")
        url=$(yad --entry --text "Enter the YouTube URL" --width=400 --height=100 --fontname="Sans 14" --center)
        if [ -z "$url" ]; then
            continue
        fi
        path=$(mktemp --suffix=".m4a")
        ~/.local/bin/yt-dlp --no-continue -o "$path" -f 'bestaudio[ext=m4a]' "$url"
        ;;
    *)
        break
        ;;
    esac

    if [ -f "$path" ]; then
        output_audio=$(yad --file-selection --save --title="Choose a location for the output audio file" --filename="$HOME/Downloads/example.m4a")
        if [ -z "$output_audio" ]; then
            continue
        fi

        ffmpeg -i "$path" -vn -c:a aac "$output_audio"
    else
        yad --info --text "The provided file does not exist." --width=400 --height=200 --fontname="Sans 20" --center --button="Return":0
    fi
done
