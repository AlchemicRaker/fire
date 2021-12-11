#!/usr/bin/make -f
# Usage:
# make
#   builds the project with the default MAPPER (selected below)
# make build-nrom
#   builds the project with the specified mapper (build-mmc3, build-uxrom, etc)
# make build-all
#   builds the project with all of the available mappers
# make clean


# name of the output rom, eg "fire.nes"
TITLE := fire

# Build supports C and ASM out of the box
C_SUPPORT := 1 # Comment out this line to disable C support

# Include these community libraries in your project
MODULES = IRQ_SCREEN_SCROLL RAPIDFIRE # FAMISTUDIO
# IRQ_SCREEN_SCROLL - Schedule a horizontal scroll split IRQ
# SPRITE_0_SCREEN_SCROLL - Helper function for scheduling a scroll split with sprite 0 (can have CPU cost) (todo)

# Audio Engine Modules:
#  FAMISTUDIO - audio driver for FamiStudio
#  BHOP - audio driver for FamiTracker, under development but aims to support all FamiTracker features (incomplete)
#  FAMITONE5 - optimized audio driver for FamiTracker, has reduced featureset to achieve these optimizations (todo)

# Include the small customizations to the template
OPTIONS := MMC3_1K_SPRITES C_NMI_HOOK
# C_NMI_HOOK - Calls `nmi_hook()` in C during NMI, after the OAMDMA and the optional NMI_HANDLE_GAME segment
# MMC3_1K_SPRITES - MMC3 CHR A12 inversion = 0, 1kx4 sprite banks, 2kx2 background banks
# MMC3_1K_BACKGROUNDS - MMC3 CHR A12 inversion = 1, 1kx4 background banks, 2kx2 sprite banks

# Select the mapper you want to use for your default builds
MAPPER := nrom
# nrom, uxrom, mmc1, mmc3, mmc5, fme-7, vrc6, vrc7, n163, (gtrom)
# nrom - the simplest mapper, with no prg or chr banks and no additional features
# uxrom - common family of mappers with one window of bankable PRG
# mmc1 - common mapper with one window of bankable PRG and two windows of bankable CHR
# mmc3 - common mapper with two windows of bankable PRG and six windows of bankable CHR
# mmc5 - powerful mapper with four windows of bankable PRG, eight windows of bankable CHR, 128KB of PRG RAM, expansion audio, and more
# fme-7 - powerful mapper with four windows of bankable PRG, eight windows of bankable CHR, 512KB of PRG RAM, and expansion audio
# vrc6 - mapper with two windows of bankable PRG, eight windows of bankable CHR, and expansion audio
# vrc7 - mapper with three windows of bankable PRG, eight windows of bankable CHR, and expansion audio
# n163 - mapper with three windows of bankable PRG, twelve windows of bankable CHR, and expansion audio
# gtrom - homebrew mapper with bankable PRG and CHR, not yet supported

ALL_MAPPERS := nrom uxrom gtrom mmc1 mmc3 mmc5 fme-7 vrc6 vrc7 n163
# when using build-all, build all of these mappers
# recommended: 
#   leave this list alone until you no longer wish to abandon compatability with a particular mapper
#   for instance, once you start using PRG banking, remove nrom

# For mappers with fixed mirroring, choose horizontal or vertical
FIXED_MIRRORING = vertical



# not recommended to edit these root directories, but you can if you want

SOURCEDIR = src
BUILDDIR = build
SYSDIR = sys
RESOURCEDIR = res
LIBDIR = lib

#####################                                        #####################
##################### shouldn't need to edit past this point #####################
#####################                                        #####################

MAPPER_STRIP = $(strip $(MAPPER))

