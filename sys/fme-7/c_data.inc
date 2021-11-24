.proc _push_data_bank
    .export _push_data_bank
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

    ; this setup for fme-7
    lda #$A
    sta $8000 ; fme-7 bank select for PRG bank $A000

    stx $A000 ; fme-7 bank set to databank
    
    rts
.endproc ; _push_data_bank

.proc _pop_data_bank
    .export _pop_data_bank
    .import popa
    .importzp databank

    jsr popa
    sta databank

    ; this setup for fme-7
    ldx #$A
    stx $8000 ; fme-7 bank select for PRG bank $A000

    sta $A000 ; fme-7 bank set to databank
    
    rts
.endproc ; _pop_data_bank

.proc _select_data_bank
    .export _select_data_bank
    .importzp databank
    
    ; switch to new bank
    sta databank

    ; this setup for fme-7
    ldx #$A
    stx $8000 ; fme-7 bank select for PRG bank $A000

    sta $A000 ; fme-7 bank set to databank
    
    rts
.endproc ; _select_data_bank
