
.ifndef MMC3_CHR_A12
.error "Must include MMC3_1K_SPRITES or MMC3_1K_BACKGROUNDS in makefile OPTIONS in order to build for MMC3"
.endif

.ifdef C_SUPPORT

.proc push_data_bank
    .export push_data_bank, _push_data_bank = push_data_bank
    .import pusha
    .importzp databank

    ;; new bank in a
    ; save a in x for a bit
    tax

    ; put old bank on c stack
    lda databank
    jsr pusha

    ; switch to new bank
    stx databank

    ; this setup for mmc3
    lda #(%00000111 | MMC3_CHR_A12)
    sta $8002 ; mmc3 bank select for DATA bank $A000

    stx $8001 ; mmc3 bank set to databank
    
    rts
.endproc ; _push_data_bank

.proc pop_data_bank
    .export pop_data_bank, _pop_data_bank = pop_data_bank
    .import popa
    .importzp databank

    jsr popa
    sta databank

    ; this setup for mmc3
    ldx #(%00000111 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for DATA bank $A000

    sta $8001 ; mmc3 bank set to databank
    
    rts
.endproc ; _push_data_bank

.endif

.proc select_data_bank
    .export select_data_bank, _select_data_bank = select_data_bank
    .importzp databank

    ; this setup for mmc3
    ldx #(%00000111 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for DATA bank $A000

    sta $8001 ; mmc3 bank set to databank
    
    rts
.endproc ; _select_data_bank
