.ifndef FIRE_INC
.define FIRE_INC

.ifdef BANK_SUPPORT


.macro farjsr target
.scope
    .importzp ptrf, fara, farx
    .import farjsr_resolve

    sta fara ; preserve ax registers (restored in farjsr_resolve)
    lda #<.bank(target)
    sta farx

    ; set up jump target for farjsr_resolve
    lda #<(target)
    sta ptrf
    lda #>(target)
    sta ptrf+1

    jsr farjsr_resolve

.endscope
.endmacro


.macro farjmp target
.scope
    .importzp prgbank, ptrf, fara
    .import farjmp_resolve

    sta fara ; preserve a register (restored in farjmp_resolve)
    
    ; set up jump target for farjmp_resolve
    lda #<(target)
    sta ptrf
    lda #>(target)
    sta ptrf+1

    lda #<.bank(target)
    sta prgbank

    jmp farjmp_resolve
.endscope
.endmacro

.endif ; .ifdef BANK_SUPPORT

.endif ; .ifndef FIRE_INC