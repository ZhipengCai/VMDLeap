#ifndef HANDVIS_H
#define HANDVIS_H

#include "DrawMolecule.h"
#include "Displayable.h"
class DisplayDevice;

class HandVis : public Displayable {
private:
    DisplayDevice *disp;
    int colorCat;
    int usecolor;
    void create_cmdlist(void);
    int needRegenerate;

public:
    HandVis(DrawMolecule*);
    virtual void prepare();

protected:
    virtual void do_color_changed(int);

};

#endif
