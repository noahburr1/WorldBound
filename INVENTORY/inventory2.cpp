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

	vector <Rectangle> second_inv = {};


	float y = 20;
	for (int i=0; i < 5; i++){
		float x = 390;

		for (int j=0; j < 5; j++){
			main_inv.push_back(Rectangle{x, y, 70.0f, 70.0f});
			x += 80;
		}

		y+= 80;
	}


	float y2 = 510;
	float x2 = 390;
	for (int i=0; i < 5; i++){
		second_inv.push_back(Rectangle{x2, y2, 70.0f, 70.0f});
		x2 += 80;
	}

	// GAME LOOP
	while(!WindowShouldClose()){
		BeginDrawing();
		ClearBackground(RAYWHITE);


		// DRAW INVENTORIES
		for (int i = 0; i < main_inv.size(); i++){
			DrawRectangle(main_inv[i].x, main_inv[i].y, main_inv[i].width, main_inv[i].height, GRAY);
		}

		for (int i = 0; i < second_inv.size(); i++){
			DrawRectangle(second_inv[i].x, second_inv[i].y, second_inv[i].width, second_inv[i].height, GRAY);

			print(second_inv[i].x)
		}

		EndDrawing();

	}

	CloseWindow();

	return 0;
}
