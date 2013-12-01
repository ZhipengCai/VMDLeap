#include <stdlib.h>
#include <math.h>

#include "HandTracker.h"
#include "HandTrackerCommunication.h"
#include "Inform.h"

#include "pthread.h"
#include "osc/OscReceivedElements.h"
#include "osc/OscPacketListener.h"
#include "ip/UdpSocket.h"

#define MAX_BONE_COUNT 20

HandTrackerState *st_ht = NULL;

/*
 * 原子の位置を受け取って、働く外力のベクトルを返す
 */
void calculateHandForce(float *atompos, float *forcebuf) {
    for (int i=0; i<3; i++) {
        forcebuf[i] = 0.0f;
    }
}

void initializeHandTracker() {
    st_ht = (HandTrackerState*)malloc(sizeof(HandTrackerState));
    st_ht->bone_count = 0;
    st_ht->bone_position = (float*)malloc(sizeof(float)*MAX_BONE_COUNT*6);

    /* debug */
    st_ht->bone_count = 1;
    st_ht->bone_position[0] = 0;
    st_ht->bone_position[1] = 0;
    st_ht->bone_position[2] = 0;
    st_ht->bone_position[3] = 1.0f;
    st_ht->bone_position[4] = 1.0f;
    st_ht->bone_position[5] = 1.0f;

    initializeHandTrackerCommunication(st_ht);

    st_ht->initialized = true;

    msgInfo << "HandTracker is initialized!" << sendmsg;
}

HandTrackerState* getHandTrackerState() {
    return st_ht;
}

