while true; do
    # Ask user for git directory
    git_directory=$(yad --file --directory --title="Select Git directory" --width=400 --height=200 --fontname="Sans 14" --center)

    if [ "$git_directory" == "" ] || [ "$git_directory" == "Exit" ]; then
        break
    fi

    if [ "$git_directory" != "" ]; then
        # Ask user for git command to execute
        git_command=$(yad --list --text "Select a Git command" --radiolist --column "Pick" --column "Options" FALSE "Init" FALSE "Pull" FALSE "Push" FALSE "Status" FALSE "Add" FALSE "Commit" FALSE "Clone" --separator="" --width=400 --height=200 --fontname="Sans 14" --center --print-column=2)

        # Validate if directory contains a git repository
        if [ "$git_command" != "Init" ] && [ ! -d "$git_directory/.git" ]; then
            yad --info --text="The chosen directory is not a git repository. Please choose a valid git repository." --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
        else
            # Change to the specified directory
            cd "$git_directory" || return
            case "$git_command" in
                "Init")
                    git_output=$(git init 2>&1)
                    yad --info --text="$git_output" --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
                    ;;
                "Pull")
                    git_output=$(git pull 2>&1)
                    yad --info --text="$git_output" --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
                    ;;
                "Push")
                    git_output=$(git push 2>&1)
                    yad --info --text="$git_output" --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
                    ;;
                "Status")
                    git_output=$(git status 2>&1)
                    yad --info --text="$git_output" --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
                    ;;
                "Add")
                    # Asks User for the file to add
                    file_to_add=$(yad --file --title="Select file to add" --width=400 --height=200 --fontname="Sans 14" --center)
                    # Asks User for confirmation
                    confirmation=$(yad --question --text="Are you sure you want to add this file?" --width=400 --height=100 --fontname="Sans 14" --center)
                    if [ $? -eq 0 ]; then
                        git_output=$(git add "$file_to_add" 2>&1)
                        yad --info --text="$git_output" --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
                    fi
                    ;;
                "Commit")
                    # Asks User for the commit message
                    commit_msg=$(yad --entry --text "Enter commit message" --width=400 --height=100 --fontname="Sans 14" --center)
                    git_output=$(git commit -m "$commit_msg" 2>&1)
                    yad --info --text="$git_output" --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
                    ;;
                "Clone")
                    # Asks User for the repository URL to clone
                    repo_url=$(yad --entry --text "Enter repository URL to clone" --width=400 --height=100 --fontname="Sans 14" --center)
                    git_output=$(git clone "$repo_url" 2>&1)
                    yad --info --text="$git_output" --width=400 --height=100 --fontname="Sans 14" --center --button="Return":0
                    ;;
            esac
        fi
    fi
done
