
.ifdef BHOP
    ; include song

.segment "PRG_FIXED"
bhop_music_data:
.export bhop_music_data
.include "bhop_song/ld49-title.asm"
    
.endif ; .ifdef BHOP
