#pragma once
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "Vec3f.h"
#include "Particle.cuh"

// simulation
void initializeDeviceGravitySimulation(Particle* device_particles, Particle* cpu_particles, int num_particles);
void deviceGravitySimulation(Particle* device_particles, int num_particles);

// render
void deviceRenderer(int* device_pixel_particle_counts, unsigned char* device_image_pixels, int num_pixels);

// malloc
Particle* allocateDeviceParticles(int num_particles);
int* allocateDeviceParticlePositions(int num_particles);
int* allocateDevicePixelParticleCounts(int num_pixels);
unsigned char* allocateDeviceImagePixels(int num_pixels);

// free
void freeDeviceParticles(Particle* device_particles);
void freeDeviceParticlePositions(int* device_particle_positions);
void freeDevicePixelParticleCounts(int* device_pixel_particle_counts);
void freeDeviceImagePixels(unsigned char* device_image_pixels);