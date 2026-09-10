# include <iostream>
# include <vector>

# include "raylib.h"

using namespace std;

# define print(x) cout << x << endl;

# define SCREEN_WIDTH 800
# define SCREEN_HEIGHT 600

struct ITEMS {
	Rectangle rect;
	Rectangle surface;
	Vector2 surf_pos;
	Vector2 position;
	Texture2D image;
	bool active;
};

// Switch for inventory
enum SWITCH {
	ON,
	OFF
};

int main(){
	// SETUP
	InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Inventory");
	
	// ITEMS
	ITEMS item1;
	item1.image = LoadTexture("assets/dead/Icon1.png");
	item1.rect = {0, 0, 32, 32};
	item1.surface = {0, 0, 64, 64};
	item1.surf_pos = {20, 50};
	item1.position = {item1.surf_pos.x + (item1.surface.width  - item1.rect.width) / 2,
		item1.surf_pos.y + (item1.surface.height - item1.rect.height) / 2};




	// MATRIX FOR INVENTORY
	vector <Rectangle> main_inv = {};
	vector <Rectangle> second_inv = {};

	SWITCH inventory_switch = OFF;

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
	float x2 = 40;
	
	// float x2 = 390;
	for (int i=0; i < 9; i++){
		second_inv.push_back(Rectangle{x2, y2, 70.0f, 70.0f});
		x2 += 80;
	}

	// GAME LOOP
	while(!WindowShouldClose()){
		BeginDrawing();
		ClearBackground(RAYWHITE);


		// SWITCH STATEMENT
		if (IsKeyPressed(KEY_Q)){
			if (inventory_switch == OFF){
				inventory_switch = ON;
			}

			else if (inventory_switch == ON){
				inventory_switch = OFF;
			}
		}

		// DRAW INVENTORIES
		if (inventory_switch == ON){
			for (int i = 0; i < main_inv.size(); i++){
				DrawRectangle(main_inv[i].x, main_inv[i].y, main_inv[i].width, main_inv[i].height, GRAY);
			}

			// DRAW PLAYER HUB
			DrawRectangle(20, 20, 290, 390, Color{37, 37, 37, 255});
		}

		for (int i = 0; i < second_inv.size(); i++){
			DrawRectangle(second_inv[i].x, second_inv[i].y, second_inv[i].width, second_inv[i].height, GRAY);
		}

		DrawRectangle(item1.surf_pos.x, item1.surf_pos.y, 70, 70, GRAY);
		DrawTextureRec(item1.image, item1.rect, item1.position, WHITE);


		EndDrawing();
	}

	CloseWindow();

	return 0;
}