ifeq ($(MAPPER_STRIP),nrom)
OPTIONS := $(OPTIONS) MAPPER_NROM
endif
ifeq ($(MAPPER_STRIP),uxrom)
OPTIONS := $(OPTIONS) MAPPER_UXROM BANK_SUPPORT
endif
ifeq ($(MAPPER_STRIP),mmc1)
OPTIONS := $(OPTIONS) MAPPER_MMC1 BANK_SUPPORT CHR_8K_SUPPORT CHR_4K_SUPPORT DYANIC_MIRRORING
endif
ifeq ($(MAPPER_STRIP),mmc3)
OPTIONS := $(OPTIONS) MAPPER_MMC3 BANK_SUPPORT DATA_SUPPORT IRQ_SUPPORT CHR_8K_SUPPORT CHR_4K_SUPPORT CHR_2K_SUPPORT DYANIC_MIRRORING
endif
ifeq ($(MAPPER_STRIP),mmc5)
OPTIONS := $(OPTIONS) MAPPER_MMC5 BANK_SUPPORT DATA_SUPPORT SAMPLE_SUPPORT IRQ_SUPPORT CHR_8K_SUPPORT CHR_4K_SUPPORT CHR_2K_SUPPORT CHR_1K_S_SUPPORT CHR_1K_B_SUPPORT DYANIC_MIRRORING
endif
ifeq ($(MAPPER_STRIP),fme-7)
OPTIONS := $(OPTIONS) MAPPER_FME7 BANK_SUPPORT DATA_SUPPORT SAMPLE_SUPPORT IRQ_SUPPORT CHR_8K_SUPPORT CHR_4K_SUPPORT CHR_2K_SUPPORT CHR_1K_S_SUPPORT CHR_1K_B_SUPPORT DYANIC_MIRRORING
endif
ifeq ($(MAPPER_STRIP),vrc6)
OPTIONS := $(OPTIONS) MAPPER_VRC6 BANK_SUPPORT DATA_SUPPORT IRQ_SUPPORT CHR_8K_SUPPORT CHR_4K_SUPPORT CHR_2K_SUPPORT CHR_1K_S_SUPPORT CHR_1K_B_SUPPORT DYANIC_MIRRORING
endif
ifeq ($(MAPPER_STRIP),vrc7)
OPTIONS := $(OPTIONS) MAPPER_VRC7 BANK_SUPPORT DATA_SUPPORT SAMPLE_SUPPORT IRQ_SUPPORT CHR_8K_SUPPORT CHR_4K_SUPPORT CHR_2K_SUPPORT CHR_1K_S_SUPPORT CHR_1K_B_SUPPORT DYANIC_MIRRORING
endif
ifeq ($(MAPPER_STRIP),n163)
OPTIONS := $(OPTIONS) MAPPER_N163 BANK_SUPPORT DATA_SUPPORT SAMPLE_SUPPORT IRQ_SUPPORT CHR_8K_SUPPORT CHR_4K_SUPPORT CHR_2K_SUPPORT CHR_1K_S_SUPPORT CHR_1K_B_SUPPORT DYANIC_MIRRORING
endif

ROMFILE = $(BUILDDIR)/$(TITLE).nes
DBGFILE = $(BUILDDIR)/$(TITLE).dbg
MAPDIR = $(SYSDIR)/$(MAPPER_STRIP)
MAPCFG = $(MAPDIR)/layout.cfg
MAPBUILDDIR = $(BUILDDIR)/$(MAPPER_STRIP)
MAPFILE = $(MAPBUILDDIR)/map.txt
SYSBUILDDIR = $(BUILDDIR)/$(MAPPER_STRIP)/sys
RESBUILDDIR = $(BUILDDIR)/$(MAPPER_STRIP)/res
LIBBUILDDIR = $(BUILDDIR)/$(MAPPER_STRIP)/lib

SourceToBuildPath = $(subst $(SOURCEDIR)/,$(MAPBUILDDIR)/,$1)
SysToBuildPath = $(subst $(SYSDIR)/,$(SYSBUILDDIR)/,$1)
MapToBuildPath = $(subst $(MAPDIR)/,$(MAPBUILDDIR)/map/,$1)
ResToBuildPath = $(subst $(RESOURCEDIR)/,$(RESBUILDDIR)/,$1)
LibToBuildPath = $(subst $(LIBDIR)/,$(LIBBUILDDIR)/,$1)

