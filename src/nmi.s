.ifdef LIB_FAMISTUDIO
.segment "NMI_HANDLE_CUSTOM"
.import famistudio_update
    jsr famistudio_update
.endif