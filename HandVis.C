#include "HandVis.h"
#include "HandTracker.h"

#include "DisplayDevice.h"
#include "Displayable.h"
#include "DispCmds.h"
#include "Scene.h"
#include "Inform.h"

HandVis::HandVis(DrawMolecule *mr) 
: Displayable(mr) {
    needRegenerate = TRUE;

    getHandTrackerState()->vis = this;
}

void HandVis::create_cmdlist(void) {
    int i, j;

    if (needRegenerate) {
        needRegenerate = FALSE;
        reset_disp_list();

        DispCmdColorIndex cmdColorIndex;
        DispCmdLine cmdLine;

        cmdColorIndex.putdata(MAPCOLOR(0), cmdList);

        // draw each bones
        HandTrackerState* st_ht = getHandTrackerState();
        if (st_ht != NULL && st_ht->initialized) {
            for (i=0; i<st_ht->bone_count; i++) {
                float pos1[3];
                float pos2[3];
                for (j=0; j<3; j++) {
                    pos1[j] = st_ht->bone_position[i*6+j];
                    pos2[j] = st_ht->bone_position[i*6+3+j];
                }

                cmdLine.putdata(pos1, pos2, cmdList);
                msgInfo << "show Bone" << sendmsg;
            }
        }
    }
}

void HandVis::prepare() {
    if (parent->needUpdate()) {
        needRegenerate = TRUE;
    }

    create_cmdlist();
}

void HandVis::do_color_changed(int clr) {
}

