
.segment "PRG_FIXED"
.export nmi_handler
.proc nmi_handler ; vblank
    rti
.endproc