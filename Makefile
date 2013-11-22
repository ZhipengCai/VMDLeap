
# Makefile for vmd
# VMD for MACOSXX86_64, version 1.9.1 (November 15, 2013)

.SILENT:

CD          = cd
COPY        = cp
COPYDIR     = cp -r
MAKEDIR     = mkdir -p
MOVE        = mv -f
DELETE      = rm -f
DELETEDIR   = rm -rf
ECHO        = echo
TAR         = tar
COMPRESS    = compress
GNUCOMPRESS = /usr/local/bin/gzip
LATEX       = latex

# makefile configuration
VPATH                   = .:../MACOSXX86_64
SHELL                   = /bin/sh
.SUFFIXES: .C .c .cu ..c .i .o


# C++ source files
VMD_CCPP    =	FltkOpenGLDisplayDevice.C \
		OpenGLExtensions.C \
		OpenGLRenderer.C \
		OpenGLShader.C \
		OpenGLCache.C \
		OpenCLUtils.C \
		OpenCLOrbital.C \
		OpenCLVolCPotential.C \
		IMDMgr.C \
		IMDSim.C \
		IMDSimThread.C \
		CmdIMD.C \
		imd.C \
		Animation.C \
		ArtDisplayDevice.C \
		AtomColor.C \
		AtomParser.C \
		AtomLexer.C \
		AtomRep.C \
		AtomSel.C \
		Axes.C \
		BaseMolecule.C \
		Benchmark.C \
		BondSearch.C \
		CmdAnimate.C \
		CmdColor.C \
		CmdDisplay.C \
		CmdLabel.C \
		CmdMaterial.C \
		CmdMenu.C \
		CmdMol.C \
		CmdRender.C \
		CmdTrans.C \
		CommandQueue.C \
		CoorPluginData.C \
		CUDAAccel.C \
		DisplayDevice.C \
		Displayable.C \
		DisplayRocker.C \
		DispCmds.C \
		DrawMolecule.C \
		DrawMolItem.C \
		DrawMolItem2.C \
		DrawMolItemRibbons.C \
		DrawMolItemMSMS.C \
		DrawMolItemRings.C \
		DrawMolItemOrbital.C \
		DrawMolItemQuickSurf.C \
		DrawMolItemSurface.C \
		DrawMolItemVolume.C \
		DrawForce.C \
		DrawRingsUtils.C \
		FileRenderList.C \
		FileRenderer.C \
		FPS.C \
		GelatoDisplayDevice.C \
		GeometryAngle.C \
		GeometryAtom.C \
		GeometryBond.C \
		GeometryDihedral.C \
		GeometryList.C \
		GeometryMol.C \
		GeometrySpring.C \
		Hershey.C \
		Inform.C \
		ImageIO.C \
		Isosurface.C \
		JRegex.C \
		JString.C \
		macosxvmdstart.C \
		MaterialList.C \
		Matrix4.C \
		MayaDisplayDevice.C \
		Measure.C \
		MeasureCluster.C \
		MeasurePBC.C \
		MeasureRDF.C \
		MeasureSurface.C \
		MeasureSymmetry.C \
		MobileInterface.C \
		MobileButtons.C \
		MobileTracker.C \
		Molecule.C \
		MoleculeList.C \
		MoleculeGraphics.C \
		MolFilePlugin.C \
		Mouse.C \
		MSMSInterface.C \
		Orbital.C \
		OrbitalJIT.C \
		PeriodicTable.C \
		P_JoystickTool.C \
		P_TugTool.C \
		P_GrabTool.C \
		P_PrintTool.C \
		P_PinchTool.C \
		P_UIVR.C \
		P_Buttons.C \
		P_Tracker.C \
		P_Tool.C \
		P_CmdTool.C \
		P_SensorConfig.C \
		ParseTree.C \
		PickList.C \
		PickModeAddBond.C \
		PickModeCenter.C \
		PickModeForce.C \
		PickModeList.C \
		PickModeMolLabel.C \
		PickModeMove.C \
		PickModeUser.C \
		PlainTextInterp.C \
		PluginMgr.C \
		POV3DisplayDevice.C \
		PSDisplayDevice.C \
		QMData.C \
		QMTimestep.C \
		QuickSurf.C \
		RadianceDisplayDevice.C \
		RayShadeDisplayDevice.C \
		R3dDisplayDevice.C \
		RenderManDisplayDevice.C \
		Scene.C \
		SnapshotDisplayDevice.C \
		Spaceball.C \
		SpaceballButtons.C \
		SpaceballTracker.C \
		SpatialSearch.C \
		SpringTool.C \
		Stage.C \
		STLDisplayDevice.C \
		Stride.C \
		Surf.C \
		SymbolTable.C \
		TachyonDisplayDevice.C \
		Timestep.C \
		UIObject.C \
		UIText.C \
		VMDApp.C \
		VMDCollab.C \
		VMDDir.C \
		VMDDisplayList.C \
		VMDMenu.C \
		VMDQuat.C \
		VMDTitle.C \
		VMDThreads.C \
		VolCPotential.C \
		VolMapCreate.C \
		VolMapCreateILS.C \
		VolumetricData.C \
		VolumeTexture.C \
		VrmlDisplayDevice.C \
		Vrml2DisplayDevice.C \
		WavefrontDisplayDevice.C \
		WKFThreads.C \
		WKFUtils.C \
		utilities.C \
		vmd.C \
		vmdmain.C \
		X3DDisplayDevice.C \
		ColorInfo.C \
		TclCommands.C \
		TclMeasure.C \
		TclMolInfo.C \
		TclTextInterp.C \
		TclVec.C \
		TclGraphics.C \
		TclVolMap.C \
		cmd_animate.C \
		cmd_collab.C \
		cmd_color.C \
		cmd_display.C \
		cmd_imd.C \
		cmd_label.C \
		cmd_material.C \
		cmd_menu.C \
		cmd_mobile.C \
		cmd_mol.C \
		cmd_mouse.C \
		cmd_parallel.C \
		cmd_plugin.C \
		cmd_render.C \
		cmd_spaceball.C \
		cmd_tool.C \
		cmd_trans.C \
		cmd_user.C \
		cmd_util.C \
		cmd_vmdbench.C \
		tcl_commands.C \
		VMDTkMenu.C \
		ColorFltkMenu.C \
		DisplayFltkMenu.C \
		FileChooserFltkMenu.C \
		GraphicsFltkMenu.C \
		SelectionBuilder.C \
		GeometryFltkMenu.C \
		MaterialFltkMenu.C \
		MolBrowser.C \
		RenderFltkMenu.C \
		SaveTrajectoryFltkMenu.C \
		VMDFltkMenu.C \
		MainFltkMenu.C \
		ToolFltkMenu.C \
		frame_selector.C \
		HandTracker.C

