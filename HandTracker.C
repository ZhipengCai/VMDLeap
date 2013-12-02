#include <stdlib.h>
#include <math.h>

#include "HandTracker.h"
#include "HandTrackerCommunication.h"
#include "Inform.h"

#include "pthread.h"
#include "osc/OscReceivedElements.h"
#include "osc/OscPacketListener.h"
#include "ip/UdpSocket.h"

#define dist(x,y) (sqrt(((x)[0]-(y)[0])*((x)[0]-(y)[0])+((x)[1]-(y)[1])*((x)[1]-(y)[1])+((x)[2]-(y)[2])*((x)[2]-(y)[2])))

#define MAX_BONE_COUNT 20

HandTrackerState *st_ht = NULL;

/*
 * ハンドトラッカーの初期化
 */
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

    st_ht->vis = NULL;
    st_ht->exit = 0;
    st_ht->initialized = true;

    msgInfo << "HandTracker is initialized!" << sendmsg;
}

HandTrackerState* getHandTrackerState() {
    return st_ht;
}

/*
 * 原子の位置を受け取り、働く外力のベクトルを返す
 */
void calculateHandForce(float *atompos, float vdwrad, float *forcebuf) {
    float actual_radius = POINT_RADIUS / st_ht->vis->scale;

    for (int i=0; i<3; i++) {
        forcebuf[i] = 0;
    }

    // 各指との間で力を計算して平均をとる
    int force_count = 0;
    pthread_mutex_lock(&(st_ht->hand_mutex));
    for (int i=0; i<st_ht->bone_count; i++) {
        float *pos1 = st_ht->bone_position + 6*i;
        float *pos2 = st_ht->bone_position + 6*i + 3;
        float v[3];
        for (int j=0; j<3; j++) v[j] = pos2[j] - pos1[j];

        float t = (v[0]*(atompos[0]-pos1[0]) + v[1]*(atompos[1]-pos1[1]) + v[2]*(atompos[2]-pos1[2])) / (v[0]*v[0] + v[1]*v[1] + v[2]*v[2]);
        float h[3];
        for (int j=0; j<3; j++) h[j] = pos1[j] + t*v[j];

        float l = 0; // ボーンと原子の距離
        float dir[3] = {0, 0, 0}; // ボーンから原子方向のベクトル
        if (0 <= t && t<=1) {
            l = dist(h, atompos);
            for (int j=0; j<3; j++) dir[j] = (atompos[j] - h[j]) / l;
        } else if (t < 0) {
            l = dist(pos1, atompos);
            for (int j=0; j<3; j++) dir[j] = (atompos[j] - pos1[j]) / l;
        } else {
            l = dist(pos2, atompos);
            for (int j=0; j<3; j++) dir[j] = (atompos[j] - pos2[j]) / l;
        }

        // 力の計算
        if (l < actual_radius + vdwrad) {
            if (t < 0 || 1 < t) {
                msgInfo << "tip" << sendmsg;
            } else {
                msgInfo << "side" << sendmsg;
            }
            for (int j=0; j<3; j++) {
                float f = dir[j]/st_ht->vis->scale;
                float mag = l/pow(actual_radius+vdwrad, 2.0); // 距離の自乗に反比例して反発力をかける
                mag = fmin(mag, 10); // 最大倍率は10
                f /= (l/vdwrad); // 距離が近いほど力も強く働く
                f *= HAND_FORCE_CONSTANT;
                forcebuf[j] += f;
            }
            force_count++;
        }
    }
    if (force_count > 0) {
        for (int i=0; i<3; i++) forcebuf[i] /= force_count;
    }
    pthread_mutex_unlock(&(st_ht->hand_mutex));
}

void normalizeHandForce(float* forcebuf, int atoms) {
    pthread_mutex_lock(&(st_ht->hand_mutex));
    float average[3] = {0, 0, 0};
    for (int i=0; i<atoms; i++) {
        for (int j=0; j<3; j++) {
            average[j] += forcebuf[i*3+j] / atoms;
        }
    }
    for (int i=0; i<atoms; i++) {
        for (int j=0; j<3; j++) {
            forcebuf[i*3+j] -= average[j];
        }
    }
    pthread_mutex_unlock(&(st_ht->hand_mutex));
}
