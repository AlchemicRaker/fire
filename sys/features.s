
.segment "PRG_FIXED"

.ifdef C_SUPPORT
.importzp       sp, ptr1, ptr2, tmp1, tmp2, tmp3, tmp4
.import pushax, popa, incsp3, incsp1, incsp4

; .ifdef BANK_SUPPORT
; ; mapper specific implementation
; .include "c_bank.inc"
; .endif ; .ifdef BANK_SUPPORT

; .ifdef DATA_SUPPORT
; ; mapper specific implementation
; .include "c_data.inc"
; .endif ; .ifdef DATA_SUPPORT

; .ifdef SAMPLE_SUPPORT
; ; mapper specific implementation
; .include "c_sample.inc"
; .endif ; .ifdef SAMPLE_SUPPORT

; ---------------------------------------------------------------
; void __near__ write_ppu_data (char length, unsigned char *souce)
; ---------------------------------------------------------------
.segment "ZEROPAGE"
redi: .res 2
_cptr: .res 2
.export _cptr

.segment "PRG_FIXED"

.import PPU_CTRL, PPU_STATUS, PPU_ADDR, PPU_SCROLL, PPU_MASK, PPU_DATA, OAM_ADDR

.proc _write_ppu_ctrl_raw
.export _write_ppu_ctrl_raw
    sta PPU_CTRL
    rts
.endproc ; .proc _write_ppu_ctrl_raw

.proc _write_ppu_mask_raw
.export _write_ppu_mask_raw
    sta PPU_MASK
    rts
.endproc ; .proc _write_ppu_mask_raw

.proc _read_ppu_status
.export _read_ppu_status
    lda PPU_STATUS
    ldx #$00
    rts
.endproc ; .proc _read_ppu_status

; .proc _write_oam_addr
; .export _write_oam_addr
;     stx OAM_ADDR
;     sta OAM_ADDR
;     rts
; .endproc

.proc _write_ppu_scroll
.export _write_ppu_scroll
    sta PPU_SCROLL
    jsr popa
    sta PPU_SCROLL
    rts
.endproc ; .proc _write_ppu_scroll

.proc _write_ppu_address_raw
.export _write_ppu_address_raw
    stx PPU_ADDR
    sta PPU_ADDR
    rts
.endproc ; .proc _write_ppu_address_raw

.proc _write_ppu_data
.export _write_ppu_data
    sta PPU_DATA
    rts
.endproc ; .proc _write_ppu_data

.proc _wait_for_vblank
.export _wait_for_vblank
@loop:
    bit PPU_STATUS
    bpl @loop

    rts
.endproc ; .proc _wait_for_vblank

.proc _wait_for_vblank_profile
.export _wait_for_vblank_profile
    ldx #$00
    ldy #$00
    clc ; 10331834
@loop:
    txa
    adc #$12 ; approximate cpu cycles per loop
    tax
    tya
    adc #$00
    tay
    bit PPU_STATUS
    bpl @loop ; 10331852

    lda #$00
    rts
.endproc ; .proc _wait_for_vblank_profile

;;;;;;;;

.proc _write_ppu_address_xy
.export _write_ppu_address_xy
    ; bit PPU_STATUS optimism
    stx PPU_ADDR
    sta PPU_ADDR
    rts
.endproc ; .proc _write_ppu_address_xy

.proc _write_ppu_scroll_xy
.export _write_ppu_scroll_xy
    ; bit PPU_STATUS optimism
    sta PPU_SCROLL
    jsr popa
    sta PPU_SCROLL
    rts
.endproc ; .proc _write_ppu_scroll_xy

.proc _write_ppu_status_off
.export _write_ppu_status_off

    lda #%00000000
    sta PPU_MASK

    rts
.endproc ; .proc _write_ppu_status_off

.proc _write_ppu_status_on
.export _write_ppu_status_on

    lda #%00001110
    sta PPU_MASK

    rts
.endproc ; .proc _write_ppu_status_on

.proc _write_ppu_data_char
.export _write_ppu_data_char
    ; jsr pushax

    sta redi
    stx redi+1

    jsr popa
    tax ; x counts down to 0
    ldy #$00

@loop:
    lda (redi),Y
    sta PPU_DATA
    iny
    dex
    bne @loop
    
    rts
.endproc ; .proc _write_ppu_data_char

