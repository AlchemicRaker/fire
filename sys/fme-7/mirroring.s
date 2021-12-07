.segment "PRG_FIXED"
.importzp fme7_command_shadow

.proc _select_mirror_vertical
.export _select_mirror_vertical
    lda #$0C
    sta fme7_command_shadow
    sta $8000
    lda #$00
    sta $A000
    rts
.endproc ; .proc _select_mirror_vertical

.proc _select_mirror_horizontal
.export _select_mirror_horizontal
    lda #$0C
    sta fme7_command_shadow
    sta $8000
    lda #$01
    sta $A000
    rts
.endproc ; .proc _select_mirror_horizontal
