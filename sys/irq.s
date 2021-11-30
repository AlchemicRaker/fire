
.segment "IRQ_HANDLE_1"
.export irq_handler
irq_handler: ; a reference for the vector

; .segment "IRQ_HANDLE_LIB"
; .segment "IRQ_HANDLE_CUSTOM"

.segment "IRQ_HANDLE_2"
    rti ; it's not the job of IRQ_HANDLE_CUSTOM to call `rti`
