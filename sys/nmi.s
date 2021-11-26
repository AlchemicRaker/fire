
.segment "ZEROPAGE"
irq_save_a: .res 1
irq_save_x: .res 1
irq_save_y: .res 1
_nmi_oam_enable: .res 1
.export _nmi_oam_enable

.segment "NMI_HANDLE_1"
.export nmi_handler
.proc nmi_handler ; vblank
    sta irq_save_a
    stx irq_save_x
    sty irq_save_y
    php ; save status registers
    ; registers preserved

    lda #$00
    cmp _nmi_oam_enable
    beq after_oam ; if _nmi_oam_enable == $00, then don't copy OAM. normal "enable" is $02...
    sta $2003 ; set OAM ADDR = 0
    lda _nmi_oam_enable ; normal enable is $02, to copy $0200-$02FF
    sta $4014 ; OAM DMA happens now!
after_oam:

.segment "NMI_HANDLE_2"
    lda #$00
    sta _nmi_oam_enable
    ; restore registers and resume execution
    lda irq_save_a
    ldx irq_save_x
    ldy irq_save_y
    plp ; restore status registers
    rti
.endproc