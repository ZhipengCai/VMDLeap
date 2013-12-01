#include "HandTrackerCommunication.h"
#include "HandTracker.h"

#include "pthread.h"
#include "osc/OscReceivedElements.h"
#include "osc/OscPacketListener.h"
#include "ip/UdpSocket.h"

void HandPacketListener::ProcessMessage( const osc::ReceivedMessage& m,
        const IpEndpointName& remoteEndpoint ) {
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

