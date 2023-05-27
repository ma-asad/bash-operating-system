#include <raylib.h>

#define GRID_SIZE 3
#define CELL_SIZE 200
#define BUTTON_WIDTH 200
#define BUTTON_HEIGHT 50

int board[GRID_SIZE][GRID_SIZE];
int player;
int winLineStartX, winLineStartY, winLineEndX, winLineEndY;
Rectangle resetButton;

void DrawBoard() {
    // Draw horizontal and vertical lines
    for (int i = 1; i < GRID_SIZE; i++) {
        DrawLine(0, i * CELL_SIZE, GRID_SIZE * CELL_SIZE, i * CELL_SIZE, BLACK);
        DrawLine(i * CELL_SIZE, 0, i * CELL_SIZE, GRID_SIZE * CELL_SIZE, BLACK);
    }
    
    // Draw X and O
    for (int y = 0; y < GRID_SIZE; y++) {
        for (int x = 0; x < GRID_SIZE; x++) {
            Vector2 pos = { x * CELL_SIZE + CELL_SIZE / 3, y * CELL_SIZE + CELL_SIZE / 3 };
            if (board[x][y] == 1) DrawText("X", pos.x, pos.y, CELL_SIZE / 2, RED);
            if (board[x][y] == 2) DrawText("O", pos.x, pos.y, CELL_SIZE / 2, BLUE);
        }
    }
    
    // Draw the win line
    if (winLineStartX != -1 && winLineStartY != -1 && winLineEndX != -1 && winLineEndY != -1) {
        DrawLine(winLineStartX * CELL_SIZE + CELL_SIZE / 2, winLineStartY * CELL_SIZE + CELL_SIZE / 2, winLineEndX * CELL_SIZE + CELL_SIZE / 2, winLineEndY * CELL_SIZE + CELL_SIZE / 2, BLACK);
    }

    // Draw reset button
    DrawRectangleRec(resetButton, LIGHTGRAY);
    if (CheckCollisionPointRec(GetMousePosition(), resetButton)) {
        DrawRectangleLinesEx(resetButton, 2, DARKGRAY);
        if (IsMouseButtonReleased(MOUSE_LEFT_BUTTON)) {
            ResetBoard();
        }
    }
    DrawText("Reset", resetButton.x + resetButton.width/4, resetButton.y + resetButton.height/4, 20, BLACK);
}

void ResetBoard() {
    for (int y = 0; y < GRID_SIZE; y++)
        for (int x = 0; x < GRID_SIZE; x++)
            board[x][y] = 0;

    winLineStartX = -1;
    winLineStartY = -1;
    winLineEndX = -1;
    winLineEndY = -1;
}

bool CheckWin(int player) {
    for (int i = 0; i < GRID_SIZE; i++) {
        if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
            winLineStartX = i;
            winLineStartY = 0;
            winLineEndX = i;
            winLineEndY = 2;
            return true;
        }
        if (board[0][i] == player && board[1][i] == player && board[2][i] == player) {
            winLineStartX = 0;
            winLineStartY = i;
            winLineEndX = 2;
            winLineEndY = i;
            return true;
        }
    }
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
        winLineStartX = 0;
        winLineStartY = 0;
        winLineEndX = 2;
        winLineEndY = 2;
        return true;
    }
    if (board[2][0] == player && board[1][1] == player && board[0][2] == player) {
        winLineStartX = 2;
        winLineStartY = 0;
        winLineEndX = 0;
        winLineEndY = 2;
        return true;
    }
    return false;
}

bool CheckDraw() {
    for (int y = 0; y < GRID_SIZE; y++) {
        for (int x = 0; x < GRID_SIZE; x++) {
            if (board[x][y] == 0)
                return false;
        }
    }
    return true;
}

int main(void) {
    InitWindow(CELL_SIZE * GRID_SIZE, CELL_SIZE * GRID_SIZE + BUTTON_HEIGHT + 40, "Tic Tac Toe");
    SetTargetFPS(60);
    
    ResetBoard();
    player = 1;
    resetButton = (Rectangle){(GRID_SIZE * CELL_SIZE - BUTTON_WIDTH) / 2, GRID_SIZE * CELL_SIZE + 20, BUTTON_WIDTH, BUTTON_HEIGHT};
    
    while (!WindowShouldClose()) {
        if (IsMouseButtonPressed(MOUSE_LEFT_BUTTON)) {
            Vector2 mousePos = GetMousePosition();
            int cellX = mousePos.x / CELL_SIZE;
            int cellY = mousePos.y / CELL_SIZE;
            if (cellX < GRID_SIZE && cellY < GRID_SIZE && board[cellX][cellY] == 0) {
                board[cellX][cellY] = player;
                if (CheckWin(player)) {
                    // No immediate reset
                } else if (CheckDraw()) {
                    // No immediate reset
                } else {
                    player = 3 - player;
                }
            }
        }

        BeginDrawing();
        ClearBackground(RAYWHITE);
        DrawBoard();
        EndDrawing();
    }
    
    CloseWindow();
    
    return 0;
}
