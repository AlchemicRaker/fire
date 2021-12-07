.segment "PRG_FIXED"

.proc _select_mirror_vertical
.export _select_mirror_vertical
    lda #%00100000 ; CHR A10, vertical mirroring
    sta $B003
    rts
.endproc ; .proc _select_mirror_vertical

.proc _select_mirror_horizontal
.export _select_mirror_horizontal
    lda #%00100100 ; CHR A10, horizontal mirroring
    sta $B003
    rts
.endproc ; .proc _select_mirror_horizontal