ASMFILES = $(wildcard $(SOURCEDIR)/*.s)
SYSFILES = $(wildcard $(SYSDIR)/*.s)
MAPFILES = $(wildcard $(MAPDIR)/*.s)
RESOURCEFILES = $(wildcard $(RESOURCEDIR)/*.s)
LIBFILES = $(foreach lib,$(MODULES),$(wildcard $(LIBDIR)/$(lib).s))
ASMOBJECTS = $(call SourceToBuildPath,$(ASMFILES:.s=.o))
SYSOBJECTS = $(call SysToBuildPath,$(SYSFILES:.s=.o))
ASMMAPOBJS = $(call MapToBuildPath,$(MAPFILES:.s=.o))
ASMRESOBJS = $(call ResToBuildPath,$(RESOURCEFILES:.s=.o))
ASMLIBOBJS = $(call LibToBuildPath,$(LIBFILES:.s=.o))

LIBOPTS = $(foreach lib,$(MODULES),-D $(lib)=1)
OPTIONFLAGS := $(foreach opt,$(OPTIONS),-D $(opt)=1)

ifeq ($(FIXED_MIRRORING),vertical)
	OPTIONFLAGS := $(OPTIONFLAGS) -D INES_MIRROR=1
endif
ifeq ($(FIXED_MIRRORING),horizontal)
	OPTIONFLAGS := $(OPTIONFLAGS) -D INES_MIRROR=0
endif

ifdef C_SUPPORT
	CAOPT := -g -D C_SUPPORT=1 $(LIBOPTS) -D FAMISTUDIO_CFG_C_BINDINGS=1 $(OPTIONFLAGS)
	CCOPT := -g -Oirs --add-source $(LIBOPTS) $(OPTIONFLAGS)
	LIBRARIES := nes.lib
	
# CFILES := $(SOURCEDIR)/fire.c
	CFILES := $(wildcard $(SOURCEDIR)/*.c)
	CASM := $(call SourceToBuildPath,$(CFILES:.c=.s))
	COBJECTS := $(call SourceToBuildPath,$(CFILES:.c=.o))
else
	CAOPT := -g $(LIBOPTS) -D FAMISTUDIO_CFG_C_BINDINGS=0 $(OPTIONFLAGS)
	LIBRARIES :=
	CFILES :=
	CASM :=
	COBJECTS :=
endif

ifeq ($(MAPPER_STRIP),mmc3)
ifneq (,$(findstring MMC3_1K_SPRITES,$(OPTIONS)))
	CAOPT := $(CAOPT) -D MMC3_CHR_A12=0 -D CHR_1K_S_SUPPORT=1
	CCOPT := $(CCOPT) -D MMC3_CHR_A12=0 -D CHR_1K_S_SUPPORT=1
endif
ifneq (,$(findstring MMC3_1K_BACKGROUNDS,$(OPTIONS)))
	CAOPT := $(CAOPT) -D MMC3_CHR_A12=128 -D CHR_1K_B_SUPPORT=1
	CCOPT := $(CCOPT) -D MMC3_CHR_A12=128 -D CHR_1K_B_SUPPORT=1
endif
endif

ALL_OBJECTS = $(ASMOBJECTS) $(SYSOBJECTS) $(ASMMAPOBJS) $(ASMRESOBJS) $(ASMLIBOBJS) $(COBJECTS)
ALL_DEPS = $(ALL_OBJECTS:.o=.d)

.DEFAULT_GOAL := build-rom

.PHONY: clean build-rom build-nrom build-uxrom build-gtrom build-mmc1 build-mmc3 build-fme-7 build-mmc5 build-vrc6 build-vrc7 build-n163 all build-all

all: build-rom

build-all: $(foreach mapper,$(ALL_MAPPERS),build-$(mapper))

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

directories: $(BUILDDIR) $(MAPBUILDDIR) $(MAPBUILDDIR)/map $(RESBUILDDIR) $(LIBBUILDDIR) $(SYSBUILDDIR)

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
	
$(LIBBUILDDIR): $(MAPBUILDDIR)
	$(if $(wildcard $(MAPBUILDDIR)/lib),,mkdir $(subst /,\,$@) $(info making $@))
	
$(SYSBUILDDIR): $(MAPBUILDDIR)
	$(if $(wildcard $(MAPBUILDDIR)/sys),,mkdir $(subst /,\,$@) $(info making $@))

# all expected build objects -> nes file
$(DBGFILE) $(ROMFILE) $(MAPOUT): $(ALL_OBJECTS) | directories
	ld65 -o $(ROMFILE) -m $(MAPFILE) --dbgfile $(DBGFILE) -C $(MAPCFG) $(ALL_OBJECTS) $(LIBRARIES)

# assembly source files -> build objects
$(MAPBUILDDIR)/%.o: $(SOURCEDIR)/%.s makefile | directories
	ca65 $< $(CAOPT) -o $@ --create-full-dep $(@:.o=.d) -I $(SYSDIR) -I $(LIBDIR)
	
# system assembly source files -> build objects
$(SYSBUILDDIR)/%.o: $(SYSDIR)/%.s makefile | directories
	ca65 $< $(CAOPT) -o $@ -I $(MAPDIR) --create-full-dep $(@:.o=.d)
	
# mapper assembly source files -> build objects
$(MAPBUILDDIR)/map/%.o: $(MAPDIR)/%.s makefile | directories
	ca65 $< $(CAOPT) -o $@ --create-full-dep $(@:.o=.d)
	
# resource assembly source files -> build objects
$(RESBUILDDIR)/%.o: $(RESOURCEDIR)/%.s makefile | directories
	ca65 $< $(CAOPT) -o $@ --create-full-dep $(@:.o=.d)
	
# module assembly source files -> build objects
$(LIBBUILDDIR)/%.o: $(LIBDIR)/%.s makefile | directories
	ca65 $< $(CAOPT) -o $@ --create-full-dep $(@:.o=.d)

# assembled c -> build objects
$(MAPBUILDDIR)/%.o: $(MAPBUILDDIR)/%.s makefile | directories
	ca65 $< $(CAOPT) -o $@

# c source -> assembled c
$(MAPBUILDDIR)/%.s: $(SOURCEDIR)/%.c makefile | directories
	cc65 $< $(CCOPT) -o $@ --code-name PRG_FIXED -I $(SYSDIR) -I $(LIBDIR) --create-full-dep $(@:.s=.d)

-include $(ALL_DEPS)