# C source files
VMD_CC      = 	hash.c \
		inthash.c \
		intstack.c \
		msmpot.c \
		msmpot_compute.c \
		msmpot_cubic.c \
		msmpot_setup.c \
		vmdsock.c \
		vmddlopen.c \
		pcre.c \
		fitrms.c

# CUDA source files
VMD_CU      = 	

# Header files
VMD_H       = 	OpenGLDisplayDevice.h \
		OpenGLExtensions.h \
		OpenGLRenderer.h \
		OpenGLShader.h \
		OpenGLCache.h \
		OpenCLKernels.h \
		imd.h \
		IMDMgr.h \
		IMDSim.h \
		IMDSimThread.h \
		CmdIMD.h \
		Animation.h \
		ArtDisplayDevice.h \
		Atom.h \
		AtomColor.h \
		AtomParser.h \
		AtomRep.h \
		AtomSel.h \
		Axes.h \
		BaseMolecule.h \
		Benchmark.h \
		BondSearch.h \
		CmdAnimate.h \
		CmdColor.h \
		CmdDisplay.h \
		CmdLabel.h \
		CmdMaterial.h \
		CmdMenu.h \
		CmdMol.h \
		CmdRender.h \
		CmdTrans.h \
		Command.h \
		CommandQueue.h \
		CoorData.h \
		CUDAAccel.h \
		CoorPluginData.h \
		DepthSortObj.h \
		DispCmds.h \
		DisplayDevice.h \
		Displayable.h \
		DisplayRocker.h \
		DrawMolecule.h \
		DrawMolItem.h \
		DrawMolItemSolventPoints.data \
		DrawForce.h \
		GelatoDisplayDevice.h \
		FPS.h \
		FileRenderList.h \
		FileRenderer.h \
		Fragment.h \
		GeometryAngle.h \
		GeometryAtom.h \
		GeometryBond.h \
		GeometryDihedral.h \
		GeometryList.h \
		GeometryMol.h \
		GeometrySpring.h \
		Hershey.h \
		Inform.h \
		ImageIO.h \
		Isosurface.h \
		JRegex.h \
		JString.h \
		macosxvmdstart.h \
		MaterialList.h \
		Matrix4.h \
		MayaDisplayDevice.h \
		Measure.h \
		MeasureSymmetry.h \
		Molecule.h \
		MoleculeGraphics.h \
		MoleculeList.h \
		MolFilePlugin.h \
		Mouse.h \
		MSMSInterface.h \
		NameList.h \
		PeriodicTable.h \
		Orbital.h \
		P_JoystickTool.h \
		P_TugTool.h \
		P_PinchToo.h \
		P_GrabTool.h \
		P_PrintTool.h \
		P_Feedback.h \
		P_UIVR.h \
		P_Buttons.h \
		P_Tracker.h \
		P_CmdTool.h \
		P_SensorConfig.h \
		P_Tool.h \
		ParseTree.h \
		PickList.h \
		PickMode.h \
		PickModeAddBond.h \
		PickModeCenter.h \
		PickModeForce.h \
		PickModeList.h \
		PickModeMolLabel.h \
		PickModeMove.h \
		Pickable.h \
		PlainTextInterp.h \
		PluginMgr.h \
		PointerTool.h \
		POV3DisplayDevice.h \
		PSDisplayDevice.h \
		QMData.h \
		QMTimestep.h \
		RadianceDisplayDevice.h \
		RayShadeDisplayDevice.h \
		R3dDisplayDevice.h \
		ResizeArray.h \
		RenderManDisplayDevice.h \
		Residue.h \
		Scene.h \
		SnapshotDisplayDevice.h \
		SortableArray.h \
		Spaceball.h \
		SpaceballButtons.h \
		SpaceballTracker.h \
		SpatialSearch.h \
		SpringTool.h \
		Stack.h \
		Stage.h \
		STLDisplayDevice.h \
		Stride.h \
		Surf.h \
		SymbolTable.h \
		TachyonDisplayDevice.h \
		TextEvent.h \
		TextInterp.h \
		Timestep.h \
		UIObject.h \
		UIText.h \
		VMDApp.h \
		VMDDir.h \
		VMDDisplayList.h \
		VMDMenu.h \
		VMDQuat.h \
		VMDTitle.h \
		VMDThreads.h \
		VolCPotential.h \
		VolMapCreate.h \
		VolumetricData.h \
		VolumeTexture.h \
		VrmlDisplayDevice.h \
		Vrml2DisplayDevice.h \
		WavefrontDisplayDevice.h \
		X3DDisplayDevice.h \
		utilities.h \
		pcre.h \
		pcreinternal.h \
		pcretables.h \
		vmdsock.h \
		fitrms.h \
		TclCommands.h \
		TclTextInterp.h \
		tcl_commands.h \
		VMDTkMenu.h \
		plugin.h \
		molfile_plugin.h \
		libmolfile_plugin.h \
		ColorFltkMenu.h \
		DisplayFltkMenu.h \
		FileChooserFltkMenu.h \
		GeometryFltkMenu.h \
		GraphicsFltkMenu.h \
		GraphicsFltkReps.h \
		SelectionBuilder.h \
		MaterialFltkMenu.h \
		MolBrowser.h \
		RenderFltkMenu.h \
		SaveTrajectoryFltkMenu.h \
		VMDFltkMenu.h \
		MainFltkMenu.h \
		ToolFltkMenu.h \
		frame_selector.h