.proc _write_ppu_data_nam
.export _write_ppu_data_nam

    sta redi
    stx redi+1
    
    ldx #$00 ; loop through 30 y rows
@loop_row:
    ldy #$00
@loop_col:
    lda (redi),Y
    sta PPU_DATA

    iny
    cpy #$20
    bne @loop_col

    clc
    lda redi
    adc #$20 ; advance the pointer by 32
    sta redi
    bcc @nocarry
    inc redi+1
@nocarry:

    inx
    cpx #$1E ; 30 y rows
    bne @loop_row
    
    rts
.endproc ; .proc _write_ppu_data_nam

.proc _write_ppu_data_fill
.export _write_ppu_data_fill
    ldx #$00 ; loop through 30 y rows
@loop_row:
    ldy #$00
@loop_col:
    sta PPU_DATA

    iny
    cpy #$20
    bne @loop_col

    inx
    cpx #$1E ; 30 y rows
    bne @loop_row
    
    rts
.endproc ; .proc _write_ppu_data_fill

.proc _write_ppu_data_copy_area_raw
.export _write_ppu_data_copy_area_raw
; void write_ppu_data_copy_area_raw(char *source, char width, char height, long unsigned int nt_start)
    sta ptr2+1
    stx ptr2 ; ptr2 = nametable address

    ldy #$02
    lda (sp),y
    sta ptr1
    iny
    lda (sp),y
    sta ptr1+1 ; ptr1 = source address

    ldy #$01
    lda (sp),y
    sta tmp1 ; tmp1 = width
    dey
    lda (sp),y
    sta tmp2 ; tmp2 = height

    ldx #$00 ; top of area, y = 0
@loop_row:

    ; write ppu address
    lda ptr2
    sta PPU_ADDR
    lda ptr2+1
    sta PPU_ADDR

    ldy #$00 ; leftmost column, x = 0
@loop_col:
    lda (ptr1),Y
    sta PPU_DATA

    iny
    cpy tmp1
    bne @loop_col

    ; increment ptr1 and ptr2 by 32
    clc
    lda ptr1
    adc #$20
    sta ptr1
    bcc @nocarry1
    inc ptr1+1
@nocarry1:

    clc
    lda ptr2+1
    adc #$20
    sta ptr2+1
    bcc @nocarry2
    inc ptr2
@nocarry2:

    inx
    cpx tmp2
    bne @loop_row

    lda sp
    ldx sp
    ldy sp

    jmp incsp4
.endproc ; .proc _write_ppu_data_copy_area_raw

.proc _write_ppu_data_fill_area
.export _write_ppu_data_fill_area
; void write_ppu_data_fill_area(char c, char width, char height, long unsigned int nt_start)
    sta ptr2+1
    stx ptr2 ; ptr2 = nametable address

    ldy #$02
    lda (sp),y
    sta tmp3 ; tmp3 = c
    dey
    lda (sp),y
    sta tmp1 ; tmp1 = width
    dey
    lda (sp),y
    sta tmp2 ; tmp2 = height

    ldx #$00 ; top of area, y = 0
@loop_row:

    ; write ppu address
    lda ptr2
    sta PPU_ADDR
    lda ptr2+1
    sta PPU_ADDR

    ldy #$00 ; leftmost column, x = 0
    lda tmp3
@loop_col:
    sta PPU_DATA

    iny
    cpy tmp1
    bne @loop_col

    ; increment ptr1 and ptr2 by 32
    clc
    lda ptr1
    adc #$20
    sta ptr1
    bcc @nocarry1
    inc ptr1+1
@nocarry1:

    clc
    lda ptr2+1
    adc #$20
    sta ptr2+1
    bcc @nocarry2
    inc ptr2
@nocarry2:

    inx
    cpx tmp2
    bne @loop_row

    lda sp
    ldx sp
    ldy sp

    jmp incsp3
.endproc ; .proc _write_ppu_data_fill_area

.proc _write_oam_shadow_raw
.export _write_oam_shadow_raw
    sta redi
    stx redi+1

    ldy #$03
    lda (sp),y
    sta (redi),y
    dey
    lda (sp),y
    sta (redi),y
    dey
    lda (sp),y
    sta (redi),y
    dey
    lda (sp),y
    sta (redi),y

    jmp incsp4
.endproc ; .proc _write_oam_mirror_raw


.endif ; .ifdef C_SUPPORT


