
.ifdef C_SUPPORT
.importzp       sp, ptr1, ptr2, tmp1, tmp2, tmp3, tmp4
.import pushax, popa, incsp3, incsp1, incsp4

.segment "ZEROPAGE"
redi: .res 2
_cptr: .res 2
.exportzp _cptr

shadow_scroll_x: .res 1
shadow_scroll_y: .res 1
.exportzp shadow_scroll_x, shadow_scroll_y
.exportzp _shadow_scroll_x = shadow_scroll_x, _shadow_scroll_y = shadow_scroll_y

.segment "NMI_LIB"
    lda PPU_STATUS
    lda shadow_scroll_x
    sta $2005
    lda shadow_scroll_y
    sta $2005

.segment "PRG_FIXED"

.import PPU_CTRL, PPU_STATUS, PPU_ADDR, PPU_SCROLL, PPU_MASK, PPU_DATA, OAM_ADDR
.import popa

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

.proc _wait_for_vblank
.export _wait_for_vblank
@loop:
    bit PPU_STATUS
    bpl @loop
    rts
.endproc ; .proc _wait_for_vblank

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

.endif ; .ifdef C_SUPPORT
