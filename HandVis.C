#include "HandVis.h"
#include "HandTracker.h"

HandVis::HandVis(DrawMolecule *mr) 
: Displayable(mr) {
    needRegenerate = TRUE;

    getHandTrackerState()->vis = this;
}

void HandVis::create_cmdlist(void) {
    
}

void HandVis::prepare() {
    if (parent->needUpdate()) {
        needRegenerate = TRUE;
    }
    create_cmdlist();
}

void HandVis::do_color_changed(int clr) {
}
