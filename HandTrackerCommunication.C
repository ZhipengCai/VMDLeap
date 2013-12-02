#include "HandTrackerCommunication.h"
#include "HandTracker.h"

#include "pthread.h"
#include "osc/OscReceivedElements.h"
#include "osc/OscPacketListener.h"
#include "ip/UdpSocket.h"

// prototypes
void transformHandPositions(float*, int);

void HandPacketListener::ProcessMessage( const osc::ReceivedMessage& m,
        const IpEndpointName& remoteEndpoint ) {
    HandTrackerState* st_ht = getHandTrackerState();
    try {
        osc::ReceivedMessageArgumentStream args = m.ArgumentStream();
        int i, count;
        args >> count;
        float data[count*6];
        for (i=0; i<count*6; i++) {
            args >> data[i];
        }
//        msgInfo << "received hand: " << count << " points" << sendmsg;

        // 手の更新
        pthread_mutex_lock(&(st_ht->hand_mutex));

        // 視点依存の座標変換
        transformHandPositions(data, count);

        // データの更新
        st_ht->bone_count = count;
        for (i=0; i<count*6; i++) {
            st_ht->bone_position[i] = data[i];
        }

        pthread_mutex_unlock(&(st_ht->hand_mutex));
    } catch ( osc::Exception& e ) {
        msgInfo << "error while parsing message: "
            << m.AddressPattern() << ": " << e.what() << sendmsg;
    }
    // 終了チェック
    if (st_ht->exit) {
        pthread_exit(NULL);
    }
    return;
}
HandPacketListener listener;

static void *osc_thread(void *args) {
    UdpListeningReceiveSocket s(
        IpEndpointName( IpEndpointName::ANY_ADDRESS, OSC_PORT ),
        &listener );
    s.RunUntilSigInt();
    return NULL;
}

int initializeHandTrackerCommunication(HandTrackerState* st_ht) {
    if (pthread_create(&(st_ht->thread), NULL, osc_thread, NULL) != 0) {
        return 1;
    }
    pthread_mutex_init(&(st_ht->hand_mutex), NULL);

    return 0;
}

void transformHandPositions(float* positions, int count) {
    HandTrackerState* st_ht = getHandTrackerState();
    if (st_ht == NULL || st_ht->vis == NULL) return;
    Matrix4 M(st_ht->vis->rotm);

//    msgInfo << st_ht->vis->scale << sendmsg;

    for (int i=0; i<count; i++) {
        // y座標の補正。25cm上空を中心と考える
        positions[i*6+1] -= LEAP_VERTICAL_OFFSET;
        positions[i*6+4] -= LEAP_VERTICAL_OFFSET;

        // mm単位で来るので、だいたい1/25するとちょうど良い範囲におさまる
        for (int j=i*6; j<(i+1)*6; j++) {
            positions[j] *= LEAP_SCALE_FACTOR;
        }

        // 表示座標変換への対応
        for (int ind=i*6; ind<=i*6+3; ind+=3) {
            float newpos[3] = {0, 0, 0};
            for (int j=0; j<3; j++) {
                for (int k=0; k<3; k++) {
                    newpos[j] += M.mat[j*4+k] * positions[ind+k];
                }
//                newpos[j] = positions[ind+j];
                newpos[j] /= st_ht->vis->scale;
            }
            for (int j=0; j<3; j++) {
                newpos[j] -= st_ht->vis->centt[j];
                newpos[j] -= st_ht->vis->globt[j] / st_ht->vis->scale;
                positions[ind+j] = newpos[j];
            }
        }
    }
}
