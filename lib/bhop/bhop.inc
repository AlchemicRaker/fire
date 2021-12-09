.ifndef BHOP_INC
BHOP_INC=1
; Configuration variables, adjust these to taste for your specific project

; To play a module, export "music.asm" from FamiTracker, and
; place it in memory here. Ensure this memory is paged in
; during bhop_init and bhop_play.
; MUSIC_BASE = $A000

.global bhop_init, bhop_play

.endif