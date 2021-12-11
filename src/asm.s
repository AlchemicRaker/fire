.include "RAPIDFIRE.inc"

.segment "PRG_FIXED"

.proc _sample_c_hook
.export _sample_c_hook
.import diggy_hole
    rapidfire_push_ppu_addr $2003
    rapidfire_push_ppu_data_4 #$03, #$01, #$07, #$07
    ; rapidfire_push_ppu_addr $2000
    ; rapidfire_push_subroutine diggy_hole, $CA
    rts
.endproc ; .proc _sample_c_hook


.proc diggy_hole
.export diggy_hole
    pla
    tax ; load and do something with a value
    rts
.endproc ; .proc diggy_hole


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