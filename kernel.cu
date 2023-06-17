#include "kernel.cuh"

__global__ void kernel(Particle* device_particles, int num_particles)
{
    unsigned int index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index >= num_particles)
        return;

    Particle& particle = device_particles[index];

    for (int i = 0; i < num_particles; i++)
    {
        if (i == index)
            continue;

        Particle& other = device_particles[i];
        particle.repelOther(other.pos);
    }
    particle.eulerIntegration();
    particle.reflectEdgeScreen();
}

Particle* allocateDeviceMemory(int num_particles)
{
    cudaSetDevice(0);
    Particle* device_particles = nullptr;
    cudaMalloc((void**)&device_particles, num_particles * sizeof(Particle));
    return device_particles;
}

void runDevice(Particle* particles, Particle* device_particles, int num_particles)
{
    cudaMemcpy(device_particles, particles, num_particles * sizeof(Particle), cudaMemcpyHostToDevice);

    unsigned int NUM_THREADS = 1024;
    unsigned int NUM_BLOCKS = (num_particles + NUM_THREADS - 1) / NUM_THREADS;
    kernel <<<NUM_BLOCKS, NUM_THREADS>>> (device_particles, num_particles);
    
    cudaDeviceSynchronize();
    cudaMemcpy(particles, device_particles, num_particles * sizeof(Particle), cudaMemcpyDeviceToHost);
}

void freeDeviceMemory(Particle* device_particles)
{
    cudaFree(device_particles);
}