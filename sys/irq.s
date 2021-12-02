
.segment "IRQ_FIRE_1"
.export irq_handler
irq_handler: ; a reference for the vector

; .segment "IRQ_LIB"
; .segment "IRQ_GAME"

.segment "IRQ_FIRE_2"
    rti ; it's not the job of IRQ_LIB or IRQ_GAME to call `rti`
