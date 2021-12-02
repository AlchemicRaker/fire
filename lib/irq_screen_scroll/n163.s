.segment "ZEROPAGE"
.exportzp irq_ss_counter, irq_ss_enable
.exportzp _irq_ss_counter = irq_ss_counter, _irq_ss_enable = irq_ss_enable
irq_ss_counter: .res 2
irq_ss_enable: .res 1

.segment "NMI_TIMING"
    lda irq_ss_counter
    sta $5000 ; set low byte
    
    lda irq_ss_counter+1
    sta $5800 ; set high byte

nothing_to_do:

.segment "IRQ_LIB"
    sta irq_ss_save_a
    lda irq_ss_scroll_x
    sta $2005 ; PPU_SCROLL
    lda irq_ss_scroll_y
    sta $2005 ; PPU_SCROLL
    lda #$80
    sta $5000
    lda #$80
    sta $5800 ; set counter past IRQ trigger
    lda irq_ss_save_a
