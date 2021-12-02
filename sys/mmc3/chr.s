; banks measured in 1k increments
; 2k banks ignore lowest bit

.segment "PRG_FIXED"


.ifdef MMC3_1K_SPRITES

.proc select_chr_8k_0000
.export select_chr_8k_0000
.export _select_chr_8k_0000 = select_chr_8k_0000

    asl ; << 1
    asl ; << 2
    asl ; << 3

    ldx #(%00000000 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0000
    ; lda #$00
    sta $8001
    ldx #(%00000001 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0800
    ; lda #$02
    clc
    adc #$02 ; increment by 2
    sta $8001
    
    ldx #(%00000010 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1000
    ; lda #$04
    clc
    adc #$02
    sta $8001
    ldx #(%00000011 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1400
    ; lda #$05
    clc
    adc #$01
    sta $8001
    ldx #(%00000100 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1800
    ; lda #$06
    clc
    adc #$01
    sta $8001
    ldx #(%00000101 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1C00
    ; lda #$07
    clc
    adc #$01
    sta $8001

    rts
.endproc ; .proc select_chr_8k_0000

.proc select_chr_4k_0000
.export select_chr_4k_0000
.export _select_chr_4k_0000 = select_chr_4k_0000

    asl ; << 1
    asl ; << 2

    ldx #(%00000000 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0000
    ; lda #$00
    sta $8001
    ldx #(%00000001 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0800
    ; lda #$02
    clc
    adc #$02 ; increment by 2
    sta $8001

    rts
.endproc ; .proc select_chr_4k_0000


.proc select_chr_4k_1000
.export select_chr_4k_1000
.export _select_chr_4k_1000 = select_chr_4k_1000

    asl ; << 1
    asl ; << 2

    ldx #(%00000010 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1000
    ; lda #$04
    sta $8001
    ldx #(%00000011 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1400
    ; lda #$05
    clc
    adc #$01
    sta $8001
    ldx #(%00000100 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1800
    ; lda #$06
    clc
    adc #$01
    sta $8001
    ldx #(%00000101 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1C00
    ; lda #$07
    clc
    adc #$01
    sta $8001

    rts
.endproc ; .proc select_chr_4k_1000

.proc select_chr_2k_0000
.export select_chr_2k_0000
.export _select_chr_2k_0000 = select_chr_2k_0000

    asl ; << 1

    ldx #(%00000000 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0000
    ; lda #$00
    sta $8001

    rts
.endproc ; .proc select_chr_2k_0000

.proc select_chr_2k_0800
.export select_chr_2k_0800
.export _select_chr_2k_0800 = select_chr_2k_0800

    asl ; << 1

    ldx #(%00000001 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0800
    ; lda #$02
    sta $8001

    rts
.endproc ; .proc select_chr_2k_0800

.proc select_chr_2k_1000
.export select_chr_2k_1000
.export _select_chr_2k_1000 = select_chr_2k_1000

    asl ; << 1

    ldx #(%00000010 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1000
    ; lda #$04
    sta $8001
    ldx #(%00000011 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1400
    ; lda #$05
    clc
    adc #$01
    sta $8001

    rts
.endproc ; .proc select_chr_2k_1000

.proc select_chr_2k_1800
.export select_chr_2k_1800
.export _select_chr_2k_1800 = select_chr_2k_1800

    asl ; << 1

    ldx #(%00000100 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1000
    ; lda #$04
    sta $8001
    ldx #(%00000101 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1400
    ; lda #$05
    clc
    adc #$01
    sta $8001

    rts
.endproc ; .proc select_chr_2k_1800

.proc select_chr_1k_1000
.export select_chr_1k_1000
.export _select_chr_1k_1000 = select_chr_1k_1000

    ldx #(%00000010 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1000
    sta $8001

    rts
.endproc ; .proc select_chr_1k_1000

.proc select_chr_1k_1400
.export select_chr_1k_1400
.export _select_chr_1k_1400 = select_chr_1k_1400

    ldx #(%00000011 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1400
    sta $8001

    rts
.endproc ; .proc select_chr_1k_1400

.proc select_chr_1k_1800
.export select_chr_1k_1800
.export _select_chr_1k_1800 = select_chr_1k_1800

    ldx #(%00000100 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1800
    sta $8001

    rts
.endproc ; .proc select_chr_1k_1800

.proc select_chr_1k_1C00
.export select_chr_1k_1C00
.export _select_chr_1k_1C00 = select_chr_1k_1C00

    ldx #(%00000101 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1C00
    sta $8001

    rts
