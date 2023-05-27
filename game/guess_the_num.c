#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include "raylib.h"

int main()
{
    // Initialize screen dimensions
    const int screenWidth = 800;
    const int screenHeight = 450;

    // Initialize variables to store the game state
    bool is_lower = false; // If the guess is higher than the secret number
    bool is_higher = false; // If the guess is lower than the secret number
    bool is_win = false; // If the player has guessed the number

    // Initialize the window with the given screen size and name
    InitWindow(screenWidth, screenHeight, "Guess the Number");
    SetTargetFPS(60); // Set the game to run at 60 frames per second
    
    // Generate a random number between 1 and 100
    srand(time(NULL)); 
    int secretNumber = rand() % 100 + 1;

    // Initialize the player's guess and attempt count
    int guess = 0;
    int attempts = 0;

    // Main game loop
    while (!WindowShouldClose())
    {
        // Handle key presses
        if (IsKeyPressed(KEY_ENTER))
        {
            // Check the player's guess
            if (guess == secretNumber) 
            {
                is_win = true; // Player has won
            }
            else if (guess > secretNumber)
            {
                is_lower = true; // Guess is too high
                is_higher = false;
            }
            else if (guess < secretNumber)
            {
                is_higher = true; // Guess is too low
                is_lower = false;
            }

            // Reset the guess and increment attempts
            guess = 0;
            attempts++;
        }

        // Update the guess based on the number keys pressed
        if (guess <= 11) // Limit the maximum guess to 11
        {
            if (IsKeyPressed(KEY_ZERO))
            {
                guess = guess * 10 + 0;
            }
            if (IsKeyPressed(KEY_ONE))
            {
                guess = guess * 10 + 1;
            }
            if (IsKeyPressed(KEY_TWO))
            {
                guess = guess * 10 + 2;
            }
            if (IsKeyPressed(KEY_THREE))
            {
                guess = guess * 10 + 3;
            }
            if (IsKeyPressed(KEY_FOUR))
            {
                guess = guess * 10 + 4;
            }
            if (IsKeyPressed(KEY_FIVE))
            {
                guess = guess * 10 + 5;
            }
            if (IsKeyPressed(KEY_SIX))
            {
                guess = guess * 10 + 6;
            }
            if (IsKeyPressed(KEY_SEVEN))
            {
                guess = guess * 10 + 7;
            }
            if (IsKeyPressed(KEY_EIGHT))
            {
                guess = guess * 10 + 8;
            }
            if (IsKeyPressed(KEY_NINE))
            {
                guess = guess * 10 + 9;
            }
        }
        
        // Handle the backspace key, which removes the last digit from the guess
        if (IsKeyPressed(KEY_BACKSPACE))
        {
            guess = guess / 10;
        }
        
        // If the right shift key is held down, show the secret number
        if (IsKeyDown(KEY_RIGHT_SHIFT))
        {
            DrawText(TextFormat("%d", secretNumber), 20, 20, 20, BLACK);
        }

        // Begin drawing to the screen
        BeginDrawing();

        // Clear the screen
        ClearBackground(RAYWHITE);

        // Draw various elements to the screen, including the number of attempts, the current guess, and messages based on the game state
        DrawText("Guess the Number", 235, 10, 35, BLACK);
        DrawText(TextFormat("Attempts: %d", attempts), 10, 40, 25, BLACK);
        DrawText(TextFormat("Guess: %d", guess), 335, 200, 30, BLACK);

        // Display messages based on whether the guess is too high, too low, or correct
        if (is_win)
        {
            is_lower = false;
            is_higher = false;
            DrawText("Congratulations! You guessed the number",85, 80, 30,BLACK);
            ClearBackground(GREEN); // Change the background color to indicate a win
        }        
        else if (is_higher)
        {
            DrawText("Too low! Try again.",240, 80, 30,RED);
        }
        else if (is_lower)
        {
            DrawText("Too high! Try again.",240, 80, 30,GOLD);
        }

        // Finish drawing to the screen
        EndDrawing();
    }

    // Close the window when the game loop ends
    CloseWindow();

    return 0; // Indicate that the program has ended successfully
}

// create executable: gcc -o guess_the_num.exe guess_the_num.c -lraylib -lm