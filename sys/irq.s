
.segment "PRG_FIXED"
.export irq_handler
.proc irq_handler ; depends on mapper
    rti
.endproc