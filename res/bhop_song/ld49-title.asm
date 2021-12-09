; FamiTracker exported music data: ld49-title (1)
;

; Module header
	.word ft_song_list
	.word ft_instrument_list
	.word ft_sample_list
	.word ft_samples
	.byte 0 ; flags
	.word 3600 ; NTSC speed
	.word 3000 ; PAL speed

; Instrument pointer list
ft_instrument_list:
	.word ft_inst_0
	.word ft_inst_1
	.word ft_inst_2
	.word ft_inst_3
	.word ft_inst_4
	.word ft_inst_5
	.word ft_inst_6
	.word ft_inst_7

; Instruments
ft_inst_0:
	.byte 1
	.word ft_seq_2a03_85

ft_inst_1:
	.byte 1
	.word ft_seq_2a03_90

ft_inst_2:
	.byte 19
	.word ft_seq_2a03_5
	.word ft_seq_2a03_6
	.word ft_seq_2a03_9

ft_inst_3:
	.byte 3
	.word ft_seq_2a03_15
	.word ft_seq_2a03_16

ft_inst_4:
	.byte 17
	.word ft_seq_2a03_55
	.word ft_seq_2a03_24

ft_inst_5:
	.byte 3
	.word ft_seq_2a03_75
	.word ft_seq_2a03_51

ft_inst_6:
	.byte 17
	.word ft_seq_2a03_80
	.word ft_seq_2a03_39

ft_inst_7:
	.byte 17
	.word ft_seq_2a03_95
	.word ft_seq_2a03_39

; Sequences
ft_seq_2a03_5:
	.byte $0A, $FF, $00, $00, $0D, $0A, $07, $00, $00, $00, $00, $00, $00, $00
ft_seq_2a03_6:
	.byte $04, $03, $00, $01, $0B, $0C, $0D, $0E
ft_seq_2a03_9:
	.byte $01, $FF, $00, $00, $00
ft_seq_2a03_15:
	.byte $02, $FF, $00, $00, $0D, $00
ft_seq_2a03_16:
	.byte $0C, $FF, $00, $01, $0C, $09, $0A, $0A, $0A, $0B, $0B, $0B, $0C, $0C, $0D, $0D
ft_seq_2a03_24:
	.byte $01, $FF, $00, $00, $02
ft_seq_2a03_39:
	.byte $01, $FF, $00, $00, $01
ft_seq_2a03_51:
	.byte $03, $00, $00, $01, $0C, $0E, $0D
ft_seq_2a03_55:
	.byte $07, $FF, $06, $00, $0F, $0E, $0D, $0D, $0C, $0C, $05
ft_seq_2a03_75:
	.byte $07, $FF, $00, $00, $07, $0C, $0F, $00, $00, $00, $00
ft_seq_2a03_80:
	.byte $46, $FF, $00, $00, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
	.byte $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $02, $02, $02, $02, $02
	.byte $02, $02, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
	.byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
ft_seq_2a03_85:
	.byte $04, $FF, $02, $00, $0F, $0F, $0F, $00
ft_seq_2a03_90:
	.byte $05, $FF, $00, $00, $0C, $08, $05, $02, $01
ft_seq_2a03_95:
	.byte $01, $FF, $00, $00, $0F

; DPCM instrument list (pitch, sample index)
ft_sample_list:

; DPCM samples list (location, size, bank)
ft_samples:


; Song pointer list
ft_song_list:
	.word ft_song_0

; Song info
ft_song_0:
	.word ft_s0_frames
	.byte 2	; frame count
	.byte 128	; pattern length
	.byte 3	; speed
	.byte 130	; tempo
	.byte 0	; initial bank


;
; Pattern and frame data for all songs below
;

; Bank 0
ft_s0_frames:
	.word ft_s0f0
	.word ft_s0f1
ft_s0f0:
	.word ft_s0p0c0, ft_s0p0c1, ft_s0p0c2, ft_s0p0c3, ft_s0p0c4
ft_s0f1:
	.word ft_s0p1c0, ft_s0p1c1, ft_s0p0c2, ft_s0p0c3, ft_s0p0c4
; Bank 0
ft_s0p0c0:
	.byte $7F, $7F

; Bank 0
ft_s0p0c1:
	.byte $7F, $01, $E4, $F2, $22, $01, $7F, $03, $F2, $2E, $00, $7F, $02, $F2, $22, $00, $7F, $00, $F2, $2E
	.byte $01, $7F, $2D, $82, $00, $F2, $20, $7F, $F2, $21, $7F, $84, $F2, $22, $01, $7F, $03, $F2, $2E, $00
	.byte $7F, $02, $F2, $22, $00, $7F, $00, $F2, $2E, $01, $7F, $2F

; Bank 0
ft_s0p0c2:
	.byte $E0, $FC, $2E, $01, $7F, $03, $FA, $3A, $00, $7F, $02, $FA, $2E, $00, $7F, $00, $FC, $3A, $01, $7F
	.byte $2D, $82, $00, $FA, $2C, $7F, $FB, $2D, $7F, $84, $FC, $2E, $01, $7F, $03, $FA, $3A, $00, $7F, $02
	.byte $FA, $2E, $00, $7F, $00, $FC, $3A, $01, $7F, $01, $7F, $2F

