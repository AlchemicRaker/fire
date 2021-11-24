.proc _select_sample_bank
    .export _select_sample_bank
    .importzp samplebank

    sta $9000 ; vrc6 bank set to samplebank
    
    rts
.endproc ; _select_sample_bank
