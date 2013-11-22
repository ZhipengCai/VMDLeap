#ifndef HAND_TRACKER_H
#define HAND_TRACKER_H

typedef struct {
    bool initialized;
    int bone_count;
    float* bone_position; // {x1, y1, z1, x2, y2, z2}, ...
} HandTrackerState;

void calculateaHandForce(float*, float*);
void initializeHandTracker();
HandTrackerState* getHandTrackerState();

#endif
