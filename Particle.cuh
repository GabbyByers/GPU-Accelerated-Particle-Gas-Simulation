#pragma once

class Particle
{
public:
	Vec2f pos;
	Vec2f vel;
    Vec2f acc;

    float range = 0.1f;
    float magnitude = 0.0005f;

    __host__ __device__ Particle() {}

    __host__ __device__ void eulerIntegration()
    {
        vel += acc;
        pos += vel;
        acc = 0.0f;

        vel *= 0.997f;
    }

    __host__ __device__ void repelOther(const Vec2f& other_pos)
    {
        float dist = pos.dist(other_pos);
        if (dist > range)
            return;
        if (dist == 0.0f)
            return;

        float pierce = range - dist;
        float compression = pierce / range;

        Vec2f force = pos - other_pos;
        force.normalize();
        force *= magnitude * compression;
        acc += force;
    }

    __host__ __device__ void reflectEdgeScreen() // soon to be legacy
	{
        if (pos.x > 1.0f) {
            pos.x = 1.0f;
            vel.x *= -1;
        }

        if (pos.y > 1.0f) {
            pos.y = 1.0f;
            vel.y *= -1;
        }

        if (pos.x < -1.0f) {
            pos.x = -1.0f;
            vel.x *= -1;
        }

        if (pos.y < -1.0f) {
            pos.y = -1.0f;
            vel.y *= -1;
        }
	}
};