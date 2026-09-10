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
	bool surf_active;
};

// Switch for inventory
enum SWITCH {
	ON,
	OFF
};

// FUNCTION FOR DEFINING ITEMS
void draw_item(ITEMS &item, const char *image_file, float x, float y){
	item.image = LoadTexture(image_file);
	item.rect = {0, 0, 32, 32};
	item.surface = {0, 0, 64, 64};
	item.surf_pos = {x, y};
	item.position = {item.surf_pos.x + (item.surface.width  - item.rect.width) / 2,
		item.surf_pos.y + (item.surface.height - item.rect.height) / 2};
};

int main(){
	// SETUP
	InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Inventory");
	
	// ITEMS
	ITEMS item1;
	ITEMS item2;
	ITEMS item3;
	
	ITEMS monster1;
	ITEMS monster2;
	ITEMS monster3;
	ITEMS monster4;
	ITEMS monster5;

	draw_item(item1,"assets/dead/Icon1.png", 20, 50);
	draw_item(item2,"assets/dead/Icon28.png", 100, 232);
	draw_item(item3,"assets/dead/Icon41.png", 75, 90);


	draw_item(monster1,"assets/low_monsters/Icon5.png", 420, 312);
	draw_item(monster2,"assets/low_monsters/Icon13.png", 333, 33);
	draw_item(monster3,"assets/low_monsters/Icon47.png", 700, 78);
	draw_item(monster4,"assets/low_monsters/Icon4.png", 700, 200);
	draw_item(monster5,"assets/low_monsters/Icon19.png", 643, 289);


	/*ITEMS item1;
	item1.image = LoadTexture("assets/dead/Icon1.png");
	item1.rect = {0, 0, 32, 32};
	item1.surface = {0, 0, 64, 64};
	item1.surf_pos = {20, 50};
	item1.position = {item1.surf_pos.x + (item1.surface.width  - item1.rect.width) / 2,
		item1.surf_pos.y + (item1.surface.height - item1.rect.height) / 2};


	ITEMS item2;
	item2.image = LoadTexture("assets/dead/Icon12.png");
	item2.rect = {0, 0, 32, 32};
	item2.surface = {0, 0, 64, 64};
	item2.surf_pos = {200, 168};
	item2.position = {item2.surf_pos.x + (item2.surface.width  - item2.rect.width) / 2,
		item2.surf_pos.y + (item2.surface.height - item2.rect.height) / 2};



	ITEMS item3;
	item3.image = LoadTexture("assets/dead/Icon41.png");
	item3.rect = {0, 0, 32, 32};
	item3.surface = {0, 0, 64, 64};
	item3.surf_pos = {175, 128};
	item3.position = {item3.surf_pos.x + (item3.surface.width  - item3.rect.width) / 2,
		item3.surf_pos.y + (item3.surface.height - item3.rect.height) / 2};*/
	


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
		// SWITCH STATEMENT
		if (IsKeyPressed(KEY_Q)){
			if (inventory_switch == OFF){
				inventory_switch = ON;
			}

			else if (inventory_switch == ON){
				inventory_switch = OFF;
			}
		}


		// DRAW
		BeginDrawing();
		ClearBackground(RAYWHITE);

		DrawTextureRec(item1.image, item1.rect, item1.position, WHITE);
		DrawTextureRec(item2.image, item2.rect, item2.position, WHITE);
		DrawTextureRec(item3.image, item3.rect, item3.position, WHITE);

		DrawTextureRec(monster1.image, monster1.rect, monster1.position, WHITE);
		DrawTextureRec(monster2.image, monster2.rect, monster2.position, WHITE);
		DrawTextureRec(monster3.image, monster3.rect, monster3.position, WHITE);
		DrawTextureRec(monster4.image, monster4.rect, monster4.position, WHITE);
		DrawTextureRec(monster5.image, monster5.rect, monster5.position, WHITE);


		// DRAW INVENTORIES
		if (inventory_switch == ON){
			// DRAW INVENTORY SURFACE
			DrawRectangle(0, 0, SCREEN_WIDTH, 430, PURPLE);


			for (int i = 0; i < main_inv.size(); i++){
				DrawRectangle(main_inv[i].x, main_inv[i].y, main_inv[i].width, main_inv[i].height, GRAY);
			}

			// DRAW PLAYER HUB
			DrawRectangle(20, 20, 290, 390, Color{37, 37, 37, 255});
		}

		for (int i = 0; i < second_inv.size(); i++){
			DrawRectangle(second_inv[i].x, second_inv[i].y, second_inv[i].width, second_inv[i].height, GRAY);
		}


		EndDrawing();
	}

	CloseWindow();

	return 0;
}
