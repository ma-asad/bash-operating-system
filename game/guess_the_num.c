#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "raylib.h"
#include <stdbool.h>
int main()
{
    // Initialization
    const int screenWidth = 800;
    const int screenHeight = 450;
    bool is_lower = false;
    bool is_higher = false;
    bool is_win = false;
    InitWindow(screenWidth, screenHeight, "Guess the Number");
    SetTargetFPS(60);
    
    // Generate random number
    srand(time(NULL));
    int secretNumber = rand() % 100 + 1;

    int guess = 0;
    int attempts = 0;

    while (!WindowShouldClose())
    {
        // Update
        if (IsKeyPressed(KEY_ENTER))
        {
            // Check if the guess is correct
            if (guess == secretNumber)
            {
                is_win = true;

            }
            if (guess > secretNumber)
            {
                is_lower = true;
                is_higher = false;
            }
            if (guess < secretNumber)
            {
                is_higher = true;
                is_lower = false;
            }

            guess = 0;
            attempts++;
        }

        if (guess <= 11)
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
        
        if (IsKeyPressed(KEY_BACKSPACE))
        {
            guess = guess / 10;
        }
        if (IsKeyDown(KEY_RIGHT_SHIFT))
        {
            DrawText(TextFormat("%d", secretNumber), 20, 20, 20, BLACK);
        }

        // Draw
        BeginDrawing();

        ClearBackground(RAYWHITE);
        DrawText("Guess the Number", 235, 10, 35, BLACK);
        DrawText(TextFormat("Attempts: %d", attempts), 10, 40, 25, BLACK);
        DrawText(TextFormat("Guess: %d", guess), 335, 200, 30, BLACK);
        if (is_win)
        {   
            is_lower = false;
            is_higher = false;
            DrawText("Congratulations! You guessed the number",85, 80, 30,BLACK);
            ClearBackground(GREEN);
        }        
        if (is_higher)
        {
            DrawText("Too low! Try again.",240, 80, 30,RED);

        }
        if (is_lower)
        {
            DrawText("Too high! Try again.",240, 80, 30,GOLD);
        }

        EndDrawing();
    }

    CloseWindow();

    return 0;
}