.segment "ZEROPAGE"

ptrf: .res 2 ; a zp pointer for this template
.export ptrf

.ifdef C_SUPPORT
    ; --C support--
    .export __STARTUP__:absolute=1
    .include "zeropage.inc"
    ; -------------
.endif

; only define prgbank if banking is enabled
.ifdef BANK_SUPPORT
    .export prgbank
    prgbank: .res 1
.endif
.ifdef DATA_SUPPORT
    .export databank
    databank: .res 1
.endif
.ifdef SAMPLE_SUPPORT
    .export samplebank
    samplebank: .res 1
.endif

PPU_CTRL	=$2000
PPU_MASK	=$2001
PPU_STATUS	=$2002
PPU_OAM_ADDR=$2003
PPU_OAM_DATA=$2004
PPU_SCROLL	=$2005
PPU_ADDR	=$2006
PPU_DATA	=$2007
PPU_OAM_DMA	=$4014
PPU_FRAMECNT=$4017
DMC_FREQ	=$4010
CTRL_PORT1	=$4016
CTRL_PORT2	=$4017

OAM_BUF		=$0200