; Bank 0
ft_s0p0c3:
	.byte $E3, $F9, $15, $03, $E5, $F5, $15, $01, $F5, $15, $01, $E2, $F7, $15, $03, $E5, $F5, $15, $01, $F5
	.byte $15, $01, $E3, $F9, $15, $03, $E5, $F5, $15, $01, $F5, $15, $01, $E2, $F7, $15, $03, $E5, $F5, $15
	.byte $01, $F5, $15, $01, $E3, $F9, $15, $03, $E5, $F5, $15, $01, $F5, $15, $01, $E2, $F7, $15, $03, $E5
	.byte $F5, $15, $01, $E3, $F7, $15, $01, $F9, $15, $03, $F9, $15, $01, $E5, $F5, $15, $01, $E2, $F7, $15
	.byte $03, $E5, $F5, $15, $01, $F5, $15, $01, $E3, $F9, $15, $03, $E5, $F5, $15, $01, $F5, $15, $01, $E2
	.byte $F7, $15, $03, $E5, $F5, $15, $01, $F5, $15, $01, $E3, $F9, $15, $03, $E5, $F5, $15, $01, $F5, $15
	.byte $01, $E2, $F7, $15, $03, $E5, $F5, $15, $01, $F5, $15, $01, $E3, $F9, $15, $03, $E5, $F5, $15, $01
	.byte $F5, $15, $01, $E2, $F7, $15, $03, $E5, $F5, $15, $01, $F5, $15, $01, $E3, $F9, $15, $03, $F9, $15
	.byte $01, $E5, $F5, $15, $01, $E2, $F7, $15, $03, $E5, $F5, $15, $01, $F5, $15, $01

; Bank 0
ft_s0p0c4:
	.byte $00, $7F

; Bank 0
ft_s0p1c0:
	.byte $E6, $9C, $00, $FF, $22, $03, $9C, $24, $00, $03, $9C, $44, $00, $03, $9C, $24, $00, $13, $82, $00
	.byte $E1, $9C, $00, $F2, $22, $E7, $F1, $1E, $E1, $F3, $29, $E7, $F2, $1E, $E1, $9C, $00, $F4, $2E, $E7
	.byte $9C, $24, $F2, $1E, $E1, $9C, $00, $F5, $35, $E7, $9C, $24, $F2, $1E, $E1, $9C, $00, $F6, $3A, $E7
	.byte $9C, $44, $F2, $1E, $E1, $9C, $00, $F5, $35, $E7, $9C, $44, $F1, $1E, $E1, $9C, $00, $F4, $2E, $E7
	.byte $9C, $24, $F1, $1E, $E1, $9C, $00, $F3, $29, $E7, $9C, $24, $F1, $1E, $E1, $9C, $00, $F2, $22, $84
	.byte $E6, $FC, $20, $02, $82, $03, $9C, $24, $00, $9C, $44, $00, $9C, $24, $00, $9C, $00, $FF, $22, $9C
	.byte $24, $00, $9C, $44, $00, $84, $9C, $24, $00, $13, $82, $00, $E1, $9C, $00, $F2, $22, $E7, $F1, $1E
	.byte $E1, $F3, $29, $E7, $F2, $1E, $E1, $9C, $00, $F4, $2E, $E7, $9C, $24, $F2, $1E, $E1, $9C, $00, $F5
	.byte $35, $E7, $9C, $24, $F2, $1E, $E1, $9C, $00, $F6, $3A, $E7, $9C, $44, $F2, $1E, $E1, $9C, $00, $F5
	.byte $35, $E7, $9C, $44, $F1, $1E, $E1, $9C, $00, $F4, $2E, $E7, $9C, $24, $F1, $1E, $E1, $9C, $00, $F3
	.byte $29, $E7, $9C, $24, $F1, $1E, $E1, $9C, $00, $F2, $22, $84, $E6, $FC, $20, $02, $9C, $24, $00, $03
	.byte $9C, $44, $00, $03, $9C, $24, $00, $03

; Bank 0
ft_s0p1c1:
	.byte $E6, $9C, $00, $FF, $29, $03, $9C, $24, $00, $03, $9C, $44, $00, $03, $9C, $24, $00, $13, $E7, $9C
	.byte $00, $F1, $25, $01, $F2, $00, $01, $9C, $24, $00, $03, $9C, $44, $F2, $00, $01, $F1, $00, $01, $9C
	.byte $24, $00, $03, $9C, $00, $F1, $27, $01, $F2, $00, $01, $9C, $24, $00, $03, $9C, $44, $F2, $00, $01
	.byte $F1, $00, $01, $82, $03, $9C, $24, $00, $E6, $9C, $00, $FF, $29, $9C, $24, $00, $9C, $44, $00, $84
	.byte $9C, $24, $00, $13, $E7, $9C, $00, $F1, $25, $01, $F2, $00, $01, $9C, $24, $00, $03, $9C, $44, $F2
	.byte $00, $01, $F1, $00, $01, $9C, $24, $00, $03, $9C, $00, $F1, $27, $01, $F2, $00, $01, $9C, $24, $00
	.byte $03, $9C, $44, $F2, $00, $01, $F1, $00, $01, $9C, $24, $00, $03


; DPCM samples (located at DPCM segment)
