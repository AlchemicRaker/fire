.segment "ZEROPAGE"
.export irq_ss_counter, irq_ss_enable
.export _irq_ss_counter = irq_ss_counter, _irq_ss_enable = irq_ss_enable
irq_ss_counter: .res 2
irq_ss_enable: .res 1

.segment "NMI_HANDLE_TIMING"
    lda #$0D 
    sta $8000
    lda #$00
    sta $A000 ; disable IRQ countdown

    lda #$0E
    sta $8000
    lda irq_ss_counter
    sta $A000 ; set low byte
    
    lda #$0F
    sta $8000
    lda irq_ss_counter+1
    sta $A000 ; set high byte

    lda #$0D 
    sta $8000
    lda irq_ss_enable
    sta $A000 ; enable/disable IRQ countdown

nothing_to_do:

.segment "IRQ_HANDLE_LIB"
    sta irq_ss_save_a
    lda irq_ss_scroll_x
    sta $2005 ; PPU_SCROLL
    lda irq_ss_scroll_y
    sta $2005 ; PPU_SCROLL
    lda #$0D 
    sta $8000
    lda #$00
    sta $A000 ; disable IRQ countdown
    lda irq_ss_save_a
