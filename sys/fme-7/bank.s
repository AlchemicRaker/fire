
.ifdef C_SUPPORT

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
.endif ; .ifdef C_SUPPORT


.proc farjsr_resolve ;receives a configured zp (ptrf) and a bank in "X"
.export farjsr_resolve
    .importzp prgbank, ptrf, fara, farx, fme7_command_shadow

    ; push the current prg bank on the stack
    lda prgbank
    pha

    ; this setup for fme-7
    lda #$9
    sta fme7_command_shadow
    sta $8000 ; fme-7 bank select for PRG bank $8000

    ; switch to target bank
    lda farx
    sta prgbank
    sta $A000 ; fme-7 bank set to prgbank

    lda fara ; restore ax registers (preserved in farjsr)

    jsr farjsr_resolve_2 ; sets a return point into the stack

    sta fara ; restore a register

    ; this setup for fme-7
    lda #$9
    sta fme7_command_shadow
    sta $8000 ; fme-7 bank select for PRG bank $8000

    ; restore previous bank
    pla
    sta prgbank
    sta $A000 ; fme-7 bank set to prgbank

    lda fara ; restore a register

    rts
.endproc

.proc farjsr_resolve_2   ; jumps to the farjsr target.
.export farjsr_resolve_2 ; target will jsr back into farjsr_resolve where this was called from
    .importzp ptrf

    jmp (ptrf)
.endproc

.proc farjmp_resolve   ;receives a configured zp (ptrf) and a bank in "A"
.export farjmp_resolve 
    .importzp ptrf, prgbank, fara, fme7_command_shadow

    ; this setup for fme-7
    lda #$9
    sta fme7_command_shadow
    sta $8000 ; fme-7 bank select for PRG bank $8000

    ; switch to target bank
    lda prgbank
    sta $A000 ; fme-7 bank set to prgbank

    lda fara

    jmp (ptrf)
.endproc
