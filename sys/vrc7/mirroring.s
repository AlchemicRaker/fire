.segment "PRG_FIXED"

.proc _select_mirror_vertical
.export _select_mirror_vertical
    lda #$00 ; vertical mirroring
    sta $E000
    rts
.endproc ; .proc _select_mirror_vertical

.proc _select_mirror_horizontal
.export _select_mirror_horizontal
    lda #$01 ; horizontal mirroring
    sta $E000
    rts
.endproc ; .proc _select_mirror_horizontal
