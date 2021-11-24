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

    stx $8010 ; vrc6 bank set to databank
    
    rts
.endproc ; _push_data_bank

.proc _pop_data_bank
    .export _pop_data_bank
    .import popa
    .importzp databank

    jsr popa
    sta databank

    sta $8010 ; vrc6 bank set to databank
    
    rts
.endproc ; _push_data_bank

.proc _select_data_bank
    .export _select_data_bank
    .importzp databank

    sta $8010 ; vrc6 bank set to databank
    
    rts
.endproc ; _select_data_bank
