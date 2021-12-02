.proc _farcall
    .export _farcall
    .import pusha, popa, callptr4
    .importzp prgbank, tmp4, fme7_command_shadow

    ;; store the current bank on the stack, switch to new bank

    ; push the current prg bank on the stack
    lda prgbank
    jsr pusha

    ; this setup for fme-7
    lda #$9
    sta fme7_command_shadow
    sta $8000 ; fme-7 bank select for PRG bank $8000
    
    ; select the new bank
    lda tmp4
    sta prgbank
    sta $A000 ; fme-7 bank set to prgbank

    ;; jump to wrapped call
    jsr callptr4

    ;; restore the previous prg bank and pop it  

    ; this setup for fme-7      
    lda #$9
    sta fme7_command_shadow
    sta $8000 ; fme-7 bank select for PRG bank $8000

    jsr popa
    sta prgbank
    sta $A000

    rts
.endproc ; _farcall
