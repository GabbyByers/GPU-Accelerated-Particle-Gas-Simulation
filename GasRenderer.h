#pragma once

class GasRenderer
{
public:
	Game* game = nullptr;
	Gas* gas = nullptr;
	sf::Vertex* vertices = nullptr;

	GasRenderer(Gas* gas)
	{
		game = gas->game;
		this->gas = gas;
		vertices = new sf::Vertex[gas->num_particles];
		for (unsigned int i = 0; i < gas->num_particles; i++)
		{
			sf::Vertex vertex(sf::Vector2f(0.0f, 0.0f), sf::Color::White);
			vertices[i] = vertex;
		}
	}

	~GasRenderer()
	{
		delete[] vertices;
	}

	Vec2f screen_position(Vec2f pos)
	{
		float x = static_cast<float>((game->width - 1) * 0.5f) * (pos.x + 1.0f);
		float y = static_cast<float>((game->width - 1) * 0.5f)* (pos.y + 1.0f) + 1.0f;
		return Vec2f(x, y);
	}

	void render()
	{
		for (unsigned int i = 0; i < gas->num_particles; i++)
		{
			sf::Vertex& vertex = vertices[i];
			Particle& particle = gas->particles[i];

			Vec2f screen_pos = screen_position(particle.pos);
			vertex.position.x = screen_pos.x;
			vertex.position.y = screen_pos.y;
		}

		game->window->clear(sf::Color::Black);
		game->window->draw(vertices, gas->num_particles, sf::Points);
		game->window->display();
	}
};