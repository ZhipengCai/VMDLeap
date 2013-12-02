#ifndef HAND_TRACKER_H
#define HAND_TRACKER_H

#include "HandVis.h"
#include "pthread.h"

#define POINT_RADIUS 0.06
#define LEAP_VERTICAL_OFFSET 250
#define LEAP_SCALE_FACTOR 0.005
#define HAND_FORCE_CONSTANT 0.05

typedef struct {
    bool initialized;
    int bone_count;
    float* bone_position; // {x1, y1, z1, x2, y2, z2}, ...
    HandVis* vis;
    // 通信関連
    pthread_t thread;
    pthread_mutex_t hand_mutex;
    int exit;
} HandTrackerState;

void calculateHandForce(float*, float, float*);
void normalizeHandForce(float*, int);

void initializeHandTracker();
HandTrackerState* getHandTrackerState();

#endif
