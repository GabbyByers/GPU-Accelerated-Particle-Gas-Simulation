#pragma once
#include <math.h>

class Vec2f
{
public:
	float x, y;

	__host__ __device__ Vec2f()
	{
		x = 0.0f;
		y = 0.0f;
	}

	__host__ __device__ Vec2f(float x, float y)
	{
		this->x = x;
		this->y = y;
	}

	__host__ __device__ void normalize()
	{
		float len = sqrt(x * x + y * y);
		if (len == 0.0f)
			return;

		x /= len;
		y /= len;
	}

	__host__ __device__ float dist(const Vec2f& other)
	{
		float dx = x - other.x;
		float dy = y - other.y;
		return sqrt(dx * dx + dy * dy);
	}

	__host__ __device__ void operator += (const Vec2f& other)
	{
		x += other.x;
		y += other.y;
	}

	__host__ __device__ const Vec2f operator - (const Vec2f& other)
	{
		Vec2f result;
		result.x = x - other.x;
		result.y = y - other.y;
		return result;
	}

	__host__ __device__ void operator = (const float& value)
	{
		x = value;
		y = value;
	}

	__host__ __device__ void operator *= (const float& value)
	{
		x *= value;
		y *= value;
	}
};