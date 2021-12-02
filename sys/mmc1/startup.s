.segment "STARTUP_MAP"
.import select_chr_8k_0000
    ; initialize Control register
    lda #%11100 ; 4KB chr, PRG mode 3, one screen mirroring
    sta $8000
    lsr
    sta $8000
    lsr
    sta $8000
    lsr
    sta $8000
    lsr
    sta $8000

    lda #$00
    jsr select_chr_8k_0000
