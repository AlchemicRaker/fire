
.segment "IRQ_LIB"
    sta irq_ss_save_a
.repeat 38
    nop
.endrepeat
    lda irq_ss_scroll_x
    sta $2005 ; PPU_SCROLL
    lda irq_ss_scroll_y
    sta $2005 ; PPU_SCROLL
    lda $5204
    lda irq_ss_save_a
