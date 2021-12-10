; RAPID is a video library for NES
; providing performant direct and buffered update routines
; for both asm and C
; 


.segment "ZEROPAGE"
redi: .res 2
video_buffer_cursor: .res 2 ; used while flushing the buffer
video_buffer_pointer: .res 2 ; points to the next unused buffer location

.exportzp video_buffer_pointer
.exportzp _video_buffer_pointer = video_buffer_pointer

.segment "RAM"
nmi_counter: .res 1 ; increments during nmi
video_buffer_start: .res 2 ; can alter if you want to double-buffer
video_buffer_ready: .res 1 ; 0 = not ready, nonzero value = draw in next nmi
video_buffer: .res 100
.export nmi_counter
.export video_buffer, video_buffer_ready
.export _video_buffer = video_buffer, _video_buffer_ready = video_buffer_ready



.segment "STARTUP_LIB"
    lda #<video_buffer
    sta video_buffer_start
    lda #>video_buffer
    sta video_buffer_start+1

.segment "NMI_LIB"
    lda video_buffer_ready
    beq skip_video_flush
    jsr video_buffer_flush
skip_video_flush:


.segment "PRG_FIXED"

; video buffer design:
;  call prg rom subroutine
;    [subroutine address low byte] [subroutine address high byte >= $8000]
;  set ppu address (nametables and palettes)
;    [ppu address low byte] [ppu address high byte >= $2000 and <= $3FFFF]
;  end of flush
;    [unused byte] [ $00 ]
;  write value to ppu_data
;    [value byte] [ $01 ]
;  copy up to 255 bytes to ppu_data
;    [length byte] [ $02 ] [source address low byte] [source address high byte] 
;  write value to ppu_ctrl (vertical or horizontal)

.proc video_buffer_flush
    lda video_buffer_start
    sta video_buffer_cursor
    lda video_buffer_start+1
    sta video_buffer_cursor+1

    ; insert an "end of buffer" zero byte
    ldy #$01
    lda #$00
    sta video_buffer_pointer,y

    ; set video_buffer_ready = 0 for next nmi
    sta video_buffer_ready

    jmp video_buffer_parse_loop_first

video_command_ppu_data:
;  write value to ppu_data
;    [value byte] [ $01 ]
    lda video_buffer_cursor
    sta PPU_DATA

    ; loop until end byte reached
video_buffer_parse_loop:
.export video_buffer_parse_loop
    ; increment cursor by 2 before continuing
    lda video_buffer_cursor
    adc #$02
    sta video_buffer_cursor
    bcc video_buffer_parse_loop_first
    inc video_buffer_cursor+1

video_buffer_parse_loop_first:

    ; load the command byte
    ldy #$01
    lda (video_buffer_cursor),y

maybe_command:
    ; below #$20? it's a command
    cmp #$20
    bpl maybe_ppu_addr
    cmp #$01
    beq video_command_ppu_data ; command = 1
    bmi done_flushing_buffer ; command = 0
    
    ; command = 2

    ldy #$02 ; y = 0
    lda (video_buffer_cursor),y
    sta redi
    iny
    lda (video_buffer_cursor),y
    sta redi+1
    ldy #$00
    lda (video_buffer_cursor),y
    tax ; x = length
    
    ; increment cursor by 2 before continuing
    lda video_buffer_cursor
    adc #$02
    sta video_buffer_cursor
    bcc load_multi_loop
    inc video_buffer_cursor+1

    ; now video_buffer_cursor points to the source address
load_multi_loop:
    lda (redi),y ; a = source[y]
    sta PPU_DATA
    iny
    dex
    bne load_multi_loop

;  copy up to 255 bytes to ppu_data
;    [length byte] [ $02 ] [source address low byte] [source address high byte] 

    jmp video_buffer_parse_loop ; continue

maybe_ppu_addr:
    ; below #$40? it's PPU_ADDR
    cmp #$40
    bpl maybe_subroutine
    
;  set ppu address (nametables and palettes)
;    [ppu address low byte] [ppu address high byte >= $2000 and <= $3FFFF]
    sta PPU_ADDR
    dey
    lda (video_buffer_cursor),y
    sta PPU_ADDR

    jmp video_buffer_parse_loop ; continue

maybe_subroutine:
    ; it's a subroutine
    
;  call prg rom subroutine
;    [subroutine address low byte] [subroutine address high byte >= $8000]
    jsr video_buffer_jsr_launchpad

    jmp video_buffer_parse_loop ; continue



    ; reset video_buffer_pointer = video_buffer_start
done_flushing_buffer:    
    lda video_buffer_start
    sta video_buffer_pointer
    lda video_buffer_start+1
    sta video_buffer_pointer+1

    rts
.endproc ; .proc video_buffer_flush

.proc video_buffer_jsr_launchpad
.export video_buffer_jsr_launchpad
    jmp (video_buffer_cursor)
.endproc ; .proc video_buffer_jsr_launchpad




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
