#include <raylib.h>  // Import the raylib game development library.

// Define the size of the Tic Tac Toe grid and the cell size in pixels. 
#define GRID_SIZE 3
#define CELL_SIZE 200
#define BUTTON_WIDTH 200
#define BUTTON_HEIGHT 50

// Initialize the game state variables.
int board[GRID_SIZE][GRID_SIZE];  // The game board.
int player;  // The current player (1 or 2).
int winLineStartX, winLineStartY, winLineEndX, winLineEndY;  // The start and end points of the winning line.
Rectangle resetButton;  // The "Reset" button.

// Function to draw the game board.
void DrawBoard() {
    // Draw the grid lines.
    for (int i = 1; i < GRID_SIZE; i++) {
        DrawLine(0, i * CELL_SIZE, GRID_SIZE * CELL_SIZE, i * CELL_SIZE, BLACK);  // Horizontal line.
        DrawLine(i * CELL_SIZE, 0, i * CELL_SIZE, GRID_SIZE * CELL_SIZE, BLACK);  // Vertical line.
    }
    
    // Draw the X and O markers.
    for (int y = 0; y < GRID_SIZE; y++) {
        for (int x = 0; x < GRID_SIZE; x++) {
            Vector2 pos = { x * CELL_SIZE + CELL_SIZE / 3, y * CELL_SIZE + CELL_SIZE / 3 };  // Position to draw the marker.
            if (board[x][y] == 1) DrawText("X", pos.x, pos.y, CELL_SIZE / 2, RED);  // Draw "X".
            if (board[x][y] == 2) DrawText("O", pos.x, pos.y, CELL_SIZE / 2, BLUE);  // Draw "O".
        }
    }
    
    // Draw the winning line, if any.
    if (winLineStartX != -1 && winLineStartY != -1 && winLineEndX != -1 && winLineEndY != -1) {
        DrawLine(winLineStartX * CELL_SIZE + CELL_SIZE / 2, winLineStartY * CELL_SIZE + CELL_SIZE / 2, winLineEndX * CELL_SIZE + CELL_SIZE / 2, winLineEndY * CELL_SIZE + CELL_SIZE / 2, BLACK);
    }

    // Draw the "Reset" button.
    DrawRectangleRec(resetButton, LIGHTGRAY);  // Button background.
    // If mouse pointer is over the button, draw a border around it and reset the game if clicked.
    if (CheckCollisionPointRec(GetMousePosition(), resetButton)) {
        DrawRectangleLinesEx(resetButton, 2, DARKGRAY);
        if (IsMouseButtonReleased(MOUSE_LEFT_BUTTON)) {
            ResetBoard();
        }
    }
    DrawText("Reset", resetButton.x + resetButton.width/4, resetButton.y + resetButton.height/4, 20, BLACK);  // Button text.
}

// Function to reset the game state.
void ResetBoard() {
    // Clear the game board.
    for (int y = 0; y < GRID_SIZE; y++)
        for (int x = 0; x < GRID_SIZE; x++)
            board[x][y] = 0;

    // Clear the winning line.
    winLineStartX = -1;
    winLineStartY = -1;
    winLineEndX = -1;
    winLineEndY = -1;
}

// Function to check if a player has won.
bool CheckWin(int player) {
    // Check rows and columns.
    for (int i = 0; i < GRID_SIZE; i++) {
        if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {  // Check row.
            winLineStartX = i;
            winLineStartY = 0;
            winLineEndX = i;
            winLineEndY = 2;
            return true;
        }
        if (board[0][i] == player && board[1][i] == player && board[2][i] == player) {  // Check column.
            winLineStartX = 0;
            winLineStartY = i;
            winLineEndX = 2;
            winLineEndY = i;
            return true;
        }
    }
    // Check diagonals.
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {  // Check main diagonal.
        winLineStartX = 0;
        winLineStartY = 0;
        winLineEndX = 2;
        winLineEndY = 2;
        return true;
    }
    if (board[2][0] == player && board[1][1] == player && board[0][2] == player) {  // Check other diagonal.
        winLineStartX = 2;
        winLineStartY = 0;
        winLineEndX = 0;
        winLineEndY = 2;
        return true;
    }
    return false;  // No win found.
}

// Function to check if the game is a draw (all cells filled, no win).
bool CheckDraw() {
    for (int y = 0; y < GRID_SIZE; y++) {
        for (int x = 0; x < GRID_SIZE; x++) {
            if (board[x][y] == 0)  // Empty cell found, game is not a draw.
                return false;
        }
    }
    return true;  // All cells filled, game is a draw.
}

int main(void) {
    InitWindow(CELL_SIZE * GRID_SIZE, CELL_SIZE * GRID_SIZE + BUTTON_HEIGHT + 40, "Tic Tac Toe");  // Initialize the window.
    SetTargetFPS(60);  // Set the frame rate.
    
    ResetBoard();  // Reset the game state.
    player = 1;  // Set the initial player.
    resetButton = (Rectangle){(GRID_SIZE * CELL_SIZE - BUTTON_WIDTH) / 2, GRID_SIZE * CELL_SIZE + 20, BUTTON_WIDTH, BUTTON_HEIGHT};  // Initialize the "Reset" button.
    
    // Main game loop.
    while (!WindowShouldClose()) {
        // Handle mouse clicks.
        if (IsMouseButtonPressed(MOUSE_LEFT_BUTTON)) {
            Vector2 mousePos = GetMousePosition();
            int cellX = mousePos.x / CELL_SIZE;
            int cellY = mousePos.y / CELL_SIZE;
            // If click is within the board and cell is empty, mark it and check for win/draw. If none, switch player.
            if (cellX < GRID_SIZE && cellY < GRID_SIZE && board[cellX][cellY] == 0) {
                board[cellX][cellY] = player;
                if (CheckWin(player)) {
                    // Player has won. Game ends without immediate reset.
                } else if (CheckDraw()) {
                    // Game is a draw. Game ends without immediate reset.
                } else {
                    player = 3 - player;  // Switch player.
                }
            }
        }

        BeginDrawing();  // Start drawing.
        ClearBackground(RAYWHITE);  // Clear the background.
        DrawBoard();  // Draw the game board.
        EndDrawing();  // End drawing.
    }
    
    CloseWindow();  // Close the window when game loop ends.
    
    return 0;  // End the program.
}
