#include <raylib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

#define MAX_WORD_LENGTH 100
#define MAX_WRONG_GUESSES 7
#define MAX_INPUT_CHARS 20
#define SCREEN_WIDTH 800
#define SCREEN_HEIGHT 450
#define MAX_WORDS 500

// Hangman parts
Vector2 baseStart = {150, 400};
Vector2 baseEnd = {250, 400};
Vector2 poleStart = {200, 400};
Vector2 poleEnd = {200, 150};
Vector2 topStart = {200, 150};
Vector2 topEnd = {300, 150};
Vector2 ropeEnd = {300, 200};
Rectangle head = {275, 200, 50, 50};
Rectangle body = {300, 250, 10, 100};
Vector2 leftArmStart = {300, 250};
Vector2 leftArmEnd = {250, 300};
Vector2 rightArmStart = {310, 250};
Vector2 rightArmEnd = {360, 300};
Vector2 leftLegStart = {300, 350};
Vector2 leftLegEnd = {250, 400};
Vector2 rightLegStart = {310, 350};
Vector2 rightLegEnd = {360, 400};

typedef struct {
    const char* word;
    char guesses[MAX_WORD_LENGTH];
    int wrongGuessCount;
    char letters[26];
} HangmanGame;

const char* getRandomWordFromFile(FILE* file) {
    static char words[MAX_WORDS][MAX_WORD_LENGTH];
    int numWords = 0;
    
    // Read words from the file into the array
    while (fgets(words[numWords], MAX_WORD_LENGTH, file) != NULL) {
        // Remove newline at end of word, if it exists
        char* newline = strchr(words[numWords], '\n');
        if (newline != NULL) {
            *newline = '\0';
        }
        numWords++;
        if (numWords == MAX_WORDS) {
            break;
        }
    }
    
    // Check if any words were read
    if (numWords == 0) {
        printf("No words in file.\n");
        return NULL;
    }
    
    // Seed the random number generator and pick a random word
    srand(time(NULL));
    return words[rand() % numWords];
}


void ResetGame(HangmanGame* game, FILE* file) {
    game->word = getRandomWordFromFile(file);
    game->guesses[0] = '\0';
    game->wrongGuessCount = 0;
    for (int i = 0; i < 26; i++) {
        game->letters[i] = 0;  // 0 means letter not yet guessed
    }
}

void DrawHangman(HangmanGame* game) {
    ClearBackground(RAYWHITE);

    DrawLineV(baseStart, baseEnd, BLACK);
    DrawLineV(poleStart, poleEnd, BLACK);
    DrawLineV(topStart, topEnd, BLACK);
    DrawLineV(topEnd, ropeEnd, BLACK);
    
    if (game->wrongGuessCount > 0) DrawRectangleRec(head, BLACK);
    if (game->wrongGuessCount > 1) DrawRectangleRec(body, BLACK);
    if (game->wrongGuessCount > 2) DrawLineV(leftArmStart, leftArmEnd, BLACK);
    if (game->wrongGuessCount > 3) DrawLineV(rightArmStart, rightArmEnd, BLACK);
    if (game->wrongGuessCount > 4) DrawLineV(leftLegStart, leftLegEnd, BLACK);
    if (game->wrongGuessCount > 5) DrawLineV(rightLegStart, rightLegEnd, BLACK);
    
    if (game->wrongGuessCount > 6) {
        DrawText("GAME OVER", 250, 100, 20, RED);
        DrawText(TextFormat("Word was: %s", game->word), 250, 125, 20, RED);
    } else {
        int wordLen = strlen(game->word);
        for (int i = 0; i < wordLen; i++) {
            if (strchr(game->guesses, game->word[i]) != NULL) {
                DrawText(TextSubtext(game->word, i, 1), 350 + 20 * i, 400, 20, BLACK);
            } else {
                DrawText("_", 350 + 20 * i, 400, 20, BLACK);
            }
        }
    }

    // draw the alphabet at the top
    for (int i = 0; i < 26; i++) {
        char letter[2] = { 'A' + i , '\0' };
        if (game->letters[i] == 0) {
            DrawText(letter, 10 + i * 20, 10, 20, BLACK);
        } else if (game->letters[i] == 1) {
            DrawText(letter, 10 + i * 20, 10, 20, GREEN);
        } else {
            DrawText(letter, 10 + i * 20, 10, 20, RED);
        }
    }
}

void UpdateHangman(HangmanGame* game) {
    if (IsKeyPressed(KEY_BACKSPACE)) {
        int len = strlen(game->guesses);
        if (len > 0) game->guesses[len - 1] = '\0';
    } else if (IsKeyPressed(KEY_R)) {
        // reset the game when 'R' is pressed
        FILE* file = fopen("word_list.txt", "r");
        if (file != NULL) {
            ResetGame(game, file);
            fclose(file);
        }
    } else {
        int key = GetKeyPressed();
        if ((key >= KEY_A && key <= KEY_Z) || (key >= KEY_ZERO && key <= KEY_NINE)) {
            // your existing code...
            // mark the letter as guessed
            if(strchr(game->word, key + 'a')) {
                game->letters[key - KEY_A] = 1; // if the guess is correct
            } else {
                game->letters[key - KEY_A] = 2; // if the guess is incorrect
                game->wrongGuessCount++; // increment the count of wrong guesses
            }
        }
    }
}


int main(void) {
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Hangman Game");
    SetTargetFPS(60);
    
    FILE* file = fopen("word_list.txt", "r");
    if (file == NULL) {
        printf("Failed to open word list.\n");
        return -1;
    }

    HangmanGame game;
    ResetGame(&game, file);

    fclose(file);
    
    while (!WindowShouldClose()) {
        UpdateHangman(&game);
        BeginDrawing();
        DrawHangman(&game);
        EndDrawing();
    }

    CloseWindow();

    return 0;
}