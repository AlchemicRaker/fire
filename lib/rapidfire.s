; RAPIDFIRE is a video library for NES
; buffered NMI video updates for both asm and C
; using the high performance popslide technique
; 


.segment "ZEROPAGE"
redi: .res 2
video_buffer_offset: .res 1 ; points to the next unused buffer location

.exportzp video_buffer_offset
.exportzp _video_buffer_offset = video_buffer_offset

.segment "RAM"
nmi_counter: .res 1 ; increments during nmi
video_buffer_ready: .res 1 ; 0 = not ready, nonzero value = draw in next nmi
video_buffer_sp: .res 1 ; preserve the sp, since rapidfire will clobber it

VIDEO_BUFFER = $0100 ; low end of the stack

.export nmi_counter
.export video_buffer_ready, VIDEO_BUFFER
.export _VIDEO_BUFFER = VIDEO_BUFFER, _video_buffer_ready = video_buffer_ready



.segment "STARTUP_LIB"
    lda #$00
    sta video_buffer_offset
    sta video_buffer_ready

.segment "NMI_LIB"
    lda video_buffer_ready
    beq skip_video_flush
    jsr video_buffer_flush
skip_video_flush:


.segment "PRG_FIXED"

; rapidfire video buffer design:
;  video routine addresses(-1) are stored starting at $100
;  arguments for those routines are stored in line, following the routine address

.proc video_buffer_flush
    
    tsx
    stx video_buffer_sp ; preserve stack pointer

    ldx #$FF ; sp will decrement to $00 to find the first loaded subroutine
    txs

    rts ; begin!

end_of_rapidfire:
.export end_of_rapidfire

    ldx video_buffer_sp ; restore stack pointer
    txs
    
    rts
.endproc ; .proc video_buffer_flush

.proc rapidfire_ready
.export rapidfire_ready
.export _rapidfire_ready = rapidfire_ready
.import end_of_rapidfire
    ldy video_buffer_offset
    lda #<(end_of_rapidfire-1)
    sta VIDEO_BUFFER,y
    iny
    lda #>(end_of_rapidfire-1)
    sta VIDEO_BUFFER,y
    sta video_buffer_ready
    ldy #$00
    sty video_buffer_offset
    rts
.endproc ; .proc rapidfire_ready 

;;; rapidfire-ready functions

.proc rapidfire_ppu_addr
.export rapidfire_ppu_addr
.export _rapidfire_ppu_addr = rapidfire_ppu_addr
    lda PPU_STATUS
    pla
    sta PPU_ADDR
    pla
    sta PPU_ADDR
    rts
.endproc ; .proc rapidfire_ppu_addr

.proc rapidfire_ppu_data
.export rapidfire_ppu_data
.export _rapidfire_ppu_data = rapidfire_ppu_data
    pla
    sta PPU_DATA
    rts
.endproc ; .proc rapidfire_ppu_data

.proc rapidfire_ppu_data_2
.export rapidfire_ppu_data_2
    pla
    sta PPU_DATA
    pla
    sta PPU_DATA
    rts
.endproc ; .proc rapidfire_ppu_data_2

.proc rapidfire_ppu_data_4
.export rapidfire_ppu_data_4
    pla
    sta PPU_DATA
    pla
    sta PPU_DATA
    pla
    sta PPU_DATA
    pla
    sta PPU_DATA
    rts
.endproc ; .proc rapidfire_ppu_data_4

.proc rapidfire_ppu_ctrl
.export rapidfire_ppu_ctrl
.export _rapidfire_ppu_ctrl = rapidfire_ppu_ctrl
    pla
    sta PPU_CTRL
    rts
.endproc ; .proc rapidfire_ppu_ctrl


;;; these subroutines are inferior to the macros
.proc rapidfire_subroutine ; queue ax
.export rapidfire_subroutine, rapidfire_ax = rapidfire_subroutine
    ldy video_buffer_offset
    sta VIDEO_BUFFER,y
    iny
    txa
    sta VIDEO_BUFFER,y
    iny
    sty video_buffer_offset
    rts
.endproc

.proc rapidfire_a ; queue a
.export rapidfire_a
    ldy video_buffer_offset
    sta VIDEO_BUFFER,y
    iny
    sty video_buffer_offset
    rts
.endproc

.proc rapidfire_subroutine_y ; queue axy
.export rapidfire_subroutine_y, rapidfire_axy = rapidfire_subroutine_y
    sty redi
    ldy video_buffer_offset
    sta VIDEO_BUFFER,y
    iny
    txa
    sta VIDEO_BUFFER,y
    iny
    lda redi
    sta VIDEO_BUFFER,y
    iny
    sty video_buffer_offset
    rts
.endproc



;; common helper functions

.proc wait_for_vblank ; wait_for_vblank()
.export wait_for_vblank
.export _wait_for_vblank = wait_for_vblank
@loop:
    bit PPU_STATUS
    bpl @loop
    rts
.endproc ; .proc wait_for_vblank

.proc wait_for_nmi ; wait_for_nmi()
.export wait_for_nmi
.export _wait_for_nmi = wait_for_nmi
    lda nmi_counter
loop:
    cmp nmi_counter
    beq loop
    rts
.endproc ; .proc wait_for_nmi

.proc write_ppu_data_nam ; write_ppu_data_nam(ax = address of nametable data)
.export write_ppu_data_nam
.export _write_ppu_data_nam = write_ppu_data_nam

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

.segment "NMI_LIB"
.proc maybe_draw_video_buffer
    lda #$00
    cmp video_buffer_ready
    beq skip_buffer_flush
    jsr video_buffer_flush
skip_buffer_flush:
.endproc ; .proc maybe_draw_video_buffer



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.ifdef C_SUPPORT
.importzp       sp, ptr1, ptr2, tmp1, tmp2, tmp3, tmp4
.import pushax, popa, incsp3, incsp1, incsp4

.segment "ZEROPAGE"
_cptr: .res 2
.exportzp _cptr

shadow_scroll_x: .res 1
shadow_scroll_y: .res 1
.exportzp shadow_scroll_x, shadow_scroll_y
.exportzp _shadow_scroll_x = shadow_scroll_x, _shadow_scroll_y = shadow_scroll_y

.segment "NMI_LIB"
    ; todo, this shadow may be moved into video routines
    lda PPU_STATUS
    lda shadow_scroll_x
    sta $2005
    lda shadow_scroll_y
    sta $2005
    inc nmi_counter

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

.proc _write_ppu_data_char
.export _write_ppu_data_char

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
