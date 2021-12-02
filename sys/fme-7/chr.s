; banks measured in 1k increments

.segment "PRG_FIXED"
.importzp fme7_command_shadow


.proc select_chr_8k_0000
.export select_chr_8k_0000
.export _select_chr_8k_0000 = select_chr_8k_0000

    asl ; << 1
    asl ; << 2
    asl ; << 3
    clc

    ldx #$00
    stx fme7_command_shadow
    stx $8000 ; CHR bank 0
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 1
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 2
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 3
    sta $A000
    
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 4
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 5
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 6
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 7
    sta $A000

    rts
.endproc


.proc select_chr_4k_0000
.export select_chr_4k_0000
.export _select_chr_4k_0000 = select_chr_4k_0000

    asl ; << 1
    asl ; << 2
    clc

    ldx #$00
    stx fme7_command_shadow
    stx $8000 ; CHR bank 0
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 1
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 2
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 3
    sta $A000

    rts
.endproc


.proc select_chr_4k_1000
.export select_chr_4k_1000
.export _select_chr_4k_1000 = select_chr_4k_1000

    asl ; << 1
    asl ; << 2
    clc
    
    ldx #$00
    stx fme7_command_shadow
    stx $8000 ; CHR bank 4
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 5
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 6
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 7
    sta $A000

    rts
.endproc

.proc select_chr_2k_0000
.export select_chr_2k_0000
.export _select_chr_2k_0000 = select_chr_2k_0000

    asl ; << 1
    clc

    ldx #$00
    stx fme7_command_shadow
    stx $8000 ; CHR bank 0
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 1
    sta $A000

    rts
.endproc

.proc select_chr_2k_0800
.export select_chr_2k_0800
.export _select_chr_2k_0800 = select_chr_2k_0800

    asl ; << 1
    clc

    ldx #$02
    stx fme7_command_shadow
    stx $8000 ; CHR bank 2
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 3
    sta $A000
    
    rts
.endproc

.proc select_chr_2k_1000
.export select_chr_2k_1000
.export _select_chr_2k_1000 = select_chr_2k_1000

    asl ; << 1
    clc

    ldx #$04
    stx fme7_command_shadow
    stx $8000 ; CHR bank 4
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 5
    sta $A000

    rts
.endproc

.proc select_chr_2k_1800
.export select_chr_2k_1800
.export _select_chr_2k_1800 = select_chr_2k_1800

    asl ; << 1
    clc

    ldx #$06
    stx fme7_command_shadow
    stx $8000 ; CHR bank 6
    sta $A000
    adc #$01
    inx
    stx fme7_command_shadow
    stx $8000 ; CHR bank 7
    sta $A000

    rts
.endproc

.proc select_chr_1k_0000
.export select_chr_1k_0000
.export _select_chr_1k_0000 = select_chr_1k_0000
    ldx #$00
    stx fme7_command_shadow
    stx $8000 ; CHR bank 0
    sta $A000
    rts
.endproc

.proc select_chr_1k_0400
.export select_chr_1k_0400
.export _select_chr_1k_0400 = select_chr_1k_0400
    ldx #$01
    stx fme7_command_shadow
    stx $8000 ; CHR bank 1
    sta $A000
    rts
.endproc

.proc select_chr_1k_0800
.export select_chr_1k_0800
.export _select_chr_1k_0800 = select_chr_1k_0800
    ldx #$02
    stx fme7_command_shadow
    stx $8000 ; CHR bank 2
    sta $A000
    rts
.endproc

.proc select_chr_1k_0C00
.export select_chr_1k_0C00
.export _select_chr_1k_0C00 = select_chr_1k_0C00
    ldx #$03
    stx fme7_command_shadow
    stx $8000 ; CHR bank 3
    sta $A000
    rts
.endproc

.proc select_chr_1k_1000
.export select_chr_1k_1000
.export _select_chr_1k_1000 = select_chr_1k_1000
    ldx #$04
    stx fme7_command_shadow
    stx $8000 ; CHR bank 4
    sta $A000
    rts
.endproc

.proc select_chr_1k_1400
.export select_chr_1k_1400
.export _select_chr_1k_1400 = select_chr_1k_1400
    ldx #$05
    stx fme7_command_shadow
    stx $8000 ; CHR bank 5
    sta $A000
    rts
.endproc

.proc select_chr_1k_1800
.export select_chr_1k_1800
.export _select_chr_1k_1800 = select_chr_1k_1800
    ldx #$06
    stx fme7_command_shadow
    stx $8000 ; CHR bank 6
    sta $A000
    rts
.endproc

.proc select_chr_1k_1C00
.export select_chr_1k_1C00
.export _select_chr_1k_1C00 = select_chr_1k_1C00
    ldx #$07
    stx fme7_command_shadow
    stx $8000 ; CHR bank 7
    sta $A000
    rts
.endproc



