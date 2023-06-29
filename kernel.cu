#include "kernel.cuh"

// simulate
__global__ void simulationKernel(Particle* device_particles, int num_particles) {
    unsigned int index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index >= num_particles)
        return;

    Particle& particle = device_particles[index];
    for (int i = 0; i < num_particles; i++) {
        if (i == index)
            continue;
        Particle& other = device_particles[i];
        particle.simulateGravity(other, 1.0f);
    }
}

void initializeDeviceGravitySimulation(Particle* device_particles, Particle* cpu_particles, int num_particles) {
    cudaMemcpy(device_particles, cpu_particles, num_particles * sizeof(Particle), cudaMemcpyHostToDevice);
}

void deviceGravitySimulation(Particle* device_particles, int num_particles) {
    int NUM_THREADS = 512;
    int NUM_BLOCKS = (num_particles + NUM_THREADS - 1) / NUM_THREADS; 
    simulationKernel <<<NUM_BLOCKS, NUM_THREADS>>> (device_particles, num_particles);
    cudaDeviceSynchronize();
}

// render
__global__ void renderKernel(int* device_pixel_particle_counts, unsigned char* device_image_pixels, int num_pixels) {
    unsigned int index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index >= num_pixels)
        return;

    // determine pixel color
}

void deviceRenderer(int* device_pixel_particle_counts, unsigned char* device_image_pixels, int num_pixels) {
    int NUM_THREADS = 512;
    int NUM_BLOCKS = (num_pixels + NUM_THREADS - 1) / NUM_THREADS;
    renderKernel <<<NUM_BLOCKS, NUM_THREADS>>> (device_pixel_particle_counts, device_image_pixels, num_pixels);
    cudaDeviceSynchronize();
}

// malloc
Particle* allocateDeviceParticles(int num_particles) {
    Particle* device_particles = nullptr;
    cudaMalloc((void**)&device_particles, num_particles * sizeof(Particle));
    return device_particles;
}

int* allocateDeviceParticlePositions(int num_particles) {
    int* device_particle_positions = nullptr;
    cudaMalloc((void**)&device_particle_positions, num_particles * sizeof(int));
    return device_particle_positions;
}

int* allocateDevicePixelParticleCounts(int num_pixels) {
    int* device_pixel_particle_counts = nullptr;
    cudaMalloc((void**)&device_pixel_particle_counts, num_pixels * sizeof(int));
    return device_pixel_particle_counts;
}

unsigned char* allocateDeviceImagePixels(int num_pixels) {
    unsigned char* device_image_pixels = nullptr;
    cudaMalloc((void**)&device_image_pixels, num_pixels * 4);
    return device_image_pixels;
}

// free
void freeDeviceParticles(Particle* device_particles) {
    cudaFree(device_particles);
}

void freeDeviceParticlePositions(int* device_particle_positions) {
    cudaFree(device_particle_positions);
}

void freeDevicePixelParticleCounts(int* device_pixel_particle_counts) {
    cudaFree(device_pixel_particle_counts);
}

void freeDeviceImagePixels(unsigned char* device_image_pixels) {
    cudaFree(device_image_pixels);
}