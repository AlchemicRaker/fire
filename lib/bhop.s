
.include "bhop/bhop.s"

.import bhop_music_data, bhop_init, bhop_play
MUSIC_BASE = bhop_music_data

.segment "STARTUP_LIB"
    ; bhop init
    lda #0 ; song index
    jsr bhop_init

.segment "NMI_AUDIO_LIB"
    jsr bhop_play
