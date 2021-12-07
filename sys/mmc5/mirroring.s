.segment "PRG_FIXED"

.proc _select_mirror_vertical
.export _select_mirror_vertical
    lda #$44 ; vertical mirroring
    sta $5105
    rts
.endproc ; .proc _select_mirror_vertical

.proc _select_mirror_horizontal
.export _select_mirror_horizontal
    lda #$50 ; horizontal mirroring
    sta $5105
    rts
.endproc ; .proc _select_mirror_horizontal
