.segment "PRG_INIT_MAP"
.import select_chr_8k_0000
    ; initialize chr banks
    lda #$00
    jsr select_chr_8k_0000
