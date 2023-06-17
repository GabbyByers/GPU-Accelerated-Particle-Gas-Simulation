#pragma once

class Physics
{
public:
	Gas* gas = nullptr;
	Particle* device_particles = nullptr;

	Physics(Gas* gas)
	{
		this->gas = gas;
		device_particles = allocateDeviceMemory(gas->num_particles);
	}

	void simulate()
	{
		runDevice(gas->particles, device_particles, gas->num_particles);
	}
	
	~Physics()
	{
		freeDeviceMemory(device_particles);
	}
};