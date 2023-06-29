#pragma once

class GalaxyRenderer {
public:
	Game* game = nullptr;
	Simulation* simulation = nullptr;

	sf::Image image;
	sf::Texture texture;
	sf::Vertex* quad = nullptr;

	GalaxyRenderer(Game* game, Simulation* simulation) {
		this->game = game;
		this->simulation = simulation;
		int w = game->width;
		int h = game->height;
		quad = new sf::Vertex[4]{
			sf::Vertex(sf::Vertex(sf::Vector2f(0, 0), sf::Vector2f(0, 0))),
			sf::Vertex(sf::Vertex(sf::Vector2f(w, 0), sf::Vector2f(w, 0))),
			sf::Vertex(sf::Vertex(sf::Vector2f(w, h), sf::Vector2f(w, h))),
			sf::Vertex(sf::Vertex(sf::Vector2f(0, h), sf::Vector2f(0, h)))
		};
		image.create(w, h, sf::Color(50, 0, 0, 255));
	}

	~GalaxyRenderer() {
		delete[] quad;
	}

	void render() {

	}

	void draw() {
		texture.loadFromImage(image);
		game->window->clear(sf::Color(0, 0, 0));
		game->window->draw(quad, 4, sf::Quads, &texture);
		game->window->display();
	}
};