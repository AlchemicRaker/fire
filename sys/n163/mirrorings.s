.segment "PRG_FIXED"

.proc _select_mirror_vertical
.export _select_mirror_vertical
    lda #$E0 ; horizontal mirroring
    sta $C000
    sta $D000
    lda #$E1 ; horizontal mirroring
    sta $C800
    sta $D800
    rts
.endproc ; .proc _select_mirror_vertical

.proc _select_mirror_horizontal
.export _select_mirror_horizontal
    lda #$E0 ; vertical mirroring
    sta $C000
    sta $C800
    lda #$E1 ; vertical mirroring
    sta $D000
    sta $D800
    rts
.endproc ; .proc _select_mirror_horizontal
