#pragma once
#include "math.h"

class Vec3f {
public:
    float x, y, z;

    __device__ Vec3f() {
        x = 0.0f;
        y = 0.0f;
        z = 0.0f;
    }

    __device__ Vec3f(float x, float y, float z) {
        this->x = x;
        this->y = y;
        this->z = z;
    }

    __device__ Vec3f(const Vec3f& vec3f) {
        x = vec3f.x;
        y = vec3f.y;
        z = vec3f.z;
    }

    __device__ float length() {
        return sqrt((x * x) + (y * y) + (z * z));
    }

    __device__ void normalize() {
        float len = length();
        x /= len;
        y /= len;
        z /= len;
    }

    __device__ Vec3f operator + (const float val) const {
        return Vec3f(x + val, y + val, z + val);
    }

    __device__ Vec3f operator - (const float val) const {
        return Vec3f(x - val, y - val, z - val);
    }

    __device__ Vec3f operator * (const float val) const {
        return Vec3f(x * val, y * val, z * val);
    }

    __device__ Vec3f operator / (const float val) const {
        return Vec3f(x / val, y / val, z / val);
    }

    __device__ Vec3f operator + (const Vec3f& vec3f) const {
        return Vec3f(x + vec3f.x, y + vec3f.y, z + vec3f.z);
    }

    __device__ Vec3f operator - (const Vec3f& vec3f) const {
        return Vec3f(x - vec3f.x, y - vec3f.y, z - vec3f.z);
    }

    __device__ void operator += (const float val) {
        x += val;
        y += val;
        z += val;
    }

    __device__ void operator -= (const float val) {
        x -= val;
        y -= val;
        z -= val;
    }

    __device__ void operator *= (const float val) {
        x *= val;
        y *= val;
        z *= val;
    }

    __device__ void operator /= (const float val) {
        x /= val;
        y /= val;
        z /= val;
    }

    __device__ void operator = (const Vec3f& vec3f) {
        x = vec3f.x;
        y = vec3f.y;
        z = vec3f.z;
    }

    __device__ void operator += (const Vec3f vec3f) {
        x += vec3f.x;
        y += vec3f.y;
        z += vec3f.z;
    }

    __device__ void operator -= (const Vec3f vec3f) {
        x -= vec3f.x;
        y -= vec3f.y;
        z -= vec3f.z;
    }

    __device__ bool operator > (Vec3f vec3f) {
        float len1 = length();
        float len2 = vec3f.length();
        return len1 > len2;
    }

    __device__ bool operator < (Vec3f vec3f) {
        float len1 = length();
        float len2 = vec3f.length();
        return len1 < len2;
    }
};