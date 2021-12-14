
.ifdef BHOP
    ; include song

.segment "DPCM_12"
bhop_music_data:
.export bhop_music_data
.include "bhop_song/drumstar1b.asm"
    
.endif ; .ifdef BHOP
