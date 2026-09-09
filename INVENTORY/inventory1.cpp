# include <iostream>
# include <vector>

# include "raylib.h"

using namespace std;

# define print(x) cout << x << endl;

# define SCREEN_WIDTH 500
# define SCREEN_HEIGHT 300


struct Inventory {
	Texture2D image;
	Rectangle rect;
	Vector2 position;
	bool active;	
};

int main(){
	// SETUP
	InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Inventory"); // screen

	Inventory inventory;
	inventory.image = LoadTexture("assets/dead/Icon1.png");

	inventory.position.y = 250.0f;
	inventory.position.x = 20.0f;

	inventory.rect={0, 0, 32.0f, 32.0f},
	inventory.active=0;

	vector <Inventory> inventory_store = {};

	Inventory collect;
	collect.image = LoadTexture("assets/dead/Icon1.png");
	collect.rect = {0, 0, 32.0, 32.0};
	collect.active = 1;


	// ITEMS TO COLLECT
	Inventory collect1 = {collect.image, collect.rect, Vector2{10, 10}, collect.active};
	Inventory collect2 = {collect.image, collect.rect, Vector2{100, 100}, collect.active};
	Inventory collect3 = {collect.image, collect.rect, Vector2{363, 159}, collect.active};

	Inventory collect4 = {collect.image, collect.rect, Vector2{246, 90}, collect.active};
	Inventory collect5 = {collect.image, collect.rect, Vector2{400, 170}, collect.active};


	vector <Inventory> collection = {collect1, collect2, collect3, collect4, collect5}; // vector for store collections


	for (int i=0; i < 5; i++){
			inventory_store.push_back(inventory);

			inventory.position.x += 105;
	}


	// GAME LOOP
	while(!WindowShouldClose()){
		for (int i=0; i < collection.size(); i++){
			Rectangle collisionRect = {
				collection[i].position.x,
				collection[i].position.y,
				collection[i].rect.width,
				collection[i].rect.height
			};	

			if (CheckCollisionPointRec(GetMousePosition(), collisionRect) && IsMouseButtonPressed(0) && collection[i].active == 1){
					for (int j = 0; j < inventory_store.size(); j++){

						if (inventory_store[j].active == 0) {
							inventory_store[j].active = 1;
							collection[i].active = 0;
							collection.erase(collection.begin() + i); // Remove the element at index i
							// i--; // compensate for the shifted elements
							break;
						}
					}
			}

		}

		BeginDrawing();
		ClearBackground(RAYWHITE);

		// ITEMS TO COLLECT
		// DrawTextureRec(inventory.image, inventory.rect, Vector2{10, 10}, WHITE);
		// DrawTextureRec(inventory.image, inventory.rect, Vector2{100, 100}, WHITE);
		// DrawTextureRec(inventory.image, inventory.rect, Vector2{363, 159}, WHITE);

		for (int i=0; i < collection.size(); i++){
			DrawTextureRec(collection[i].image, collection[i].rect, collection[i].position, WHITE);
		}


		// INVENTORY DISPLAY BOOL
		for (int i=0; i < inventory_store.size(); i++){
			if (inventory_store[i].active == 0){
				DrawRectangle(int(inventory_store[i].position.x), int(inventory_store[i].position.y), int(inventory_store[i].rect.width), int(inventory_store[i].rect.height), GRAY);
			}

			else {
				DrawTextureRec(inventory_store[i].image, inventory_store[i].rect, inventory_store[i].position, WHITE);
			}
		}

		EndDrawing();
	}

	return 0;
}
