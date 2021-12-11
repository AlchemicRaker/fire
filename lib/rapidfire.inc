.ifndef RAPIDFIRE_INC
RAPIDFIRE_INC = 1
.FEATURE addrsize


; macros for loading the rapidfire buffer in asm

; push a subroutine, with up to four (1-byte) arguments
.macro rapidfire_push_subroutine subr, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8
.scope
.import VIDEO_BUFFER
.importzp video_buffer_offset
    ldy video_buffer_offset

; store subroutine
    lda #<(subr-1)
    sta VIDEO_BUFFER,y
    iny
    lda #>(subr-1)
    sta VIDEO_BUFFER,y
    iny

.ifnblank arg1
    lda arg2
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg2

.ifnblank arg2
    lda arg2
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg2

.ifnblank arg3
    lda arg3
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg3

.ifnblank arg4
    lda arg4
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg4

.ifnblank arg5
    lda arg5
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg5

.ifnblank arg6
    lda arg6
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg6

.ifnblank arg7
    lda arg7
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg7

.ifnblank arg8
    lda arg8
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg8

    sty video_buffer_offset
.endscope
.endmacro

; push up to eight (1-byte) arguments
.macro rapidfire_push_args arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8
.scope
.import VIDEO_BUFFER
.importzp video_buffer_offset
    ldy video_buffer_offset

.ifnblank arg1
    lda arg1
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg1

.ifnblank arg2
    lda arg2
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg2

.ifnblank arg3
    lda arg3
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg3

.ifnblank arg4
    lda arg4
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg4

.ifnblank arg5
    lda arg5
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg5

.ifnblank arg6
    lda arg6
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg6

.ifnblank arg7
    lda arg7
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg7

.ifnblank arg8
    lda arg8
    sta VIDEO_BUFFER,y
    iny
.endif ; .ifnblank arg8

    sty video_buffer_offset
.endscope
.endmacro



.macro rapidfire_push_ppu_addr newaddr
.scope
.import VIDEO_BUFFER, rapidfire_ppu_addr
.importzp video_buffer_offset
    ldy video_buffer_offset

; push rapidfire_ppu_addr subroutine
    lda #<(rapidfire_ppu_addr-1)
    sta VIDEO_BUFFER,y
    iny
    lda #>(rapidfire_ppu_addr-1)
    sta VIDEO_BUFFER,y
    iny

; push newaddr argument
    lda #>(newaddr)
    sta VIDEO_BUFFER,y ; PPU_ADDR is big endian, unlike every other address on 6502
    iny
    lda #<(newaddr)
    sta VIDEO_BUFFER,y
    iny

    sty video_buffer_offset
.endscope
.endmacro


.macro rapidfire_push_ppu_data data
.scope
.import VIDEO_BUFFER, rapidfire_ppu_data
.importzp video_buffer_offset
    ldy video_buffer_offset

; push rapidfire_ppu_data subroutine
    lda #<(rapidfire_ppu_data-1)
    sta VIDEO_BUFFER,y
    iny
    lda #>(rapidfire_ppu_data-1)
    sta VIDEO_BUFFER,y
    iny

; push data argument
    lda data
    sta VIDEO_BUFFER,y
    iny

    sty video_buffer_offset
.endscope
.endmacro

.macro rapidfire_push_ppu_data_2 data1, data2
.scope
.import VIDEO_BUFFER, rapidfire_ppu_data_2
.importzp video_buffer_offset
    ldy video_buffer_offset

; push rapidfire_ppu_data subroutine
    lda #<(rapidfire_ppu_data_2-1)
    sta VIDEO_BUFFER,y
    iny
    lda #>(rapidfire_ppu_data_2-1)
    sta VIDEO_BUFFER,y
    iny

; push data argument
    lda data1
    sta VIDEO_BUFFER,y
    iny

; push data argument
    lda data2
    sta VIDEO_BUFFER,y
    iny

    sty video_buffer_offset
.endscope
.endmacro

.macro rapidfire_push_ppu_data_4 data1, data2, data3, data4
.scope
.import VIDEO_BUFFER, rapidfire_ppu_data_4
.importzp video_buffer_offset
    ldy video_buffer_offset

; push rapidfire_ppu_data subroutine
    lda #<(rapidfire_ppu_data_4-1)
    sta VIDEO_BUFFER,y
    iny
    lda #>(rapidfire_ppu_data_4-1)
    sta VIDEO_BUFFER,y
    iny

; push data argument
    lda data1
    sta VIDEO_BUFFER,y
    iny

; push data argument
    lda data2
    sta VIDEO_BUFFER,y
    iny

; push data argument
    lda data3
    sta VIDEO_BUFFER,y
    iny

; push data argument
    lda data4
    sta VIDEO_BUFFER,y
    iny

    sty video_buffer_offset
.endscope
.endmacro


.macro rapidfire_push_ppu_ctrl data
.scope
.import VIDEO_BUFFER, rapidfire_ppu_ctrl
.importzp video_buffer_offset
    ldy video_buffer_offset

; push rapidfire_ppu_ctrl subroutine
    lda #<(rapidfire_ppu_ctrl-1)
    sta VIDEO_BUFFER,y
    iny
    lda #>(rapidfire_ppu_ctrl-1)
    sta VIDEO_BUFFER,y
    iny

; push data argument
    lda data
    sta VIDEO_BUFFER,y
    iny

    sty video_buffer_offset
.endscope
.endmacro


.endif ; .ifndef RAPIDFIRE_INC