# include <iostream>
# include <vector>

# include "raylib.h"

using namespace std;

# define print(x) cout << x << endl;

# define SCREEN_WIDTH 800
# define SCREEN_HEIGHT 600

int main(){
	// SETUP
	InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Inventory");

	// GAME LOOP
	while(!WindowShouldClose()){
		BeginDrawing();
		ClearBackground(RAYWHITE);

		EndDrawing();

	}

	CloseWindow();

	return 0;
}
