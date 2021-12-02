.segment "STARTUP_MAP"
    ; initialize chr banks
    lda #$00

    ldx #$00
@loop:
    stx $8000
    sta $A000
    inx
    cpx #$08
    bne @loop
    