# Fun With Bash

"Fun With Bash" is a versatile script developed to handle different tasks. This script presents an interactive dialog-based interface using YAD that lets you access the date and time, a calendar, delete a file or directory, shows the system information, browse the web and play some cool classic games.

## Table of Contents

- [Features](#features)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Usage](#usage)
- [Contribution](#contribution)

## Features

The software offers the following functionalities:

1. **Date/Time:** Displays the current date and time.
2. **Calendar:** Allows to view the calendar and select a date. The chosen date is then displayed.
3. **Delete:** Gives the option to delete a file or a directory.
4. **System Info:** Displays user's system information like Operating System Type, CPU Info, Memory Info, Hard Disk Info, and File System Info.
5. **Play a game:** Provides a selection of games to play (Dunnet, Tetris, Snake, Gomoku, Guess The Number, Tic-Tac-Toe).
6. **Browse the web:** Allows to enter a keyword or a URL to open and search in the user's default web browser.
7. **Exit:** Exits the software.

## Dependencies

- **Bash:** The scripts are written in Bash.
- **Yad:** Yad (Yet Another Dialog) is a tool for creating graphical dialogs from shell scripts.

    Install by using the command:

  ```bash
  sudo apt-get install yad
  ```
- **Emacs:** The games are played through Emacs.

    Install by using the command:

  ```bash
  sudo apt-get install emacs
  ```
- **xfce4-terminal:** The terminal emulator used to run the emacs games. Usually pre-installed in Ubuntu.

     Install by using the command:

  ```bash
  sudo apt-get install xfce4-terminal
  ```
- **xdg-utils:** A set of tools for desktop environment interoperability, used here for web browsing.

    Install by using the command:
  ```bash
  sudo apt-get install xdg-utils
  ```

## Installation

- Ensure the bash files (`main.sh` and `sys_info.sh`) and the games (`tic_tac_toe.exe` and `guess_the_num.exe`) are executable. If not, use the following command to make them executable:

   ```bash
   chmod +x "/path/main/main.sh" "/path/main/sys_info.sh"
   ```
   ```bash
   chmod +x "/path/game/guess_the_num.exe"  "path/game/tic_tac_toe.exe"
   ```

## Usage

To start Fun With Bash software, navigate to the directory (`main`) containing the `main.sh` script and run:

```sh
./main.sh
```

The software will present a list of options:
1. **Date/Time**
2. **Calendar**
3. **Delete**
4. **System Info**
5. **Play a game**.
6. **Browse the web**
7. **Exit** 

 Select an option to proceed.
 
 If you choose 'Play a game', a list of games will appear:
1. **Dunnet**
2. **Tetris**
3. **Snake**
4. **Gomoku**
5. **Guess The Number**
6. **Tic-Tac-Toe**

Choose a game to play.

"Dunnet", "Tetris", "Snake", or "Gomoku" are Emacs games and will start in a new terminal window. Close the terminal window to end the game.

"Guess The Number" and "Tic-Tac-Toe" are both developed in C using Raylib library. They will run directly in the terminal from where the script was initiated. Follow the on-screen prompts to play the games.


## Functions

### main.sh

This script includes the following functions:

- `date_time`: Uses the `yad` tool to display the current date and time in a dialog box.
- `calendar`: Displays a calendar where you can select a date. if a date is selected, it will then be shown in a dialog box.
- `delete`: Allows deletion of a file or directory. It checks the entered path to prevent deletion of system files or directories and asks for confirmation before deletion of non system files.
- `sys_info`: Displays the system information by running the `sys_info.sh` script.
- `games`: Allow user to select and play a game. Emacs games are run in a new terminal window, while Guess The Number and Tic-Tac-Toe games run directly in the terminal.
- `web_browse`: Allows user to enter a URL or keyword for browsing the web. A URL will open directly, while a keyword will trigger a Google search.
- `quit`: Ends the script.
- `main`: Main function of the script. It starts an infinite loop presenting a list of options until the user chooses the `Exit` option.

### sys_info.sh

This script includes a loop that offers a list of system info options:

- Operating System Type
- CPU Info
- Memory Info
- Hard Disk Info
- File System Info

Based on the user's selection, the corresponding information is displayed in a dialog box.


## Yad:

Yad (Yet Another Dialog) is a tool for creating graphical dialogs from shell scripts.
It is a fork of Zenity dialog with more features and improvements. 
In the Fun With Bash scripts, `yad` is used for displaying dialog boxes for various functions.

### Yad commands:

1. `yad --info`: Displays an information dialog box. The text to be displayed inside the dialog box is specified after `--text`.

2. `yad --calendar`: Creates a calendar dialog, which allows user to select a date.

3. `yad --list`: Generates a list dialog. It allows user to select one or more items from a list.

4. `yad --radiolist`: This option is used in conjunction with `--list` to create a list of radio buttons where only one item can be selected. The `--column` option is used to specify the columns in the list. The `FALSE` keyword is used to uncheck a radio button by default.

5. `yad --entry`: Creates an entry dialog box, which allows user to input text.

6. `yad --question`: Generates a question dialog box. Typically used to ask a yes/no question. In the script, it's used in the `delete` function to ask for confirmation before deleting a file or directory.

7. `yad --width` and `yad --height`: Used to specify the width and height of the dialog box.

8. `yad --fontname`: Used to set the font of the dialog box.

9. `yad --center`: Centers the dialog box on the screen.

10. `yad --print-column`: Prints the specified column when an item is selected. If `2` is passed, it will print the second column.

11. `yad --separator`: Sets the output field separator. If `""` is passed, it will use newline as the separator.


## Syntax Explanation


- **`[[ ... ]]` vs `[ ... ]`**: In bash scripting, both are used for conditional expressions. However, `[[ ... ]]` is more modern and has more functionality compared to `[ ... ]`.

  For example, inside `[[ ... ]]`, one can use:
  - `&&` for logical AND
  - `||` for logical OR
  - `<` and `>` for string comparison
  
  which is not possible using `[ ... ]`.

- **`$()` vs `` ` ` ``**: Both are used for command substitution. `$()` is more modern and recommended as it easily allows nested commands.

- **`xdg-open` command**: Tool that allows the user to open a file or URL in the user's preferred application.
In the script, `xdg-open` is used to open a URL in the user's default web browser.

- **Function declaration in Bash**: In bash scripting, a function is declared using the following syntax: `function_name () { commands; }`. The function is then called by its name elsewhere in the script.

- **Subshell**: A subshell is a separate instance of the bash shell that's started to execute a script or a command. In the `main.sh` script, we run Emacs games in a new terminal (a subshell) using the command `xfce4-terminal -e "command"`. This allows the main script to keep running while the game is played.


## Contribution

- **Mohmmad Asad Atterkhan:**
  - Coded the core Bash scripts (`main.sh` and `sys_info.sh`).
  - Added additional features using Emacs.
  - Documented the project.

- **Hemant Mooneea:**
  - Refined `main.sh` and `sys_info.sh`.
  - Developed two games: Tic-Tac-Toe and Guess The Number, in C.
  - Modularized `main.sh` by refactoring the code into functions.

