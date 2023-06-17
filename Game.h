#pragma once

class Game
{
public:
	sf::RenderWindow* window = nullptr;
	sf::Event* event = nullptr;
	int width = 0;

	Game(int width)
	{
		this->width = width;
		window = new sf::RenderWindow(sf::VideoMode(width, width), "Cuda Sandbox One", sf::Style::Close);
		event = new sf::Event();
	}

	~Game()
	{
		delete window;
		delete event;
	}
};