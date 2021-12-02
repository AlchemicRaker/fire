.segment "STARTUP_MAP"
    ; initialize chr banks

    lda #$00 ; CHR bank 0
    sta $A000
    sta $A008
    sta $B000
    sta $B008
    sta $C000
    sta $C008
    sta $D000
    sta $D008
    