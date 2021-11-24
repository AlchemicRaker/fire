#!/usr/bin/make -f

# set rom name, mapper, and enable/disable C
TITLE := fire

# Mappers:
#   nrom
#   uxrom
#x  gtrom
#   mmc1
#   mmc3
#   fme-7
#   mmc5
#   vrc6
#   vrc7
#   n163
MAPPER := nrom

C_SUPPORT := 1 # Comment this line entirely to disable C support

SOURCEDIR = src
BUILDDIR = build
SYSDIR = sys
RESOURCEDIR = res




# shouldn't need to edit past this point

MAPPER_STRIP = $(strip $(MAPPER))

ifeq ($(MAPPER_STRIP),uxrom)
BANK_SUPPORT := 1
endif
ifeq ($(MAPPER_STRIP),mmc1)
BANK_SUPPORT := 1
endif
ifeq ($(MAPPER_STRIP),mmc3)
BANK_SUPPORT := 1
DATA_SUPPORT := 1
endif
ifeq ($(MAPPER_STRIP),mmc5)
BANK_SUPPORT := 1
DATA_SUPPORT := 1
SAMPLE_SUPPORT := 1
endif
ifeq ($(MAPPER_STRIP),fme-7)
BANK_SUPPORT := 1
DATA_SUPPORT := 1
SAMPLE_SUPPORT := 1
endif
ifeq ($(MAPPER_STRIP),vrc6)
BANK_SUPPORT := 1
DATA_SUPPORT := 1
endif
ifeq ($(MAPPER_STRIP),vrc7)
BANK_SUPPORT := 1
DATA_SUPPORT := 1
SAMPLE_SUPPORT := 1
endif
ifeq ($(MAPPER_STRIP),n163)
BANK_SUPPORT := 1
DATA_SUPPORT := 1
SAMPLE_SUPPORT := 1
endif


ROMFILE = $(BUILDDIR)/$(TITLE).nes
DBGFILE = $(BUILDDIR)/$(TITLE).dbg
MAPDIR = $(SYSDIR)/$(MAPPER_STRIP)
MAPCFG = $(MAPDIR)/layout.cfg
MAPBUILDDIR = $(BUILDDIR)/$(MAPPER_STRIP)
MAPFILE = $(MAPBUILDDIR)/map.txt
RESBUILDDIR = $(BUILDDIR)/$(MAPPER_STRIP)/res

SourceToBuildPath = $(subst $(SOURCEDIR)/,$(MAPBUILDDIR)/,$1)
SysToBuildPath = $(subst $(SYSDIR)/,$(MAPBUILDDIR)/,$1)
MapToBuildPath = $(subst $(MAPDIR)/,$(MAPBUILDDIR)/map/,$1)
ResToBuildPath = $(subst $(RESOURCEDIR)/,$(RESBUILDDIR)/,$1)

