#ifndef HANDVIS_H
#define HANDVIS_H

#include "DrawMolecule.h"
#include "Displayable.h"
#include "DisplayDevice.h"

#define HAND_SPHERERES 6
// シミュレーション上の指の太さに対しての表示倍率
#define HANDVIS_SCALE_FACTOR 1.0

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
