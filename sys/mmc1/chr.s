; banks measured in 4k increments

.segment "PRG_FIXED"
.proc select_chr_8k_0000
.export select_chr_8k_0000
.export _select_chr_8k_0000 = select_chr_8k_0000
    tax
    sta $A000 ; set ppu $0000 to bank a
    lsr
    sta $A000
    lsr
    sta $A000
    lsr
    sta $A000
    lsr
    sta $A000
    
    txa
    clc
    adc #$01

    sta $C000 ; set ppu $1000 to bank a+1
    lsr
    sta $C000
    lsr
    sta $C000
    lsr
    sta $C000
    lsr
    sta $C000
    rts
.endproc ; .proc select_chr_8k_0000

.proc select_chr_4k_0000
.export select_chr_4k_0000
.export _select_chr_4k_0000 = select_chr_4k_0000
    sta $A000 ; set ppu $0000 to bank a
    lsr
    sta $A000
    lsr
    sta $A000
    lsr
    sta $A000
    lsr
    sta $A000
    rts
.endproc ; .proc select_chr_4k_0000

.proc select_chr_4k_1000
.export select_chr_4k_1000
.export _select_chr_4k_1000 = select_chr_4k_1000
    sta $C000 ; set ppu $1000 to bank a
    lsr
    sta $C000
    lsr
    sta $C000
    lsr
    sta $C000
    lsr
    sta $C000
    rts
.endproc ; .proc select_chr_4k_1000
