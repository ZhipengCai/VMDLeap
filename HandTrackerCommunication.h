#ifndef HAND_TRACKER_COMMUNICATION_H
#define HAND_TRACKER_COMMUNICATION_H

#include "HandTracker.h"

#include "osc/OscReceivedElements.h"
#include "osc/OscPacketListener.h"
#include "ip/UdpSocket.h"

#define OSC_PORT 7000

class HandPacketListener : public osc::OscPacketListener {
protected:
    virtual void ProcessMessage( const osc::ReceivedMessage& m,
            const IpEndpointName& remoteEndpoint );
};

int initializeHandTrackerCommunication(HandTrackerState*);

#endif
