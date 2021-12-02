.segment "ZEROPAGE"
.exportzp irq_ss_counter, irq_ss_enable
.exportzp _irq_ss_counter = irq_ss_counter, _irq_ss_enable = irq_ss_enable
irq_ss_counter: .res 1
irq_ss_enable: .res 1

.segment "NMI_TIMING"

    lda #$00
    inc $F001 ; pause IRQ

    lda irq_ss_counter ;irq_ss_counter
    sta $F000 ; set latch

    lda irq_ss_enable
    sta $F001 ; enable irq for next 


.segment "IRQ_LIB"
    sta irq_ss_save_a
.repeat 14
    nop
.endrepeat
    lda irq_ss_scroll_x
    sta $2005 ; PPU_SCROLL
    lda irq_ss_scroll_y
    sta $2005 ; PPU_SCROLL
    lda #$00
    sta $F001 ; next IRQ never reachable
    lda irq_ss_save_a
