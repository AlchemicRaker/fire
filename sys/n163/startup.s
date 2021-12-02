.segment "STARTUP_MAP"
    ; initialize chr banks
    lda #$00

    sta $8000
    sta $8800
    sta $9000
    sta $9800
    sta $A000
    sta $A800
    sta $B000
    sta $B800
    