ASMFILES = $(wildcard $(SOURCEDIR)/*.s)
SYSFILES = $(wildcard $(SYSDIR)/*.s)
MAPFILES = $(wildcard $(MAPDIR)/*.s)
RESOURCEFILES = $(wildcard $(RESOURCEDIR)/*.s)
ASMOBJECTS = $(call SourceToBuildPath,$(ASMFILES:.s=.o)) $(call SysToBuildPath,$(SYSFILES:.s=.o))
ASMMAPOBJS = $(call MapToBuildPath,$(MAPFILES:.s=.o))
ASMRESOBJS = $(call ResToBuildPath,$(RESOURCEFILES:.s=.o))

# CFILES := $(wildcard $(SOURCEDIR)/*.c)

ifdef C_SUPPORT
	CAOPT := -g -D C_SUPPORT=1
	LIBRARIES := nes.lib
	
# CFILES := $(SOURCEDIR)/fire.c
	CFILES := $(wildcard $(SOURCEDIR)/*.c)
	CASM := $(call SourceToBuildPath,$(CFILES:.c=.s))
	COBJECTS := $(call SourceToBuildPath,$(CFILES:.c=.o))
else
	CAOPT := -g
	LIBRARIES :=
	CFILES :=
	CASM :=
	COBJECTS :=
endif

ifdef BANK_SUPPORT
	BANKOPT := -D BANK_SUPPORT=1
endif

ifdef DATA_SUPPORT
	DATAOPT := -D DATA_SUPPORT=1
endif

ifdef SAMPLE_SUPPORT
	SAMPLEOPT := -D SAMPLE_SUPPORT=1
endif

.DEFAULT_GOAL := build-rom

.PHONY: clean build-rom build-nrom build-uxrom build-gtrom build-mmc1 build-mmc3 build-fme-7 build-mmc5 build-vrc6 build-vrc7 build-n163 all build-all

all: build-rom

build-all: build-nrom build-uxrom build-gtrom build-mmc1 build-mmc3 build-fme-7 build-mmc5 build-vrc6 build-vrc7 build-n163

build-nrom:
	make build-rom TITLE=$(TITLE)-nrom MAPPER=nrom

build-uxrom:
	make build-rom TITLE=$(TITLE)-uxrom MAPPER=uxrom

build-gtrom:
	$(info gtrom not supported yet)

build-mmc1:
	make build-rom TITLE=$(TITLE)-mmc1 MAPPER=mmc1

build-mmc3:
	make build-rom TITLE=$(TITLE)-mmc3 MAPPER=mmc3

build-fme-7:
	make build-rom TITLE=$(TITLE)-fme-7 MAPPER=fme-7

build-mmc5:
	make build-rom TITLE=$(TITLE)-mmc5 MAPPER=mmc5

build-vrc6:
	make build-rom TITLE=$(TITLE)-vrc6 MAPPER=vrc6

build-vrc7:
	make build-rom TITLE=$(TITLE)-vrc7 MAPPER=vrc7

build-n163:
	make build-rom TITLE=$(TITLE)-n163 MAPPER=n163

build-rom: directories $(ROMFILE)

directories: $(BUILDDIR) $(MAPBUILDDIR) $(MAPBUILDDIR)/map $(RESBUILDDIR)

CLEANMAPFILES = $(wildcard $(MAPBUILDDIR)/*)
CLEANMAPDIR = $(wildcard $(MAPBUILDDIR))
CLEANFILES = $(wildcard $(BUILDDIR)/*)
CLEANDIR = $(wildcard $(BUILDDIR))

# TODO: make this work cross platform
clean:
# $(info removing $(MAPBUILDDIR) map $(CLEANMAPFILES))
# $(if $(CLEANMAPFILES),del $(subst /,\,$(CLEANMAPFILES)))
# $(if $(CLEANMAPDIR),rmdir $(subst /,\,$(CLEANMAPDIR)))
# $(if $(CLEANFILES),del $(subst /,\,$(CLEANFILES)))
# $(if $(CLEANDIR),rmdir $(CLEANDIR))
	$(if $(CLEANFILES), $(shell powershell Remove-Item .\$(BUILDDIR)\* -Force -Recurse))
# $(info asm objects $(ASMOBJECTS))
# $(info asm map objects $(ASMMAPOBJS))

$(BUILDDIR):
	$(if $(wildcard $(BUILDDIR)),,mkdir $@ $(info making $@))
	
$(MAPBUILDDIR): $(BUILDDIR)
	$(if $(wildcard $(MAPBUILDDIR)),,mkdir $(subst /,\,$@) $(info making $@))
	
$(MAPBUILDDIR)/map: $(MAPBUILDDIR)
	$(if $(wildcard $(MAPBUILDDIR)/map),,mkdir $(subst /,\,$@) $(info making $@))
	
$(RESBUILDDIR): $(MAPBUILDDIR)
	$(if $(wildcard $(MAPBUILDDIR)/res),,mkdir $(subst /,\,$@) $(info making $@))

# all expected build objects -> nes file
$(DBGFILE) $(ROMFILE) $(MAPOUT): $(ASMOBJECTS) $(ASMMAPOBJS) $(ASMRESOBJS) $(COBJECTS) $(CASM) | directories
	ld65 -o $(ROMFILE) -m $(MAPFILE) --dbgfile $(DBGFILE) -C $(MAPCFG) $(ASMOBJECTS) $(ASMRESOBJS) $(ASMMAPOBJS) $(COBJECTS) $(LIBRARIES)

# assembly source files -> build objects
$(MAPBUILDDIR)/%.o: $(SOURCEDIR)/%.s
	ca65 $< $(CAOPT) $(BANKOPT) $(DATAOPT) $(SAMPLEOPT) -o $@
	
# system assembly source files -> build objects
$(MAPBUILDDIR)/%.o: $(SYSDIR)/%.s
	ca65 $< $(CAOPT) $(BANKOPT) $(DATAOPT) $(SAMPLEOPT) -o $@ -I $(MAPDIR)
	
# mapper assembly source files -> build objects
$(MAPBUILDDIR)/map/%.o: $(MAPDIR)/%.s
	ca65 $< $(CAOPT) $(BANKOPT) $(DATAOPT) $(SAMPLEOPT) -o $@
	
# resource assembly source files -> build objects
$(RESBUILDDIR)/%.o: $(RESOURCEDIR)/%.s
	ca65 $< $(CAOPT) $(BANKOPT) $(DATAOPT) $(SAMPLEOPT) -o $@

# assembled c -> build objects
$(MAPBUILDDIR)/%.o: $(MAPBUILDDIR)/%.s
	ca65 $< $(CAOPT) $(BANKOPT) $(DATAOPT) $(SAMPLEOPT) -o $@

# c source -> assembled c
$(MAPBUILDDIR)/%.s: $(SOURCEDIR)/%.c
	cc65 -g -Oirs $< --add-source -o $@ --code-name PRG_FIXED $(BANKOPT) $(DATAOPT) $(SAMPLEOPT) -I $(SYSDIR)
