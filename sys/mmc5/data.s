.proc _push_data_bank
    .export _push_data_bank
    .import pusha
    .importzp databank

    ;; new bank in a
    ora #$80 ; add the PRG ROM flag
    ; save a in x for a bit
    tax

    ; put old bank on c stack
    lda databank
    jsr pusha

    ; switch to new bank
    stx databank
    
    stx $5115 ; mmc5 bank set to databank
    
    rts
.endproc ; _push_data_bank

.proc _pop_data_bank
    .export _pop_data_bank
    .import popa
    .importzp databank

    jsr popa
    sta databank
    
    sta $5115 ; mmc5 bank set to databank
    
    rts
.endproc ; _pop_data_bank

.proc _select_data_bank
    .export _select_data_bank
    .importzp databank

    ora #$80 ; add the PRG ROM flag
    sta databank
    
    sta $5115 ; mmc5 bank set to databank
    
    rts
.endproc ; _select_data_bank
