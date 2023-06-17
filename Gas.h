#pragma once

class Gas
{
public:
	Game* game = nullptr;
	Particle* particles = nullptr;
	int num_particles = 2000;

	Gas(Game* game)
	{
		this->game = game;
		particles = new Particle[num_particles];

		for (int i = 0; i < num_particles; i++)
		{
			Particle& particle = particles[i];
			particle.pos = -1.0f + (2.0f * (static_cast<float>(i + 1) / static_cast<float>(num_particles + 1)));
			particle.vel.x = 0.001f;
			particle.vel.y = -0.001f;
		}
	}

	~Gas()
	{
		delete[] particles;
	}
};