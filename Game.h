#pragma once

class Game {
public:
	sf::RenderWindow* window = nullptr;
	sf::Event* event = nullptr;
	int width, height;

	Game(int width, int height) {
		this->width = width;
		this->height = height;
		window = new sf::RenderWindow(sf::VideoMode(width, height), "CUDA Galaxy Simulation", sf::Style::Close);
		event = new sf::Event();
	}

	~Game() {
		delete window;
		delete event;
	}

	int numPixels() {
		return width * height;
	}

	bool open() {
		return window->isOpen();
	}

	void eventHandler() {
		while (window->pollEvent(*event)) {
			if (event->type == sf::Event::Closed)
				window->close();
		}
	}
};