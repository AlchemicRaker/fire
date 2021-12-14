; uncomment if you want to load joy2 as well
; READ_JOY_2 = 1



BUTTON_A      = 1 << 7
BUTTON_B      = 1 << 6
BUTTON_SELECT = 1 << 5
BUTTON_START  = 1 << 4
BUTTON_UP     = 1 << 3
BUTTON_DOWN   = 1 << 2
BUTTON_LEFT   = 1 << 1
BUTTON_RIGHT  = 1 << 0
.export BUTTON_A, BUTTON_B, BUTTON_SELECT, BUTTON_START, BUTTON_UP, BUTTON_DOWN, BUTTON_LEFT, BUTTON_RIGHT

.import IO_JOY1, IO_JOY2

.segment "ZEROPAGE"
JOY1_HELD: .res 1
JOY1_LAST: .res 1
JOY1_PRESSED: .res 1
JOY1_RELEASED: .res 1
.exportzp JOY1_HELD
.exportzp _JOY1_HELD = JOY1_HELD
.exportzp JOY1_LAST, JOY1_PRESSED, JOY1_RELEASED
.exportzp _JOY1_LAST = JOY1_LAST, _JOY1_PRESSED = JOY1_PRESSED, _JOY1_RELEASED = JOY1_RELEASED

.ifdef READ_JOY_2
JOY2_HELD: .res 1
JOY2_LAST: .res 1
JOY2_PRESSED: .res 1
JOY2_RELEASED: .res 1
.exportzp JOY2_HELD
.exportzp _JOY2_HELD = JOY2_HELD
.exportzp JOY2_LAST, JOY2_PRESSED, JOY2_RELEASED
.exportzp _JOY2_LAST = JOY2_LAST, _JOY2_PRESSED = JOY2_PRESSED, _JOY2_RELEASED = JOY2_RELEASED
.endif


.segment "PRG_FIXED"
.ifndef READ_JOY_2
readjoy:
    lda #$01
    sta IO_JOY1
    sta JOY1_HELD
    lsr a          ; now A is 0
    sta IO_JOY1
loop:
    lda IO_JOY1
    lsr a	       ; bit 0 -> Carry
    rol JOY1_HELD       ; Carry -> bit 0; bit 7 -> Carry
    bcc loop
    rts
.else ; .ifndef READ_JOY_2
readjoy:
    lda #$01
    sta IO_JOY1
    sta JOY2_HELD        ; player 2's buttons double as a ring counter
    lsr a           ; now A is 0
    sta IO_JOY1
loop:
    lda IO_JOY1
    and #%00000011  ; ignore bits other than controller
    cmp #$01        ; Set carry if and only if nonzero
    rol JOY1_HELD        ; Carry -> bit 0; bit 7 -> Carry
    lda IO_JOY2     ; Repeat
    and #%00000011
    cmp #$01
    rol JOY2_HELD        ; Carry -> bit 0; bit 7 -> Carry
    bcc loop
    rts
.endif ; .ifdef READ_JOY_2

.ifndef READ_JOY_2
readjoy_safe:
    jsr readjoy
reread:
    lda JOY1_HELD
    pha
    jsr readjoy
    pla
    cmp JOY1_HELD
    bne reread
    rts
.else ; .ifndef READ_JOY_2
readjoy_safe:
    jsr readjoy
reread1:
    lda JOY1_HELD
    pha
    lda JOY2_HELD
    pha
    jsr readjoy
    pla
    cmp JOY2_HELD
    bne reread2
    pla
    cmp JOY1_HELD
    bne reread1
    rts
reread2:
    pla ; get the other joy data off the stack before retrying
    jmp reread1
.endif ; .ifndef READ_JOY_2
    


.segment "NMI_LIB"
.scope nmi_poll_joy
    lda JOY1_HELD
    sta JOY1_LAST

.ifdef READ_JOY_2
    lda JOY1_HELD
    sta JOY2_LAST
.endif ; .ifdef READ_JOY_2

    jsr readjoy_safe

    lda JOY1_LAST
    eor JOY1_HELD
    and JOY1_HELD
    sta JOY1_PRESSED
    lda JOY1_LAST
    eor JOY1_HELD
    and JOY1_LAST
    sta JOY1_RELEASED
    
.ifdef READ_JOY_2
    lda JOY2_LAST
    eor JOY2_HELD
    and JOY2_HELD
    sta JOY2_PRESSED
    lda JOY2_LAST
    eor JOY2_HELD
    and JOY2_LAST
    sta JOY2_RELEASED
.endif ; .ifdef READ_JOY_2
.endscope ; .scope nmi_poll_joy


.segment "PRG_FIXED"
.proc poll_joy
.export poll_joy
.export _poll_joy = poll_joy
    lda JOY1_HELD
    sta JOY1_LAST

.ifdef READ_JOY_2
    lda JOY2_HELD
    sta JOY2_LAST
.endif ; .ifdef READ_JOY_2

    jsr readjoy_safe

    lda JOY1_LAST
    eor JOY1_HELD
    and JOY1_HELD
    sta JOY1_PRESSED
    lda JOY1_LAST
    eor JOY1_HELD
    and JOY1_LAST
    sta JOY1_RELEASED
    
.ifdef READ_JOY_2
    lda JOY2_LAST
    eor JOY2_HELD
    and JOY2_HELD
    sta JOY2_PRESSED
    lda JOY2_LAST
    eor JOY2_HELD
    and JOY2_LAST
    sta JOY2_RELEASED
.endif ; .ifdef READ_JOY_2
    rts
.endproc ; .proc poll_joy

