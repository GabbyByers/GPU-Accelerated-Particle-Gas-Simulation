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

        vel *= 0.99f;
    }

    __host__ __device__ void repelReflectBox(const Vec2f& box_pos, Vec2f box_dim)
    {
        bool is_inside = ((box_pos.x < pos.x) && (pos.x < box_pos.x + box_dim.x)) && ((box_pos.y < pos.y) && (pos.y < box_pos.y + box_dim.y));
        if (is_inside)
        {
            float pierce[4] = { 0.0f, 0.0f, 0.0f, 0.0f }; // {top, bottom, right, left}
            pierce[0] = pos.y - box_pos.y;
            pierce[1] = box_pos.y + box_dim.y - pos.y;
            pierce[2] = box_pos.x + box_dim.x - pos.x;
            pierce[3] = pos.x - box_pos.x;

            int smallest_index = -1;
            float smallest_pierce = 100.0f;
            for (int i = 0; i < 4; i++)
            {
                if (pierce[i] < smallest_pierce)
                {
                    smallest_pierce - pierce[i];
                    smallest_index = i;
                }
            }

            if (smallest_index == 0) // top
            {
                pos.y -= smallest_pierce;
                vel.y *= -1;
            }

            if (smallest_index == 1) // bottom
            {
                pos.y += smallest_pierce;
                vel.y *= -1;
            }

            if (smallest_index == 2) // right
            {
                pos.x += smallest_pierce;
                vel.x *= -1;
            }

            if (smallest_index == 3) // left
            {
                pos.x -= smallest_pierce;
                vel.x *= -1;
            }
        }

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