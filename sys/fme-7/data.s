
.ifdef C_SUPPORT

.proc push_data_bank
    .export push_data_bank, _push_data_bank = push_data_bank
    .import pusha
    .importzp databank, fme7_command_shadow

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
    sta fme7_command_shadow
    sta $8000 ; fme-7 bank select for PRG bank $A000

    stx $A000 ; fme-7 bank set to databank
    
    rts
.endproc ; _push_data_bank

.proc pop_data_bank
    .export pop_data_bank, _pop_data_bank = pop_data_bank
    .import popa
    .importzp databank, fme7_command_shadow

    jsr popa
    sta databank

    ; this setup for fme-7
    ldx #$A
    stx fme7_command_shadow
    stx $8000 ; fme-7 bank select for PRG bank $A000

    sta $A000 ; fme-7 bank set to databank
    
    rts
.endproc ; _pop_data_bank
.endif

.proc select_data_bank
    .export select_data_bank, _select_data_bank = select_data_bank
    .importzp databank, fme7_command_shadow
    
    ; switch to new bank
    sta databank

    ; this setup for fme-7
    ldx #$A
    stx fme7_command_shadow
    stx $8000 ; fme-7 bank select for PRG bank $A000

    sta $A000 ; fme-7 bank set to databank
    
    rts
.endproc ; _select_data_bank

