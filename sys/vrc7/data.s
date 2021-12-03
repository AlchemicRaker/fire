
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

    stx $8010 ; vrc6 bank set to databank
    
    rts
.endproc ; _push_data_bank

.proc pop_data_bank
    .export pop_data_bank, _pop_data_bank = pop_data_bank
    .import popa
    .importzp databank

    jsr popa
    sta databank

    sta $8010 ; vrc6 bank set to databank
    
    rts
.endproc ; _push_data_bank
.endif

.proc select_data_bank
    .export select_data_bank, _select_data_bank = select_data_bank
    .importzp databank

    sta $8010 ; vrc6 bank set to databank
    
    rts
.endproc ; _select_data_bank
