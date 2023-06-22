#pragma once

class Particle
{
public:
	Vec2f pos;
	Vec2f vel;
    Vec2f acc;

    float range = 0.05f;
    float magnitude = 0.0001f;

    __device__ Particle() {}


    __device__ void repelBox(const Vec2f& box_pos, const Vec2f& box_dim)
    {
        float x0 = box_pos.x - range;
        float x1 = box_pos.x;
        float x2 = box_pos.x + box_dim.x;
        float x3 = box_pos.x + box_dim.x + range;

        float y0 = box_pos.y - range;
        float y1 = box_pos.y;
        float y2 = box_pos.y + box_dim.y;
        float y3 = box_pos.y + box_dim.y + range;

        bool isInsideLargeBound = ((x0 <= pos.x) && (pos.x < x3)) && ((y0 <= pos.y) && (pos.y < y3));
        bool isInsideSmallBound = ((x1 <= pos.x) && (pos.x < x2)) && ((y1 <= pos.y) && (pos.y < y2));

        if (!isInsideLargeBound)
        {
            return;
        }
        
        if (isInsideSmallBound)
        {
            vel *= 1.01;
        }

        float magnitude_modifer = 5.0f;

        if (((x0 <= pos.x) && (pos.x < x1)) && ((y0 <= pos.y) && (pos.y < y1))) // 1
            repelOther(Vec2f(x1, y1), magnitude_modifer);

        if (((x1 <= pos.x) && (pos.x < x2)) && ((y0 <= pos.y) && (pos.y < y1))) // 2
            repelOther(Vec2f(pos.x, y1), magnitude_modifer);

        if (((x2 <= pos.x) && (pos.x < x3)) && ((y0 <= pos.y) && (pos.y < y1))) // 3
            repelOther(Vec2f(y2, x1), magnitude_modifer);

        if (((x2 <= pos.x) && (pos.x < x3)) && ((y1 <= pos.y) && (pos.y < y2))) // 4
            repelOther(Vec2f(x2, pos.y), magnitude_modifer);

        if (((x2 <= pos.x) && (pos.x < x3)) && ((y2 <= pos.y) && (pos.y < y3))) // 5
            repelOther(Vec2f(x2, y2), magnitude_modifer);

        if (((x1 <= pos.x) && (pos.x < x2)) && ((y2 <= pos.y) && (pos.y < y3))) // 6
            repelOther(Vec2f(pos.x, y2), magnitude_modifer);

        if (((x0 <= pos.x) && (pos.x < x1)) && ((y2 <= pos.y) && (pos.y < y3))) // 7
            repelOther(Vec2f(x1, y2), magnitude_modifer);

        if (((x0 <= pos.x) && (pos.x < x1)) && ((y1 <= pos.y) && (pos.y < y2))) // 8
            repelOther(Vec2f(x1, pos.y), magnitude_modifer);

        return;
    }

    __device__ void repelOther(const Vec2f& other_pos, float magnitide_modifier)
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
        force *= magnitude * compression * magnitide_modifier;
        acc += force;

        //float dist = pos.dist(other_pos);
        //if (dist == 0.0f)
        //    return;
        //Vec2f force = pos - other_pos;
        //force.normalize();
        //force *= (1.0f / (1000000.0f * dist)) * magnitide_modifier;
        //acc += force;
    }
    
    __device__ void repelEdgeScreen()
    {
        float margin = 0.0001f;
        repelBox(Vec2f(-1.0f, -2.0f - margin), Vec2f(2.0f, 1.0f));
        repelBox(Vec2f(1.0f + margin, -1.0f), Vec2f(1.0f, 2.0f));
        repelBox(Vec2f(-1.0f, 1.0f + margin), Vec2f(2.0f, 1.0f));
        repelBox(Vec2f(-2.0f - margin, -1.0f), Vec2f(1.0f, 2.0f));
    }

    __device__ void reflectEdgeScreen()
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
    
    __device__ void eulerIntegration()
    {
        vel += acc;
        pos += vel;
        acc = 0.0f;

        vel *= 0.99f;
    }
};