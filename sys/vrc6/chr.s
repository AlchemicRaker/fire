; banks measured in 1k increments

.segment "PRG_FIXED"


.proc select_chr_8k_0000
.export select_chr_8k_0000
.export _select_chr_8k_0000 = select_chr_8k_0000

    asl ; << 1
    asl ; << 2
    asl ; << 3
    clc

    sta $D000
    adc #$01
    sta $D001
    adc #$01
    sta $D002
    adc #$01
    sta $D003
    
    adc #$01
    sta $E000
    adc #$01
    sta $E001
    adc #$01
    sta $E002
    adc #$01
    sta $E003

    rts
.endproc


.proc select_chr_4k_0000
.export select_chr_4k_0000
.export _select_chr_4k_0000 = select_chr_4k_0000

    asl ; << 1
    asl ; << 2
    clc

    sta $D000
    adc #$01
    sta $D001
    adc #$01
    sta $D002
    adc #$01
    sta $D003

    rts
.endproc


.proc select_chr_4k_1000
.export select_chr_4k_1000
.export _select_chr_4k_1000 = select_chr_4k_1000

    asl ; << 1
    asl ; << 2
    clc

    sta $E000
    adc #$01
    sta $E001
    adc #$01
    sta $E002
    adc #$01
    sta $E003

    rts
.endproc

.proc select_chr_2k_0000
.export select_chr_2k_0000
.export _select_chr_2k_0000 = select_chr_2k_0000

    asl ; << 1
    clc

    sta $D000
    adc #$01
    sta $D001

    rts
.endproc

.proc select_chr_2k_0800
.export select_chr_2k_0800
.export _select_chr_2k_0800 = select_chr_2k_0800

    asl ; << 1
    clc

    sta $D002
    adc #$01
    sta $D003
    
    rts
.endproc

.proc select_chr_2k_1000
.export select_chr_2k_1000
.export _select_chr_2k_1000 = select_chr_2k_1000

    asl ; << 1
    clc

    sta $E000
    adc #$01
    sta $E001

    rts
.endproc

.proc select_chr_2k_1800
.export select_chr_2k_1800
.export _select_chr_2k_1800 = select_chr_2k_1800

    asl ; << 1
    clc

    sta $E002
    adc #$01
    sta $E003

    rts
.endproc

.proc select_chr_1k_0000
.export select_chr_1k_0000
.export _select_chr_1k_0000 = select_chr_1k_0000
    sta $D000
    rts
.endproc

.proc select_chr_1k_0400
.export select_chr_1k_0400
.export _select_chr_1k_0400 = select_chr_1k_0400
    sta $D001
    rts
.endproc

.proc select_chr_1k_0800
.export select_chr_1k_0800
.export _select_chr_1k_0800 = select_chr_1k_0800
    sta $D002
    rts
.endproc

.proc select_chr_1k_0C00
.export select_chr_1k_0C00
.export _select_chr_1k_0C00 = select_chr_1k_0C00
    sta $D003
    rts
.endproc

.proc select_chr_1k_1000
.export select_chr_1k_1000
.export _select_chr_1k_1000 = select_chr_1k_1000
    sta $E000
    rts
.endproc

.proc select_chr_1k_1400
.export select_chr_1k_1400
.export _select_chr_1k_1400 = select_chr_1k_1400
    sta $E001
    rts
.endproc

.proc select_chr_1k_1800
.export select_chr_1k_1800
.export _select_chr_1k_1800 = select_chr_1k_1800
    sta $E002
    rts
.endproc

.proc select_chr_1k_1C00
.export select_chr_1k_1C00
.export _select_chr_1k_1C00 = select_chr_1k_1C00
    sta $E003
    rts
.endproc



