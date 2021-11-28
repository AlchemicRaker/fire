.ifdef LIB_FAMISTUDIO
.segment "PRG_FIXED"
song_journey_to_silius:
.export song_journey_to_silius
.export _song_journey_to_silius = song_journey_to_silius
.include "famistudio_song/song_journey_to_silius_ca65.s"

.segment "SAMPLE_BANK_3"
.incbin "famistudio_song/song_journey_to_silius_ca65.dmc"

sfx_data:
.include "famistudio_song/sfx_ca65.s"
.endif