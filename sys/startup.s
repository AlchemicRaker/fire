
PPU_CTRL	=$2000
PPU_MASK	=$2001
PPU_STATUS	=$2002
DMC_FREQ	=$4010
DMC_IRQ     =$4015
APU_IRQ     =$4017

PPU_SCROLL  =$2005
PPU_ADDR    =$2006
PPU_DATA    =$2007

.importzp ptrf

.segment "STARTUP_FIRE_1"
.proc startup_handler
.export _exit, startup_handler
_exit:
    sei         ; disable interrupts
    cld         ; turn off decimal mode
    ldx #$ff    ; initialize stack
    txs

init_dmc_state:
    stx DMC_FREQ    ; Disable DMC IRQ
    bit DMC_IRQ     ; Acknowledge DMC IRQ
init_apu:
    lda #$40
    sta APU_IRQ     ; Disable APU Frame IRQ
    lda #$0F
    sta DMC_IRQ     ; Disable DMC playback, initialize other channels

init_clear_ppu_state:
    lda #$00
    sta PPU_CTRL    ; Disable NMI
    sta PPU_MASK    ; Disable rendering

    ; clear out the zero page and asm stack
    lda #$00
    ldy #$00
clear_zp_stack_loop:
    dey
    sta $0000,y
    sta $0100,y
    bne clear_zp_stack_loop

    

.ifdef C_SUPPORT
.import zerobss,copydata
    .import __STACK_START__,__STACKSIZE__,_main
    .importzp sp
    ; init for C:
    ; zero out BSS and copy values into RAM
    jsr	zerobss
    jsr	copydata
    ; set the stackpointer to the start of the stack
    lda #<(__STACK_START__+__STACKSIZE__)
    sta	sp
    lda	#>(__STACK_START__+__STACKSIZE__)
    sta	sp+1
.endif

.ifdef BANK_SUPPORT
.importzp prgbank
    lda #$00
    sta prgbank
.endif

    bit PPU_STATUS  ; clear vblank NMI

vblank1_loop:
    bit PPU_STATUS
    bpl vblank1_loop

vblank2_loop:
    bit PPU_STATUS
    bpl vblank2_loop

    ;; after PPU is warmed up
    ; clear PPU nametable (background tilemap) to 0
    lda #>$2000
    sta PPU_ADDR
    lda #<$2000
    sta PPU_ADDR
    
    clc
    lda #$00 ; tile number
    ldy #$00
@loop_row:
    ldx #$00
@loop_column:
    sta PPU_DATA
    
    inx
    cpx #$20
    bne @loop_column

    iny
    cpy #$1E
    bne @loop_row

    ; HELLO
    
    ; lda #>$2021
    ; sta PPU_ADDR
    ; lda #<$2021
    ; sta PPU_ADDR
    ; lda #$05
    ; sta PPU_DATA
    ; lda #$06
    ; sta PPU_DATA
    ; lda #$07
    ; sta PPU_DATA
    ; sta PPU_DATA
    ; lda #$08
    ; sta PPU_DATA

    ; load BG palette
    lda #$3F
    sta PPU_ADDR
    lda #$00
    sta PPU_ADDR

    lda #$3F
    sta PPU_DATA
    lda #$01
    sta PPU_DATA
    lda #$27
    sta PPU_DATA
    lda #$37
    sta PPU_DATA

    lda #$3F
    sta PPU_DATA ; unused
    lda #$01
    sta PPU_DATA
    lda #$1B
    sta PPU_DATA
    lda #$2B
    sta PPU_DATA

    lda #$3F
    sta PPU_DATA ; unused
    lda #$20
    sta PPU_DATA
    lda #$10
    sta PPU_DATA
    lda #$01
    sta PPU_DATA

    lda #$3F
    sta PPU_DATA ; unused
    lda #$20
    sta PPU_DATA
    lda #$10
    sta PPU_DATA
    lda #$01
    sta PPU_DATA

    ; load sprite palettes
    

    lda #$3F
    sta PPU_DATA ; unused
    lda #$20
    sta PPU_DATA
    lda #$10
    sta PPU_DATA
    lda #$01
    sta PPU_DATA

    lda #$3F
    sta PPU_DATA ; unused
    lda #$10
    sta PPU_DATA
    lda #$10
    sta PPU_DATA
    lda #$01
    sta PPU_DATA

    lda #$3F
    sta PPU_DATA ; unused
    lda #$01
    sta PPU_DATA
    lda #$10
    sta PPU_DATA
    lda #$01
    sta PPU_DATA

    lda #$3F
    sta PPU_DATA ; unused
    lda #$2B
    sta PPU_DATA
    lda #$10
    sta PPU_DATA
    lda #$01
    sta PPU_DATA

    ; prime the sprites to be below the screen
    lda #$00
    sta ptrf
    lda #$02
    sta ptrf+1

    clc 
    ldy #$00
    ; ldx #$FF

clear_sprites_loop:
    lda #$FF
    sta (ptrf),Y
    tya 
    adc #$04
    tay 
    bcc clear_sprites_loop

    ; TODO: enable NMI

    ; enable background & restore scroll
    bit PPU_STATUS
    lda #$00
    sta PPU_SCROLL
    sta PPU_SCROLL
    lda #%00000000
    sta PPU_CTRL
    lda #%00001110
    sta PPU_MASK


.segment "STARTUP_FIRE_2"
    cli
.ifdef C_SUPPORT
    jmp _main
; -------------
.else
    jmp main
.proc main ; stubbed main loop for non-c projects
loop:
    jmp loop
.endproc

.endif
.endproc
