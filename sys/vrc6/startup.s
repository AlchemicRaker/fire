.segment "STARTUP_MAP"
    ; initialize chr banks
    lda #%00100000 ; 8 CHR banks, vertical mirroring
    sta $B003 ; PPU Banking Style

    lda #$00 ; CHR bank 0
    sta $D000
    lda #$01 ; CHR bank 1
    sta $D001
    lda #$02 ; CHR bank 2
    sta $D002
    lda #$03 ; CHR bank 3
    sta $D003
    lda #$04 ; CHR bank 4
    sta $E000
    lda #$05 ; CHR bank 5
    sta $E001
    lda #$06 ; CHR bank 6
    sta $E002
    lda #$07 ; CHR bank 7
    sta $E003
    