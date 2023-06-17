#pragma once
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include "Vec2f.cuh"
#include "Particle.cuh"

Particle* allocateDeviceMemory(int num_particles);
void runDevice(Particle* particles, Particle* device_particles, int num_particles);
void freeDeviceMemory(Particle* device_particles);