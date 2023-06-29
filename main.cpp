#include <iostream>
#include "kernel.cuh"
#include "SFML/Graphics.hpp"
#include "Game.h"
#include "Simulation.h"

#include "GalaxyRenderer.h"

int main() {
	Game game(500, 500);
	Simulation simulation(&game, 10000);
	GalaxyRenderer galaxyRenderer(&game, &simulation);

	while (game.open()) {
		game.eventHandler();
		simulation.simulate();
		galaxyRenderer.render();
		galaxyRenderer.draw();
	}

	return 0;
}