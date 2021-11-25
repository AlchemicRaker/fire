.proc _select_sample_bank
    .export _select_sample_bank
    .importzp samplebank
    
    ; switch to new bank
    sta samplebank

    ; this setup for fme-7
    ldx #$B
    stx $8000 ; fme-7 bank select for PRG bank $C000

    sta $A000 ; fme-7 bank set to samplebank
    
    rts
.endproc ; _select_sample_bank