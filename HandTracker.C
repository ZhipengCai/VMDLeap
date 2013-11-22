#include <stdlib.h>
#include <math.h>

#include "HandTracker.h"
#include "Inform.h"

#define MAX_BONE_COUNT 20

HandTrackerState *st_ht = NULL;

/*
 * 原子の位置を受け取って、働く外力のベクトルを返す
 */
void calculateHandForce(float *atompos, float *forcebuf) {
    for (int i=0; i<3; i++) {
        forcebuf[i] = 0.0f;
    }

    /* debug */
    forcebuf[0] = 1.0f;
    forcebuf[1] = 1.0f;
    forcebuf[2] = 1.0f;
}

void initializeHandTracker() {
    st_ht = (HandTrackerState*)malloc(sizeof(HandTrackerState));
    st_ht->bone_count = 0;
    st_ht->bone_position = (float*)malloc(sizeof(float)*MAX_BONE_COUNT*6);

    st_ht->initialized = true;
}

HandTrackerState* getHandTrackerState() {
    return st_ht;
}
