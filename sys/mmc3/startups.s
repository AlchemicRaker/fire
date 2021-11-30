.segment "PRG_INIT_MAP"
    ; initialize chr banks
    lda #%00000000
    sta $8002 ; mmc3 bank select for CHR bank $0000
    lda #$00
    sta $8001
    lda #%00000001
    sta $8002 ; mmc3 bank select for CHR bank $0800
    lda #$02
    sta $8001
    
    lda #%00000010
    sta $8002 ; mmc3 bank select for CHR bank $1000
    lda #$04
    sta $8001
    lda #%00000011
    sta $8002 ; mmc3 bank select for CHR bank $1400
    lda #$05
    sta $8001
    lda #%00000100
    sta $8002 ; mmc3 bank select for CHR bank $1800
    lda #$06
    sta $8001
    lda #%00000101
    sta $8002 ; mmc3 bank select for CHR bank $1C00
    lda #$07
    sta $8001
    