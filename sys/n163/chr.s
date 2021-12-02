; banks measured in 1k increments

.segment "PRG_FIXED"


.proc select_chr_8k_0000
.export select_chr_8k_0000
.export _select_chr_8k_0000 = select_chr_8k_0000

    asl ; << 1
    asl ; << 2
    asl ; << 3
    clc

    sta $8000
    adc #$01
    sta $8800
    adc #$01
    sta $9000
    adc #$01
    sta $9800
    
    adc #$01
    sta $A000
    adc #$01
    sta $A800
    adc #$01
    sta $B000
    adc #$01
    sta $B800

    rts
.endproc


.proc select_chr_4k_0000
.export select_chr_4k_0000
.export _select_chr_4k_0000 = select_chr_4k_0000

    asl ; << 1
    asl ; << 2
    clc

    sta $8000
    adc #$01
    sta $8800
    adc #$01
    sta $9000
    adc #$01
    sta $9800

    rts
.endproc


.proc select_chr_4k_1000
.export select_chr_4k_1000
.export _select_chr_4k_1000 = select_chr_4k_1000

    asl ; << 1
    asl ; << 2
    clc
    
    sta $A000
    adc #$01
    sta $A800
    adc #$01
    sta $B000
    adc #$01
    sta $B800

    rts
.endproc

.proc select_chr_2k_0000
.export select_chr_2k_0000
.export _select_chr_2k_0000 = select_chr_2k_0000

    asl ; << 1
    clc

    sta $8000
    adc #$01
    sta $8800

    rts
.endproc

.proc select_chr_2k_0800
.export select_chr_2k_0800
.export _select_chr_2k_0800 = select_chr_2k_0800

    asl ; << 1
    clc

    sta $9000
    adc #$01
    sta $9800
    
    rts
.endproc

.proc select_chr_2k_1000
.export select_chr_2k_1000
.export _select_chr_2k_1000 = select_chr_2k_1000

    asl ; << 1
    clc

    sta $A000
    adc #$01
    sta $A800

    rts
.endproc

.proc select_chr_2k_1800
.export select_chr_2k_1800
.export _select_chr_2k_1800 = select_chr_2k_1800

    asl ; << 1
    clc

    sta $B000
    adc #$01
    sta $B800

    rts
.endproc

.proc select_chr_1k_0000
.export select_chr_1k_0000
.export _select_chr_1k_0000 = select_chr_1k_0000
    sta $8000
    rts
.endproc

.proc select_chr_1k_0400
.export select_chr_1k_0400
.export _select_chr_1k_0400 = select_chr_1k_0400
    sta $8800
    rts
.endproc

.proc select_chr_1k_0800
.export select_chr_1k_0800
.export _select_chr_1k_0800 = select_chr_1k_0800
    sta $9000
    rts
.endproc

.proc select_chr_1k_0C00
.export select_chr_1k_0C00
.export _select_chr_1k_0C00 = select_chr_1k_0C00
    sta $9800
    rts
.endproc

.proc select_chr_1k_1000
.export select_chr_1k_1000
.export _select_chr_1k_1000 = select_chr_1k_1000
    sta $A000
    rts
.endproc

.proc select_chr_1k_1400
.export select_chr_1k_1400
.export _select_chr_1k_1400 = select_chr_1k_1400
    sta $A800
    rts
.endproc

.proc select_chr_1k_1800
.export select_chr_1k_1800
.export _select_chr_1k_1800 = select_chr_1k_1800
    sta $B000
    rts
.endproc

.proc select_chr_1k_1C00
.export select_chr_1k_1C00
.export _select_chr_1k_1C00 = select_chr_1k_1C00
    sta $B800
    rts
.endproc



