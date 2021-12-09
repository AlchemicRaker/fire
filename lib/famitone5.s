
.include "famitone5/famitone5.s"
; .import FamiToneInit, FamiToneMusicPlay, FamiToneUpdate

.ifdef C_SUPPORT
; pretty C wrappers for the 3 calls

.segment "PRG_FIXED"

;------------------------------------------------------------------------------
; reset APU, initialize FamiTone
; in: A   0 for PAL, not 0 for NTSC
;     X,Y pointer to music data
;------------------------------------------------------------------------------
   
.proc _FamiToneInit ; void FamiToneInit(unsigned char platform, void* music_data);
.export _FamiToneInit
.import popa
.importzp ptrf ; fire's scratch zp

    sta ptrf ; goes to xy later
    stx ptrf+1
    
    jsr popa ; load a

    ldx ptrf
    ldy ptrf+1

    jmp FamiToneInit

.endproc ; .proc _FamiToneInit

;------------------------------------------------------------------------------
; play music
; in: A number of subsong
;------------------------------------------------------------------------------

; void FamiToneMusicPlay(char subsong);
.export _FamiToneMusicPlay = FamiToneMusicPlay



;; register FamiToneUpdate to run in every NMI

.segment "NMI_AUDIO_LIB"
    jsr FamiToneUpdate

.endif ; .ifdef C_SUPPORT
