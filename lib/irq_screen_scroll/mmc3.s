.segment "ZEROPAGE"
.exportzp irq_ss_counter
.exportzp _irq_ss_counter = irq_ss_counter
irq_ss_counter: .res 1

.segment "NMI_HANDLE_LIB"
    lda irq_ss_counter
    cmp #$00
    beq nothing_to_do
    sta $C000 ; IRQ latch
    sta $C001 ; IRQ reload
    sta $E001 ; IRQ enable
nothing_to_do:

.segment "IRQ_HANDLE_LIB"
    sta irq_ss_save_a
.repeat 53
    nop
.endrepeat
    lda irq_ss_scroll_x
    sta $2005 ; PPU_SCROLL
    lda irq_ss_scroll_y
    sta $2005 ; PPU_SCROLL
    lda irq_ss_save_a
    sta $E000; IRQ disable