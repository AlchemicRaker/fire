
.segment "PRG_FIXED"

.ifdef C_SUPPORT
.importzp       sp, ptr1
.import pushax, popa, incsp3, incsp1

.ifdef BANK_SUPPORT
; mapper specific implementation
.include "c_bank.inc"
.endif ; .ifdef BANK_SUPPORT

.ifdef DATA_SUPPORT
; mapper specific implementation
.include "c_data.inc"
.endif ; .ifdef DATA_SUPPORT

.ifdef SAMPLE_SUPPORT
; mapper specific implementation
.include "c_sample.inc"
.endif ; .ifdef SAMPLE_SUPPORT

; ---------------------------------------------------------------
; void __near__ write_ppu_data (char length, unsigned char *souce)
; ---------------------------------------------------------------
.segment "ZEROPAGE"
redi:
    .res 2

.segment "PRG_FIXED"

.import PPU_CTRL, PPU_STATUS, PPU_ADDR, PPU_SCROLL, PPU_MASK, PPU_DATA, OAM_ADDR

.proc _write_ppu_ctrl_raw
.export _write_ppu_ctrl_raw
    sta PPU_CTRL
    rts
.endproc

.proc _write_ppu_mask_raw
.export _write_ppu_mask_raw
    sta PPU_MASK
    rts
.endproc

.proc _read_ppu_status
.export _read_ppu_status
    lda PPU_STATUS
    ldx #$00
    rts
.endproc

.proc _write_oam_addr
.export _write_oam_addr
    stx OAM_ADDR
    sta OAM_ADDR
    rts
.endproc

.proc _write_ppu_scroll
.export _write_ppu_scroll
    sta PPU_SCROLL
    jsr popa
    sta PPU_SCROLL
    rts
.endproc

.proc _write_ppu_address_raw
.export _write_ppu_address_raw
    stx PPU_ADDR
    sta PPU_ADDR
    rts
.endproc

.proc _write_ppu_data
.export _write_ppu_data
    sta PPU_DATA
    rts
.endproc

.proc _wait_for_vblank
.export _wait_for_vblank
@loop:
    bit PPU_STATUS
    bpl @loop

    rts
.endproc

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
.endproc

;;;;;;;;

.proc _write_ppu_address_xy
.export _write_ppu_address_xy
    ; bit PPU_STATUS optimism
    stx PPU_ADDR
    sta PPU_ADDR
    rts
.endproc

.proc _write_ppu_scroll_xy
.export _write_ppu_scroll_xy
    ; bit PPU_STATUS optimism
    sta PPU_SCROLL
    jsr popa
    sta PPU_SCROLL
    rts
.endproc

.proc _write_ppu_status_off
.export _write_ppu_status_off

    lda #%00000000
    sta PPU_MASK

    rts
.endproc

.proc _write_ppu_status_on
.export _write_ppu_status_on

    lda #%00001110
    sta PPU_MASK

    rts
.endproc

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
.endproc

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
.endproc


.endif ; .ifdef C_SUPPORT


