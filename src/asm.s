
.ifndef C_SUPPORT
.include "fire.inc"

.segment "PRG_FIXED"

.proc main
.export main
.import gray
loop:
    lda #$00
.ifdef BANK_SUPPORT
    farjsr gray
.else
    jsr gray
.endif
    ; farjmp gray
    lda #$AA
    jmp loop
.endproc

.segment "PRG_BANK_0"

.proc gray
.export gray
.import blue
    lda #$11
.ifdef BANK_SUPPORT
    farjsr blue
.else
    jsr blue
.endif
    ; farjmp blue
    lda #$22
    rts
.endproc

.segment "PRG_BANK_1"

.proc blue
.export blue
    lda #$33
    lda #$44
    ; jmp main
    rts
.endproc

.endif