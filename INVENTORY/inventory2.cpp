# include <iostream>
# include <vector>

# include "raylib.h"

using namespace std;

# define print(x) cout << x << endl;

# define SCREEN_WIDTH 800
# define SCREEN_HEIGHT 600

struct INVENTORY {
	Rectangle rect;
	Vector2 position;
	Texture2D image;
	bool active;
};


int main(){
	// SETUP
	InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Inventory");

	// MATRIX FOR INVENTORY
	vector <Rectangle> main_inv = {};

	float y = 20;
	for (int i=0; i < 5; i++){
		float x = 390;

		for (int j=0; j < 5; j++){
			main_inv.push_back(Rectangle{x, y, 70.0f, 70.0f});
			x += 80;
		}

		y+= 80;
	}


	// GAME LOOP
	while(!WindowShouldClose()){
		BeginDrawing();
		ClearBackground(RAYWHITE);


		for (int i = 0; i < main_inv.size(); i++){
			DrawRectangle(main_inv[i].x, main_inv[i].y, main_inv[i].width, main_inv[i].height, GRAY);
		}

		EndDrawing();

	}

	CloseWindow();

	return 0;
}
