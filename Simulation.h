#pragma once

class Simulation {
public:
	Game* game = nullptr;
	int num_particles;

	Particle* device_particles = nullptr;
	int* device_particle_positions = nullptr;
	int* host_particle_positions = nullptr;

	Simulation(Game* game, int num_particles) {
		this->game = game;
		this->num_particles = num_particles;

		allocateDeviceMemory();
		initializeGasParticles();
	}

	void allocateDeviceMemory() {
		device_particles = allocateDeviceParticles(num_particles);
		device_particle_positions = allocateDeviceParticlePositions(num_particles);
	}

	void initializeGasParticles() {
		Particle* cpu_particles = nullptr;
		cpu_particles = new Particle[num_particles];
		for (int i = 0; i < num_particles; i++) {
			float value = ((static_cast<float>(i) / static_cast<float>(num_particles)) * 2.0) - 1.0;
			Particle& particle = cpu_particles[i];
			particle.pos = Vec3f(value, value, value);
		}
		initializeDeviceGravitySimulation(device_particles, cpu_particles, num_particles);
		delete[] cpu_particles;
	}

	~Simulation() {
		freeDeviceParticles(device_particles);
		freeDeviceParticlePositions(device_particle_positions);
	}

	void simulate() {
		deviceGravitySimulation(device_particles, num_particles);
	}
};