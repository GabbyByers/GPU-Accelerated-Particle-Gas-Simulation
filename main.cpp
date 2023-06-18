#include "kernel.cuh"
#include <iostream>

#include "SFML/Graphics.hpp"
#include "Game.h"
#include "Gas.h"
#include "Physics.h"
#include "GasRenderer.h"

struct Circle
{
	Vec2f pos;
	float radius;
};

struct Box
{
	Vec2f pos;
	Vec2f dim;
};

int main()
{
	Game game(950);
	Gas gas(&game);
	GasRenderer gasRenderer(&gas);
	Physics physics(&gas);

	while (game.open())
	{
		game.eventHandler();
		physics.simulate();
		gasRenderer.render();
	}

	return 0;
}