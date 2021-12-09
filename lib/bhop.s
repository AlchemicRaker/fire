.define BHOP_PRIMARY_SEGMENT PRG_FIXED

.include "bhop/bhop.s"
.include "bhop/effects.s"
.include "bhop/commands.s"

.import bhop_music_data
MUSIC_BASE = bhop_music_data

.segment "STARTUP_LIB"
    ; bhop init
    lda #0 ; song index
    jsr bhop_init

.segment "NMI_AUDIO_LIB"
    jsr bhop_play
