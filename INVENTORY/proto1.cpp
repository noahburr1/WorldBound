# include <iostream>
# include <vector>

# include "raylib.h"

using namespace std;

# define print(x) cout << x << endl;

# define SCREEN_WIDTH 512
# define SCREEN_HEIGHT 320


struct PLATFORM {
	Rectangle rect;
	Texture2D image;
};

struct SPRITES {
	Vector2 position;
	Rectangle rect;
	Texture2D image;
};

enum STATE {
	RIGHT,
	LEFT
};

int main(){
	// SCREEN
	InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Prototype");

	// PLATFORM
	vector<vector<int>> environment = {
		{0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0},
		{1, 1, 1, 1, 1, 1, 1, 1}
	};

	Texture2D ground = LoadTexture("assets/tiles_rock/tile5.png");

	PLATFORM platform; // define platform struct

	vector<PLATFORM> platform_store = {};

	float y = 0;
	for (int row=0; row < environment.size(); row++){
		float x = 0;
		for (int j=0; j < environment[row].size(); j++){
			if (environment[row][j] == 1){
				platform_store.push_back({{x, y, 64, 64}, ground});
			}

			x += 64;
		}	

		y += 64;
	}


	// PLAYER
	SPRITES player;
	Texture2D player_img = LoadTexture("assets/right_running.png");
	player.position = {0, 128};
	player.rect = {0, 0, 128, 128}; // frame rect
	int frameCount = 0;
	int frameTimer = 0;

	enum STATE player_state = RIGHT;


	SPRITES left_player;
	Texture2D left_player_img = LoadTexture("assets/left_running.png");
	left_player.position = {0, 128};
	left_player.rect = {0, 0, 128, 128}; // frame rect
	int leftframeCount = 0;
	int leftframeTimer = 0;


	// FPS
	SetTargetFPS(60);

	// GAME LOOP
	while(!WindowShouldClose()){
		float dt = GetFrameTime();

		if (IsKeyDown(KEY_RIGHT)){
			player_state = RIGHT;

			frameTimer++;

			if (frameTimer >= 3){
				frameTimer = 0;	
				frameCount++;

				if (frameCount >= 12){
					frameCount = 0;
				}


				player.rect.x = frameCount * player.rect.width;

			}

			player.position.x += 200*dt;	

			if (player.position.x > SCREEN_WIDTH){
				player.position.x = 0;
			}

			left_player.position.x = player.position.x;

		}

		if (IsKeyDown(KEY_LEFT)){
			player_state = LEFT;	

			leftframeTimer++;

			if (leftframeTimer >= 3){
				leftframeTimer = 0;	
				leftframeCount++;

				if (leftframeCount >= 12){
					leftframeCount = 0;
				}


				left_player.rect.x = leftframeCount * left_player.rect.width;

			}

			left_player.position.x -= 200*dt;	

			if (left_player.position.x < 0){
				left_player.position.x = SCREEN_WIDTH;
			}

			player.position.x = left_player.position.x;

		}


		BeginDrawing();
		ClearBackground(RAYWHITE);

		for (int i=0; i < platform_store.size(); i++){
			DrawTexture(platform_store[i].image, platform_store[i].rect.x, platform_store[i].rect.y, WHITE);
		}

		if (player_state == RIGHT){
			DrawTextureRec(player_img, player.rect, player.position, WHITE);

		}

		else if (player_state == LEFT){
			DrawTextureRec(left_player_img, left_player.rect, left_player.position, WHITE);
		}



		EndDrawing();
	}

	CloseWindow();

	return 0;
}
