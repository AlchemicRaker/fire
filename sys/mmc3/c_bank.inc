.proc _farcall
    .export _farcall
    .import pusha, popa, callptr4
    .importzp prgbank, tmp4

    ;; store the current bank on the stack, switch to new bank

    ; push the current prg bank on the stack
    lda prgbank
    jsr pusha

    ; this setup for mmc3
    lda #(%00000110 | MMC3_CHR_A12)
    sta $8002 ; mmc3 bank select for PRG bank $8000
    
    ; select the new bank
    lda tmp4
    sta prgbank
    sta $8001 ; mmc3 bank set to prgbank

    ;; jump to wrapped call
    jsr callptr4

    ;; restore the previous prg bank and pop it  

    ; this setup for mmc3      
    lda #(%00000110 | MMC3_CHR_A12)
    sta $8002 ; mmc3 bank select for PRG bank $8000

    jsr popa
    sta prgbank
    sta $8001

    rts
.endproc ; _farcall
