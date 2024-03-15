
# README

## Fun With Bash

"Fun With Bash" is a versatile script developed to handle different tasks. This script presents an interactive dialog-based interface using YAD that lets you access the date and time, a calendar, delete a file or directory, shows the system information, browse the web, play games, perform Git operations, and extract audio from video files or YouTube URLs.

## Features

The software offers the following functionalities:

1. **Date/Time:** Displays the current date and time.
2. **Calendar:** Allows you to view and manage events in a calendar.
3. **File management:** Provides options to manage files.
4. **System Info:** Retrieves system information such as the operating system type, CPU info, memory info, hard disk info, and file system info.
5. **Play a game:** Offers a selection of games to play.
6. **Browse the web:** Allows you to enter a keyword or a URL to open in your default web browser.
7. **Git Options:** Provides Git-related functionalities such as initializing a repository, pulling, pushing, checking status, adding files, committing, and cloning.
8. **Convert MP4 to Audio:** Enables extraction of audio from local video files or YouTube URLs.
9. **Exit:** Terminates the software.

## Dependencies

- **Bash:** The scripts are written in Bash.
- **Yad:** Yad (Yet Another Dialog) is a tool for creating graphical dialogs from shell scripts. Install it using the command: `sudo apt-get install yad`
- **Emacs:** The games are played through Emacs. Install it using the command: `sudo apt-get install emacs`
- **xfce4-terminal:** The terminal emulator used to run the Emacs games. It is usually pre-installed in Ubuntu. Install it using the command: `sudo apt-get install xfce4-terminal`
- **xdg-utils:** A set of tools for desktop environment interoperability, used here for web browsing. Install it using the command: `sudo apt-get install xdg-utils`

## Installation

1. Make sure the bash files (`main.sh`, `sys_info.sh`, `extract_audio.sh`, `git_options.sh`) and the games (`guess_the_num.exe`, `tic_tac_toe.exe`) are executable. If not, use the following command to make them executable:
   ```bash
   chmod +x main.sh sys_info.sh extract_audio.sh git_options.sh guess_the_num.exe tic_tac_toe.exe
   ```

## Usage

To use the "Fun With Bash" software, navigate to the directory containing the `main.sh` script and run:
```bash
./main.sh
```
The software will present a list of options. Select an option to proceed.

If you choose to play a game, a list of games will appear. Choose a game to play.

Emacs games (Dunnet, Tetris, Snake, Gomoku) will start in a new terminal window. Close the terminal window to end the game.

Guess The Number and Tic-Tac-Toe games run directly in the terminal from where the script was initiated. Follow the on-screen prompts to play the games.

## Functions

### main.sh

This script includes the following functions:

- `date_time`: Displays the current date and time using the `yad` tool in a dialog box.
- `calendar`: Displays a calendar using the `yad` tool, allowing you to select a date and view events.
- `delete_item`: Deletes files and directories, with confirmation prompts and checks for system directories.
- `file_management`: Allows you to explore directories and delete files and directories.
- `sys_info`: Runs the `sys_info.sh` script to display system information.
- `games`: Allows you to play different games, including Emacs games and C-based games.
- `browse_web`: Opens a web browser with a provided URL or performs a web search with a keyword.
- `git_options`: Provides various Git-related functionalities using the `git_options.sh` script.
- `convert_audio`: Allows you to extract audio from a local video file or a YouTube URL using the `extract_audio.sh` script.
- `quit`: Terminates the script.

### sys_info.sh

This script includes a loop that offers a list of system info options:

- Operating System Type
- CPU Info
- Memory Info
- Hard Disk Info
- File System Info

Based on the user's selection, the corresponding information is displayed in a dialog box.

### extract_audio.sh

This script allows you to extract audio from a local video file or a YouTube URL. It provides options to choose a local video file or enter a YouTube URL. The audio is extracted and saved in AAC format.

### git_options.sh

This script provides various Git-related functionalities. It allows you to initialize a Git repository, pull changes from a remote repository, push changes to a remote repository, check the status of a repository, add files to the repository, commit changes, and clone a remote repository.

## YAD & Syntax Explanation

### YAD

YAD (Yet Another Dialog) is a tool for creating graphical dialogs from shell scripts. It is a fork of Zenity dialog with more features and improvements. In the "Fun With Bash" scripts, `yad` is used for displaying dialog boxes for various functions.

#### Yad commands:

- `yad --info`: Displays an information dialog box.
- `yad --calendar`: Creates a calendar dialog.
- `yad --list`: Generates a list dialog.
- `yad --radiolist`: Creates a list of radio buttons.
- `yad --entry`: Creates an entry dialog box.
- `yad --question`: Generates a question dialog box.
- `yad --width` and `yad --height`: Used to specify the width and height of the dialog box.
- `yad --fontname`: Used to set the font of the dialog box.
- `yad --center`: Centers the dialog box on the screen.
- `yad --print-column`: Prints the specified column when an item is selected.
- `yad --separator`: Sets the output field separator.

### Syntax Explanation

- `[[ ... ]]` vs `[ ... ]`: Both are used for conditional expressions, but `[[ ... ]]` is more modern and recommended as it has more functionality.
- `$()` vs `` ` ` ``: Both are used for command substitution, but `$()` is more modern and recommended.
- `xdg-open` command: Opens a file or URL in the user's preferred application.
- Function declaration in Bash: Functions are declared using the syntax `function_name () { commands; }`.
- Subshell: A separate instance of the bash shell that's started to execute a script or a command. In the "Fun With Bash" script, we run Emacs games in a new terminal using the command `xfce4-terminal -e "command"`.
