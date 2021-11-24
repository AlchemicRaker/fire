
PPU_CTRL             = $2000
CTRL_NAMETABLE_2000  = $00
CTRL_NAMETABLE_2400  = $01
CTRL_NAMETABLE_2800  = $02
CTRL_NAMETABLE_2C00  = $03
CTRL_INCREMENT_1     = $00 << 2
CTRL_INCREMENT_32    = $01 << 2
CTRL_SPRITE_0000     = $00 << 3
CTRL_SPRITE_1000     = $01 << 3
CTRL_BG_0000         = $00 << 4
CTRL_BG_1000         = $01 << 4
CTRL_SPRITE_8x8      = $00 << 5
CTRL_SPRITE_8x16     = $01 << 5
; leave bit 6 off to avoid shorting the PPU
CTRL_NMI_DISABLE     = $00 << 7
CTRL_NMI_ENABLE      = $01 << 7

PPU_MASK	         = $2001
MASK_GRAYSCALE       = $01
MASK_SHOW_LEFT_BG    = $01 << 1
MASK_SHOW_LEFT_SPRITE= $01 << 2
MASK_HIDE_BG         = $00 << 3
MASK_SHOW_BG         = $01 << 3
MASK_HIDE_SPRITE     = $00 << 4
MASK_SHOW_SPRITE     = $01 << 4
MASK_EMPHASIZE_RED   = $01 << 5
MASK_EMPHASIZE_GREEN = $01 << 6
MASK_EMPHASIZE_BLUE  = $01 << 7

PPU_STATUS	         = $2002
STATUS_SPRITE_0      = $01 << 6
STATUS_VBLANK_START  = $01 << 7

OAM_ADDR             = $2003
; do not use OAM_DATA at $2004, use OAMDMA instead

PPU_SCROLL           = $2005 ; write twice for x and y
PPU_ADDR             = $2006 ; write twice (low, high) to set PPU ADDRESS
PPU_DATA             = $2007 ; write to the PPU, increments 



.export PPU_CTRL
.export CTRL_NAMETABLE_2000
.export CTRL_NAMETABLE_2400
.export CTRL_NAMETABLE_2800
.export CTRL_NAMETABLE_2C00
.export CTRL_INCREMENT_1
.export CTRL_INCREMENT_32
.export CTRL_SPRITE_0000
.export CTRL_SPRITE_1000
.export CTRL_BG_0000
.export CTRL_BG_1000
.export CTRL_SPRITE_8x8
.export CTRL_SPRITE_8x16
.export CTRL_NMI_DISABLE
.export CTRL_NMI_ENABLE
.export PPU_MASK
.export MASK_GRAYSCALE
.export MASK_SHOW_LEFT_BG
.export MASK_SHOW_LEFT_SPRITE
.export MASK_SHOW_BG
.export MASK_SHOW_SPRITE
.export MASK_EMPHASIZE_RED
.export MASK_EMPHASIZE_GREEN
.export MASK_EMPHASIZE_BLUE
.export PPU_STATUS
.export STATUS_SPRITE_0
.export STATUS_VBLANK_START
.export OAM_ADDR
.export PPU_SCROLL
.export PPU_ADDR
.export PPU_DATA