# yacc and lex files
VMD_YACC    = 	AtomParser.y

VMD_LEX     = 	AtomLexer.l

# Misc. data file
VMD_DATA    = 	.vmdsensors .vmdrc

VMD_EXTRA          = 	

VMD_OTHER_EXE      = 	../lib/stride/stride_MACOSXX86_64 ../lib/surf/surf_MACOSXX86_64 ../lib/tachyon/tachyon_MACOSXX86_64

VMD_OTHER_NAMES    = 	stride_MACOSXX86_64

VMD_MAIN_DIR_FILES = 	Announcement FEEDBACK LICENSE README configure

# Turn things into objects
VMD_OBJS    =   $(VMD_CCPP:.C=.o) $(VMD_CC:.c=.o) $(VMD_CU:.cu=.o)

INCDIRS     =  -I/usr/include/CL   -I../lib/tcl/include -I../lib/tk/lib_MACOSXX86_64/Tk.framework/Versions/8.5/Headers -I../plugins/include -I../plugins/MACOSXX86_64/molfile -I../lib/fltk/fltk-1.3.x -I. -I/opt/X11/include

LIBS        = -lfltk_gl -framework OpenGL -framework AGL -framework OpenCL  -lpthread -framework Tk -framework Tcl  -lmolfile_plugin -lfltk  -framework Cocoa  $(VMDEXTRALIBS)

