; banks measured in 4k increments

.segment "PRG_FIXED"

.proc _select_mirror_vertical
.export _select_mirror_vertical
    lda #%11110 ; 4KB chr, PRG mode 3, vertical mirroring
    sta $8000
    lsr
    sta $8000
    lsr
    sta $8000
    lsr
    sta $8000
    lsr
    sta $8000
    rts
.endproc ; .proc _select_mirror_vertical

.proc _select_mirror_horizontal
.export _select_mirror_horizontal
    lda #%11111 ; 4KB chr, PRG mode 3, horizontal mirroring
    sta $8000
    lsr
    sta $8000
    lsr
    sta $8000
    lsr
    sta $8000
    lsr
    sta $8000
    rts
.endproc ; .proc _select_mirror_horizontal
