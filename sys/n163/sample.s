.proc select_sample_bank
    .export select_sample_bank, _select_sample_bank = select_sample_bank
    .importzp samplebank
    
    ; switch to new bank
    sta samplebank

    sta $F000 ; n163 bank set to samplebank
    
    rts
.endproc ; _select_sample_bank