LIBDIRS     =     -F../lib/tcl/lib_MACOSXX86_64 -F../lib/tk/lib_MACOSXX86_64 -Wl,-executable_path . -lmx  -L../plugins/MACOSXX86_64/molfile -L../lib/fltk/MACOSXX86_64 

DEFINES     = -DVMDOPENGL -DVMDFLTKOPENGL -DVMDOPENCL -DVMDIMD -DVMDTHREADS -DWKFTHREADS -DUSEPOSIXTHREADS -D_REENTRANT -DVMDQUICKSURF -DVMDWITHCARBS -DVMDPOLYHEDRA -DVMDSURF -DVMDMSMS -DVMDPBCSMOOTH -DVMDTCL -DVMDTK  -DVMDSTATICPLUGINS -DVMDGUI -DVMDFLTK 

# compiler and compiler directives 
CC          = cc
CFLAGS      = -m64 -fPIC -Os -ffast-math -DARCH_MACOSXX86_64 $(DEFINES) $(INCDIRS) 

CCPP	    = c++
CPPFLAGS    = -m64 -fPIC -Os -ffast-math  -DARCH_MACOSXX86_64 $(DEFINES) $(INCDIRS) 

NVCC        = /usr/local/encap/cuda-4.0/bin/nvcc
NVCCFLAGS   = --ptxas-options=-v -gencode arch=compute_10,code=sm_10 -gencode arch=compute_13,code=sm_13 -gencode arch=compute_20,code=sm_20 --ftz=true  -DARCH_MACOSXX86_64 $(DEFINES) $(INCDIRS)

COMPILERC   = /Developer/Tools/Rez
RCFLAGS     = -t APPL -o ../MACOSXX86_64/vmd_MACOSXX86_64 vmdmac.r

DEPEND      = -MM
DEPENDFILE  = Makedata.depend

LOADLIBES   = $(LIBDIRS) $(LIBS) 

LEX 	    = lex
YACC	    = yacc
YFLAGS      = -d

############################### 
# default rules 
###############################

.C.o: 
	$(ECHO) "Compiling " $< " --> " $*.o " ..."; \
	$(CCPP) $(CPPFLAGS) -c $< -o ../MACOSXX86_64/$@

.c.o:
	$(ECHO) "Compiling " $< " --> " $*.o " ..."; \
	$(CC) $(CFLAGS) -c $< -o ../MACOSXX86_64/$@

