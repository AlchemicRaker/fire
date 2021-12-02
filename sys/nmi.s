
.segment "ZEROPAGE" ; zp variables to 
irq_save_a: .res 1
irq_save_x: .res 1
irq_save_y: .res 1
nmi_oam_enable: .res 1
.export nmi_oam_enable
.export _nmi_oam_enable = nmi_oam_enable


.segment "NMI_FIRE_1" ; save registers, copy OAM (if _nmi_oam_enable is set)
.import PPU_STATUS
.proc nmi_handler ; vblank
.export nmi_handler
    sta irq_save_a
    stx irq_save_x
    sty irq_save_y
    php ; save status registers
    ; registers preserved

    lda PPU_STATUS ; prevent multiple NMIs from being triggered in a single frame

; .segment "NMI_TIMING"
; game-specific NMI implementation

.segment "NMI_FIRE_2" ; save registers, copy OAM (if _nmi_oam_enable is set)
    lda #$00
    cmp nmi_oam_enable
    beq after_oam ; if _nmi_oam_enable == $00, then don't copy OAM. normal "enable" is $02...
    sta $2003 ; set OAM ADDR = 0
    lda nmi_oam_enable ; normal enable is $02, to copy $0200-$02FF
    sta $4014 ; OAM DMA happens now!
after_oam: 

; .segment "NMI_LIB"
; library NMI implementation

; .segment "NMI_GAME"
; game-specific NMI implementation

.segment "NMI_FIRE_3" ; c hook

.ifdef C_NMI_HOOK ; call c _nmi_hook()
.import _nmi_hook
    jsr _nmi_hook
.endif ; .ifdef C_NMI_HOOK

; .segment "NMI_AUDIO_LIB"
; audio library NMI hook

.segment "NMI_FIRE_4" ; cleanup and return

    lda #$00
    sta _nmi_oam_enable
    ; restore registers and resume execution
    lda irq_save_a
    ldx irq_save_x
    ldy irq_save_y
    plp ; restore status registers
    rti
.endproc