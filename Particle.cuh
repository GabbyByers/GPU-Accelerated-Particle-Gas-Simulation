#pragma once

class Particle {
public:
	Vec3f pos;
	Vec3f vel;
	float mass;
	int screen_pos;

	__device__ void simulateGravity(const Particle& part, float G) {
		Vec3f force = part.pos - pos;
		float dist = force.length();
		force.normalize();
		force *= G * mass * part.mass;
		force /= dist * dist;
		vel += force;
	}
};