.cu.o:
	$(ECHO) "Compiling " $< " --> " $*.o " ..."; \
	$(NVCC) $(NVCCFLAGS) -c $< -o ../MACOSXX86_64/$@

.y.o:

.l.o:

########## Targets

### Source targets
all default:   vmd_MACOSXX86_64

vmd_MACOSXX86_64: y.tab.h $(VMD_OBJS)
	$(ECHO) "Linking " $@ "..."; \
	$(CD) ../MACOSXX86_64 ; \
	if [ ! -r ./foobar ]; then \
	  ln -s ../src/foobar ./foobar ; \
	fi; \
	$(CCPP) $(CPPFLAGS) -I../src -o $@ $(VMD_OBJS) $(LOADLIBES) ; 
	$(COMPILERC) $(RCFLAGS)

install:
	if [ ! -d "/Users/quolc/vmd/lib/vmd" ]; then \
		$(MAKEDIR) "/Users/quolc/vmd/lib/vmd" ; \
	fi ; \
	if [ ! -d "/Users/quolc/vmd/bin" ]; then \
		$(MAKEDIR) "/Users/quolc/vmd/bin" ; \
	fi ; \
	if [ ! -d "/Users/quolc/vmd/lib/vmd"/doc ]; then \
		$(MAKEDIR) "/Users/quolc/vmd/lib/vmd"/doc; \
	fi
	-$(COPY) ../Announcement  "/Users/quolc/vmd/lib/vmd"
	-$(COPY) ../README        "/Users/quolc/vmd/lib/vmd"
	-$(COPY) ../LICENSE       "/Users/quolc/vmd/lib/vmd"
	-$(COPY) ../doc/ug.pdf        "/Users/quolc/vmd/lib/vmd"/doc
	if [ -f /Users/quolc/vmd/lib/vmd/vmd_MACOSXX86_64 ]; then \
           $(MOVE) "/Users/quolc/vmd/lib/vmd/vmd_MACOSXX86_64" "/Users/quolc/vmd/lib/vmd/OLD_vmd_MACOSXX86_64" ; $(DELETE) "/Users/quolc/vmd/lib/vmd/OLD_vmd_MACOSXX86_64" ; fi
	-$(COPY) ../MACOSXX86_64/vmd_MACOSXX86_64 "/Users/quolc/vmd/lib/vmd"
	if [ -d "../lib/redistrib/lib_MACOSXX86_64" ]; then \
		$(CD) ../lib/redistrib/lib_MACOSXX86_64; $(TAR) -cf - ./* | \
		(cd "/Users/quolc/vmd/lib/vmd" ; $(TAR) -xf -) \
	fi ;
	-$(COPY) ../lib/stride/stride_MACOSXX86_64 ../lib/surf/surf_MACOSXX86_64 ../lib/tachyon/tachyon_MACOSXX86_64 "/Users/quolc/vmd/lib/vmd"
	-$(CD) ..; $(TAR) -cf - scripts | \
	(cd "/Users/quolc/vmd/lib/vmd" ; $(TAR) -xf -)
	-$(CD) ../lib; $(TAR) -cf - scripts | \
	(cd "/Users/quolc/vmd/lib/vmd" ; $(TAR) -xf -)
	-$(CD) ..; $(TAR) -cf - python | \
	(cd "/Users/quolc/vmd/lib/vmd"/scripts ; $(TAR) -xf -)
	-$(CD) ..; $(TAR) -cf - plugins | \
	(cd "/Users/quolc/vmd/lib/vmd" ; $(TAR) -xf -)
	-$(CD) ..; $(TAR) -cf - shaders | \
	(cd "/Users/quolc/vmd/lib/vmd" ; $(TAR) -xf -)
	-$(COPY) ../data/.vmdrc ../data/.vmdsensors ../data/vmd_completion.dat "/Users/quolc/vmd/lib/vmd"
	$(CD) ../bin ; \
	if [ -f run_vmd_tmp ]; then $(DELETE) run_vmd_tmp; fi ; \
	if [ ! -x "/bin/csh" ]; then \
		$(ECHO) "Info: /bin/csh shell not found, installing Bourne shell startup script instead" ; \
		$(ECHO) '#!/bin/sh' >> run_vmd_tmp ; \
		$(ECHO) 'defaultvmddir="/Users/quolc/vmd/lib/vmd"' >> run_vmd_tmp ; \
		$(ECHO) 'vmdbasename=vmd' >> run_vmd_tmp ; \
		cat vmd.sh >> run_vmd_tmp ; \
	else \
		$(ECHO) '#!/bin/csh' >> run_vmd_tmp ; \
		$(ECHO) 'set defaultvmddir="/Users/quolc/vmd/lib/vmd"' >> run_vmd_tmp ; \
		$(ECHO) 'set vmdbasename=vmd' >> run_vmd_tmp ; \
		cat vmd.csh >> run_vmd_tmp ; \
	fi ; \
	chmod +x run_vmd_tmp ; \
	$(COPY) run_vmd_tmp "/Users/quolc/vmd/bin"/vmd ; \
	$(DELETE) run_vmd_tmp
	$(ECHO) Make sure "/Users/quolc/vmd/bin"/vmd is in your path.
	$(ECHO) "VMD installation complete.  Enjoy!"

##### remove most of the cruft
clean:
	$(CD) ../MACOSXX86_64 ; \
		$(DELETE) *.o *.warnings *.depend.old core

veryclean: clean
	$(CD) ../MACOSXX86_64 ; \
	  $(DELETEDIR) foobar; \
	  $(DELETE) vmd_MACOSXX86_64
	$(CD) ../src ; \
	  $(DELETE) *.o *.a *~ core; \
	  $(DELETEDIR) foobar; \
	  $(DELETE) vmd_MACOSXX86_64
	$(CD) ../doc ; \
	  $(DELETE) *~ core

# The '/usr/include' stuff is to reduce checking /usr/include dates
depend: y.tab.h
	if [ "$(DEPEND)" != "" ]; then \
	echo "Building Makefile dependencies"; \
	  $(ECHO) "Creating " $(DEPENDFILE) " ..."; \
	  if [ -f $(DEPENDFILE) ]; then \
	    $(MOVE) -f $(DEPENDFILE) $(DEPENDFILE).old; \
	fi; \
	  touch $(DEPENDFILE); \
	for i in ZZZ $(VMD_CCPP) ; do \
	  if [ "$$i" != "ZZZ" ]; then \
	        $(ECHO) checking dependencies for $$i ...; \
	        $(CCPP) $(DEPEND) $(CPPFLAGS) $$i |  \
			sed -e 's/\/usr\/include\/[^ ]*\..//g' \
			    -e 's/\.\.\/lib\/.*\/[^ ]*\..//g' | \
			grep -v '^ *\\$$' >> $(DEPENDFILE) ; \
	  fi; \
	done; \
	for i in ZZZ $(VMD_CC) ; do \
	  if [ "$$i" != "ZZZ" ]; then \
	        $(ECHO) checking dependencies for $$i ...; \
	        $(CC) $(DEPEND) $(CFLAGS) $$i |  \
			sed -e 's/\/usr\/include\/[^ ]*\..//g' \
			    -e 's/\.\.\/lib\/.*\/[^ ]*\..//g' | \
			grep -v '^ *\\$$' >> $(DEPENDFILE) ; \
	  fi; \
	done; \
	$(ECHO) ParseTree.o AtomLexer.o AtomParser.o: y.tab.h \
                >> $(DEPENDFILE); \
	$(COPY) $(DEPENDFILE) $(DEPENDFILE).MACOSXX86_64 ; \
	else \
	  $(ECHO) "Cannot find dependencies; your compiler does not support dependency checking."; \
        fi



# to bootstrap without a Makedata.depend file, either
#   touch Makedata.depend
# or change the following line to 'sinclude'
include Makedata.depend