.endproc ; .proc select_chr_1k_1C00

.endif ; .ifdef MMC3_1K_SPRITES


.ifdef MMC3_1K_BACKGROUNDS

.proc select_chr_8k_0000
.export select_chr_8k_0000
.export _select_chr_8k_0000 = select_chr_8k_0000

    asl ; << 1
    asl ; << 2
    asl ; << 3
    
    ldx #(%00000010 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0000
    sta $8001
    ldx #(%00000011 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0400
    clc
    adc #$01
    sta $8001
    ldx #(%00000100 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0800
    clc
    adc #$01
    sta $8001
    ldx #(%00000101 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0C00
    clc
    adc #$01
    sta $8001

    ldx #(%00000000 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1000
    clc
    adc #$02 ; increment by 2
    sta $8001
    ldx #(%00000001 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1800
    clc
    adc #$02 ; increment by 2
    sta $8001

    rts
.endproc ; .proc select_chr_8k_0000

.proc select_chr_4k_0000
.export select_chr_4k_0000
.export _select_chr_4k_0000 = select_chr_4k_0000

    asl ; << 1
    asl ; << 2
    
    ldx #(%00000010 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0000
    sta $8001
    ldx #(%00000011 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0400
    clc
    adc #$01
    sta $8001
    ldx #(%00000100 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0800
    clc
    adc #$01
    sta $8001
    ldx #(%00000101 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0C00
    clc
    adc #$01
    sta $8001

    rts
.endproc ; .proc select_chr_4k_0000


.proc select_chr_4k_1000
.export select_chr_4k_1000
.export _select_chr_4k_1000 = select_chr_4k_1000

    asl ; << 1
    asl ; << 2

    ldx #(%00000000 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1000
    sta $8001
    ldx #(%00000001 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1800
    clc
    adc #$02 ; increment by 2
    sta $8001

    rts
.endproc ; .proc select_chr_4k_1000

.proc select_chr_2k_0000 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;change below here
.export select_chr_2k_0000
.export _select_chr_2k_0000 = select_chr_2k_0000

    asl ; << 1

    ldx #(%00000010 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0000
    ; lda #$04
    sta $8001
    ldx #(%00000011 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0400
    ; lda #$05
    clc
    adc #$01
    sta $8001

    rts
.endproc ; .proc select_chr_2k_0000

.proc select_chr_2k_0800
.export select_chr_2k_0800
.export _select_chr_2k_0800 = select_chr_2k_0800

    asl ; << 1

    ldx #(%00000100 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0800
    ; lda #$04
    sta $8001
    ldx #(%00000101 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0C00
    ; lda #$05
    clc
    adc #$01
    sta $8001

    rts
.endproc ; .proc select_chr_2k_0800

.proc select_chr_2k_1000
.export select_chr_2k_1000
.export _select_chr_2k_1000 = select_chr_2k_1000

    asl ; << 1

    ldx #(%00000000 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1000
    sta $8001

    rts
.endproc ; .proc select_chr_2k_1000

.proc select_chr_2k_1800
.export select_chr_2k_1800
.export _select_chr_2k_1800 = select_chr_2k_1800

    asl ; << 1

    ldx #(%00000001 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $1800
    sta $8001

    rts
.endproc ; .proc select_chr_2k_1800

.proc select_chr_1k_0000
.export select_chr_1k_0000
.export _select_chr_1k_0000 = select_chr_1k_0000

    ldx #(%00000010 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0000
    sta $8001

    rts
.endproc ; .proc select_chr_1k_0000

.proc select_chr_1k_0400
.export select_chr_1k_0400
.export _select_chr_1k_0400 = select_chr_1k_0400

    ldx #(%00000011 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0400
    sta $8001

    rts
.endproc ; .proc select_chr_1k_0400

.proc select_chr_1k_0800
.export select_chr_1k_0800
.export _select_chr_1k_0800 = select_chr_1k_0800

    ldx #(%00000100 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0800
    sta $8001

    rts
.endproc ; .proc select_chr_1k_0800

.proc select_chr_1k_0C00
.export select_chr_1k_0C00
.export _select_chr_1k_0C00 = select_chr_1k_0C00

    ldx #(%00000101 | MMC3_CHR_A12)
    stx $8002 ; mmc3 bank select for CHR bank $0C00
    sta $8001

    rts
.endproc ; .proc select_chr_1k_0C00

.endif ; .ifdef MMC3_1K_BACKGROUNDS