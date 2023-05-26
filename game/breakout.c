#define RAYGUI_IMPLEMENTATION
#include "raylib.h"
#include "raygui.h"


#define NUM_BLOCKS_X 14
#define NUM_BLOCKS_Y 6

typedef struct Block {
    Rectangle rect;
    bool active;
} Block;

int main(void) {
    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib breakout");

    Vector2 ballPosition = { screenWidth/2, screenHeight/2 };
    Vector2 ballSpeed = { 4.0f, 4.0f };
    float ballRadius = 10.0f;

    Rectangle paddle = { screenWidth/2, screenHeight - 20, 60, 10 };
    Rectangle restartButton = { screenWidth - 100, 10, 80, 30 };

    Block blocks[NUM_BLOCKS_X*NUM_BLOCKS_Y] = { 0 };
    for (int y = 0; y < NUM_BLOCKS_Y; y++) {
        for (int x = 0; x < NUM_BLOCKS_X; x++) {
            blocks[y*NUM_BLOCKS_X + x].rect = (Rectangle){ x*60, y*20, 60, 20 };
            blocks[y*NUM_BLOCKS_X + x].active = true;
        }
    }

    SetTargetFPS(60);

    while (!WindowShouldClose()) {
        paddle.x = GetMouseX() - paddle.width/2;

        ballPosition.x += ballSpeed.x;
        ballPosition.y += ballSpeed.y;

        if (ballPosition.x < ballRadius || ballPosition.x > screenWidth - ballRadius) ballSpeed.x *= -1;
        if (ballPosition.y < ballRadius) ballSpeed.y *= -1;

        if (CheckCollisionCircleRec(ballPosition, ballRadius, paddle)) ballSpeed.y *= -1;

        for (Block *block = blocks; block < blocks + NUM_BLOCKS_X*NUM_BLOCKS_Y; block++) {
            if (block->active && CheckCollisionCircleRec(ballPosition, ballRadius, block->rect)) {
                block->active = false;
                ballSpeed.y *= -1;
                break;
            }
        }

        BeginDrawing();
            ClearBackground(RAYWHITE);
            DrawCircleV(ballPosition, ballRadius, DARKBLUE);
            DrawRectangleRec(paddle, LIME);

            for (Block *block = blocks; block < blocks + NUM_BLOCKS_X*NUM_BLOCKS_Y; block++) {
                if (block->active) DrawRectangleRec(block->rect, GOLD);
            }

            if (GuiButton(restartButton, "Restart")) {
                ballPosition = (Vector2){ screenWidth/2, screenHeight/2 };
                ballSpeed = (Vector2){ 4.0f, 4.0f };

                for (int y = 0; y < NUM_BLOCKS_Y; y++) {
                    for (int x = 0; x < NUM_BLOCKS_X; x++) {
                        blocks[y*NUM_BLOCKS_X + x].rect = (Rectangle){ x*60, y*20, 60, 20 };
                        blocks[y*NUM_BLOCKS_X + x].active = true;
                    }
                }
            }

        EndDrawing();
    }

    CloseWindow();
    return 0;
}
