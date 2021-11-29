; This file for the FamiStudio Sound Engine and was generated by FamiStudio

.if FAMISTUDIO_CFG_C_BINDINGS
.export _music_data_journey_to_silius=music_data_journey_to_silius
.endif

music_data_journey_to_silius:
	.byte 1
	.word @instruments
	.word @samples-64
	.word @song0ch0,@song0ch1,@song0ch2,@song0ch3,@song0ch4
	.byte .lobyte(@tempo_env_5_mid), .hibyte(@tempo_env_5_mid), 0, 0

.export music_data_journey_to_silius
.global FAMISTUDIO_DPCM_PTR

@instruments:
	.word @env2,@env0,@env9,@env4
	.word @env3,@env0,@env9,@env4
	.word @env12,@env0,@env9,@env8
	.word @env17,@env0,@env9,@env8
	.word @env3,@env0,@env13,@env4
	.word @env7,@env0,@env13,@env8
	.word @env5,@env0,@env10,@env4
	.word @env17,@env0,@env10,@env8
	.word @env6,@env14,@env9,@env8
	.word @env16,@env15,@env9,@env8
	.word @env6,@env15,@env9,@env8
	.word @env1,@env11,@env9,@env8
	.word @env1,@env0,@env9,@env8

@samples:
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$3e,$08,$40	;16 (Sample 2)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;17 
	.byte $10+.lobyte(FAMISTUDIO_DPCM_PTR),$3f,$09,$40	;18 (Sample 1)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;19 
	.byte $10+.lobyte(FAMISTUDIO_DPCM_PTR),$3f,$0a,$40	;20 (Sample 1)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$3e,$0a,$40	;21 (Sample 2)
	.byte $20+.lobyte(FAMISTUDIO_DPCM_PTR),$3f,$0a,$40	;22 (Sample 5)
	.byte $30+.lobyte(FAMISTUDIO_DPCM_PTR),$3e,$0c,$40	;23 (Sample 4)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;24 
	.byte $10+.lobyte(FAMISTUDIO_DPCM_PTR),$3f,$0c,$40	;25 (Sample 1)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;26 
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;27 
	.byte $40+.lobyte(FAMISTUDIO_DPCM_PTR),$3f,$0d,$40	;28 (Sample 3)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;29 
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$3e,$0d,$40	;30 (Sample 2)
	.byte $40+.lobyte(FAMISTUDIO_DPCM_PTR),$3f,$0e,$40	;31 (Sample 3)
	.byte $10+.lobyte(FAMISTUDIO_DPCM_PTR),$3f,$0e,$40	;32 (Sample 1)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$3e,$0e,$40	;33 (Sample 2)
	.byte $20+.lobyte(FAMISTUDIO_DPCM_PTR),$3f,$0e,$40	;34 (Sample 5)
	.byte $30+.lobyte(FAMISTUDIO_DPCM_PTR),$3e,$0f,$40	;35 (Sample 4)
	.byte $00+.lobyte(FAMISTUDIO_DPCM_PTR),$00,$00,$40	;36 
	.byte $10+.lobyte(FAMISTUDIO_DPCM_PTR),$3f,$0f,$40	;37 (Sample 1)

@env0:
	.byte $c0,$7f,$00,$00
@env1:
	.byte $04,$cf,$7f,$00,$01
@env2:
	.byte $08,$ce,$cb,$ca,$c9,$c9,$00,$05,$c1,$c5,$c4,$c3,$c2,$c1,$00,$0d
@env3:
	.byte $0f,$c4,$c6,$c9,$c8,$0e,$c7,$0e,$c6,$0e,$c5,$0e,$c4,$00,$0c,$c1,$c5,$c4,$c3,$c2,$c1,$00,$14
@env4:
	.byte $00,$c0,$07,$c1,$c3,$c6,$c3,$c1,$bf,$bd,$ba,$bd,$bf,$00,$03
@env5:
	.byte $0e,$c5,$c6,$c6,$ca,$cb,$cc,$cb,$ca,$c9,$c8,$c7,$00,$0b,$c1,$c5,$c4,$c3,$c2,$c1,$00,$13
@env6:
	.byte $00,$cc,$cc,$c9,$c5,$c2,$c0,$00,$06
@env7:
	.byte $04,$c3,$7f,$00,$01
@env8:
	.byte $00,$c0,$7f,$00,$01
@env9:
	.byte $7f,$00,$00
@env10:
	.byte $c2,$7f,$00,$00
@env11:
	.byte $c0,$bf,$be,$bd,$bc,$bb,$ba,$b9,$b8,$b7,$00,$09
@env12:
	.byte $00,$c5,$c9,$c9,$c8,$00,$04
@env13:
	.byte $c1,$7f,$00,$00
@env14:
	.byte $c0,$c3,$00,$01
@env15:
	.byte $c0,$c6,$00,$01
@env16:
	.byte $00,$cd,$ce,$cc,$c8,$c9,$c7,$c6,$c4,$c3,$c1,$c0,$00,$0b
@env17:
	.byte $04,$c4,$7f,$00,$01
@env18:
	.byte $00,$c0,$be,$bc,$bc,$bd,$bf,$c1,$c3,$c4,$c4,$c2,$00,$01
@tempo_env_5_mid:
	.byte $03,$04,$07,$04,$05,$05,$80
@song0ch0:
	.byte $cf
@song0ch0loop:
	.byte $6a, .lobyte(@tempo_env_5_mid), .hibyte(@tempo_env_5_mid), $00, $a5, $8a, $25, $91, $28, $91, $25, $91, $2a, $2b, $81
	.byte $2c, $9f, $2a, $91
@song0ref22:
	.byte $82, $20, $af, $f9, $87, $22
@song0ref28:
	.byte $d7, $f9, $87, $6b, $00, $a5, $8a, $25, $91, $28, $91, $25, $91, $2a, $2b, $81, $2c, $9f, $2a, $91, $82, $2c, $af, $f9
	.byte $87, $2a
	.byte $ff, $12
	.word @song0ref28
	.byte $ff, $1c
	.word @song0ref22
	.byte $d7, $f9, $87
@song0ref63:
	.byte $6b, $a7, $23, $91, $f9, $91, $22, $87, $f9, $87, $23, $91, $f9, $91, $23, $a5, $f9, $91, $22, $91, $f9, $91, $22, $87
	.byte $f9, $87, $23, $87, $f9, $af
	.byte $ff, $1d
	.word @song0ref63
	.byte $ff, $1d
	.word @song0ref63
	.byte $6b, $a7, $23, $91, $f9, $91, $22, $87, $f9, $87, $23, $91, $f9, $91, $20, $f7, $9b, $f9, $87, $8c
@song0ref119:
	.byte $25, $91, $6b, $89, $f9, $87, $25, $87, $f9, $87, $28, $87, $f9, $87, $25, $87, $f9, $87, $2a, $87, $f9, $87, $25, $91
	.byte $f9, $91, $2c, $9b, $f9, $87
@song0ref149:
	.byte $25, $87, $f9, $87, $2a, $87, $f9, $87, $25, $87, $f9, $87, $28, $87, $f9, $87, $25, $91, $f9, $91, $20, $91, $6b, $89
	.byte $f9, $87, $20, $87, $f9, $87, $23, $87, $f9, $87, $20, $87, $f9, $87, $23, $87, $f9, $87, $26, $62, $27, $81, $62, $28
	.byte $8b, $27, $87, $f9, $87, $25, $f7, $9b, $f9, $87
	.byte $ff, $19
	.word @song0ref119
	.byte $2a, $62, $2b, $81, $62, $2c, $9f
	.byte $ff, $21
	.word @song0ref149
	.byte $25, $87, $f9, $87, $26, $62, $27, $81, $62, $28, $8b, $27, $87, $f9, $87, $23, $87, $f9, $87, $25, $f7, $af, $f9, $87
	.byte $6b
@song0ref245:
	.byte $2a, $81, $62, $2b, $81, $62, $2c, $d9, $2a, $87, $f9, $87, $28, $87, $f9, $87, $27, $d7, $f9, $87, $28, $91, $f9, $87
	.byte $2a, $91, $f9, $87, $2a, $62, $2b, $81, $62, $2c, $8b, $6b, $f7, $93, $88, $2a, $62, $2b, $81, $62, $2c, $9f, $2a, $62
	.byte $2b, $81, $62, $2c, $8b, $2e, $91, $f9, $91, $2f, $9b, $f9, $af, $6b, $8c
	.byte $ff, $1a
	.word @song0ref245
	.byte $25, $91, $6b, $f7, $bb, $80, $25, $87, $f9, $87, $25, $87, $f9, $87, $25, $87, $f9, $87, $25, $87, $f9, $c3, $6b, $82
@song0ref335:
	.byte $25, $c3, $f9, $87, $25, $c3, $f9, $87, $25, $af, $f9, $87, $25, $cd, $f9, $91, $6b
	.byte $ff, $10
	.word @song0ref335
	.byte $6b
	.byte $ff, $10
	.word @song0ref335
	.byte $6b, $27, $c3, $f9, $87, $27, $c3, $f9, $87, $27, $af, $f9, $87, $27, $cd, $f9, $91, $6b, $25, $9b, $f9, $87, $25, $9b
	.byte $f9, $87, $25, $91, $f9, $87, $25, $91, $f9, $87, $25
@song0ref394:
	.byte $af, $f9, $87, $25, $9b, $f9, $87, $25, $91, $f9, $87, $25, $91
@song0ref407:
	.byte $f9, $87, $25, $91, $6b, $9d, $f9, $87, $25, $9b, $f9, $87, $25, $91, $f9, $87, $25, $91, $f9, $87, $25, $c3, $f9, $87
	.byte $23, $c3
	.byte $ff, $14
	.word @song0ref407
	.byte $ff, $18
	.word @song0ref394
	.byte $27, $91, $f9, $87, $2c, $91, $f9, $87, $2c, $f7, $af, $f9, $87, $6b, $00, $a5, $86
@song0ref456:
	.byte $25, $91, $27, $91
@song0ref460:
	.byte $28, $91, $2a, $91, $25, $91, $27, $91, $28, $91, $2a, $91, $25, $91, $27, $91, $28, $91, $2a, $91, $25, $91, $27, $91
	.byte $6b
	.byte $ff, $18
	.word @song0ref460
	.byte $28, $91, $2a, $91, $25, $91, $27, $91, $6b
	.byte $ff, $14
	.word @song0ref460
	.byte $27, $91, $28, $91, $2a, $91, $2c, $b9, $6b, $2f, $91, $31, $a5
@song0ref513:
	.byte $33, $91, $34, $91, $36, $91, $31, $91, $33, $91, $34, $91, $36, $a5, $38, $91, $39, $91, $3b, $91, $36, $91, $38, $91
	.byte $6b, $39, $91, $3b, $91, $3d, $f7, $f5, $62, $61, $05, $3d, $37, $a5, $fd
	.word @song0ch0loop
@song0ch1:
	.byte $cf
@song0ch1loop:
	.byte $88
@song0ref557:
	.byte $25, $87, $f9, $87, $28, $87, $f9, $87, $25, $87, $f9, $87, $2a, $62, $2b, $81, $62, $2c, $9f, $2a, $87, $f9, $87, $28
	.byte $9b, $f9, $87, $23, $af, $f9, $87, $25, $d7, $f9, $87
	.byte $ff, $19
	.word @song0ref557
	.byte $2f, $af, $f9, $87, $2e, $d7, $f9, $87
	.byte $ff, $21
	.word @song0ref557
	.byte $ff, $19
	.word @song0ref557
	.byte $2f, $af, $f9, $87, $2e, $d7, $f9, $87, $a7, $82
@song0ref619:
	.byte $28, $91, $f9, $91, $27, $87, $f9, $87, $28, $91, $f9, $91, $28, $a5, $f9, $91, $27, $91, $f9, $91, $27, $87, $f9, $87
	.byte $28, $87, $f9, $af, $a7
	.byte $ff, $1d
	.word @song0ref619
	.byte $ff, $1d
	.word @song0ref619
	.byte $28, $91, $f9, $91, $27, $87, $f9, $87, $28, $91, $f9, $91, $27, $f7, $af, $f9, $87, $93, $8e, $25, $b9, $28, $91, $25
	.byte $91, $2a, $91, $25, $a5, $2c, $a5, $25, $91, $2a, $91, $25, $91, $28, $91, $25, $91, $93, $20, $b9, $23, $91, $20, $91
	.byte $23, $91, $26, $27, $81, $28, $8b, $27, $91, $25, $f7, $91, $cf, $28, $91, $25, $91, $2a, $91, $25, $a5, $2a, $2b, $81
	.byte $2c, $9f, $25, $91, $2a, $91, $25, $91, $28, $91, $25, $91, $93, $20, $b9, $23, $91, $25, $91, $26, $27, $81, $28, $8b
	.byte $27, $91, $23, $91, $25, $f7, $91, $a7
@song0ref758:
	.byte $2a, $81, $2b, $81, $2c, $d9, $2a, $91, $28, $91, $27, $e1, $28, $9b, $2a, $87, $95, $2b, $81, $2c, $ef, $82, $27, $9b
	.byte $f9, $87, $27, $87, $f9, $87, $2a, $91, $f9, $91, $2c, $9b, $f9, $af, $a7, $8e
	.byte $ff, $10
	.word @song0ref758
	.byte $93, $25, $f7, $a5, $80, $20, $87, $f9, $87, $20, $87, $f9, $87, $20, $87, $f9, $87, $20, $87, $f9, $c3, $88
@song0ref823:
	.byte $2c, $c3, $f9, $87, $2a, $c3, $f9, $87, $28, $af, $f9, $87, $2a, $cd, $f9, $91
	.byte $ff, $10
	.word @song0ref823
	.byte $ff, $10
	.word @song0ref823
	.byte $2d, $c3, $f9, $87, $2c, $c3, $f9, $87, $2a, $af, $f9, $87, $2c, $cd, $f9, $91, $2c, $9b, $f9, $87, $2a, $9b, $f9, $87
	.byte $28, $91, $f9, $87, $2a, $91, $f9, $87
@song0ref877:
	.byte $2c, $af, $f9, $87, $2a, $9b, $f9, $87, $28, $91, $f9, $87, $2a, $91
@song0ref891:
	.byte $f9, $87, $2c, $91, $9d, $f9, $87, $2a, $9b, $f9, $87, $28, $91, $f9, $87, $2a, $91, $f9, $87, $28, $c3, $f9, $87, $27
	.byte $c3
	.byte $ff, $13
	.word @song0ref891
	.byte $ff, $19
	.word @song0ref877
	.byte $2c, $91, $f9, $87, $2f, $91, $f9, $87, $31, $f7, $af, $f9, $87, $84
	.byte $ff, $1c
	.word @song0ref456
	.byte $ff, $18
	.word @song0ref460
	.byte $ff, $18
	.word @song0ref460
	.byte $28, $91, $2a, $91, $27, $91, $28, $91, $2a, $91, $2c, $b9, $2f, $91, $31, $91, $93
	.byte $ff, $18
	.word @song0ref513
	.byte $39, $91, $3b, $91, $3d, $cd, $63, .lobyte(@env18), .hibyte(@env18), $f7, $a5, $63, .lobyte(@env8), .hibyte(@env8)
	.byte $64, $81, $62, $61, $06, $3d, $30, $cd, $fd
	.word @song0ch1loop
@song0ch2:
@song0ref990:
	.byte $98, $32, $31, $32, $81, $31, $32, $33, $32, $31, $32, $96, $32, $85, $00, $32, $85, $00, $2a, $85, $00, $2a, $85, $00
	.byte $26, $8f, $00
@song0ch2loop:
	.byte $96
@song0ref1019:
	.byte $28, $83, $00, $8b, $28, $83, $00, $8b, $2e, $8f, $00, $28, $83, $00, $8b, $28, $83, $00, $8b, $28, $83, $00, $8b, $2e
	.byte $8f, $00, $28, $83, $00, $8b
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
@song0ref1055:
	.byte $32, $8f, $00, $32, $8f, $00, $2a, $8f, $00, $26, $8f, $00, $32, $85, $00, $32, $85, $00, $89, $32, $85, $00, $2a, $85
	.byte $00, $2a, $85, $00, $26, $8f, $00
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
@song0ref1095:
	.byte $32, $85, $00, $32, $85, $00, $2a, $85, $00, $26, $85, $00, $32, $85, $00, $2a, $85, $00, $2a, $85, $00, $26, $85, $00
	.byte $ff, $17
	.word @song0ref990
	.byte $85, $00, $26, $85, $00
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1f
	.word @song0ref1055
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $18
	.word @song0ref1095
	.byte $ff, $17
	.word @song0ref990
	.byte $85, $00, $26, $85, $00
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1f
	.word @song0ref1055
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $18
	.word @song0ref1095
	.byte $ff, $17
	.word @song0ref990
	.byte $85, $00, $26, $85, $00
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1f
	.word @song0ref1055
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $28, $83, $00, $8b, $2e, $8f, $00, $2e, $8f, $00, $2e, $8f, $00, $2e, $8f, $00, $95, $98, $2e, $83, $00, $9d, $96
@song0ref1235:
	.byte $28, $83, $00, $c7, $28, $83, $00, $c7, $28, $83, $00, $b3, $28, $83, $00, $9f, $98, $2e, $83, $00, $8b, $96, $28, $83
	.byte $00, $9f
	.byte $ff, $18
	.word @song0ref1235
	.byte $ff, $18
	.word @song0ref1235
	.byte $ff, $10
	.word @song0ref1235
	.byte $2e, $8f, $00, $2e, $8f, $00, $2e, $8f, $00
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1f
	.word @song0ref1055
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $18
	.word @song0ref1095
	.byte $ff, $17
	.word @song0ref990
	.byte $85, $00, $26, $85, $00
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1f
	.word @song0ref1055
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $18
	.word @song0ref1095
	.byte $ff, $17
	.word @song0ref990
	.byte $85, $00, $26, $85, $00
	.byte $ff, $1e
	.word @song0ref1019
	.byte $ff, $18
	.word @song0ref1095
	.byte $ff, $17
	.word @song0ref990
	.byte $85, $00, $26, $85, $00, $fd
	.word @song0ch2loop
@song0ch3:
	.byte $92, $26, $83, $26, $85, $26, $83, $26, $87, $26, $87, $26, $87, $26, $87, $26, $87, $26, $87
@song0ch3loop:
@song0ref1380:
	.byte $90
@song0ref1381:
	.byte $1c, $91, $1c, $91, $92, $26, $91, $90, $1c, $91, $1c, $91, $1c, $91, $92, $26, $91, $90, $1c, $91
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
@song0ref1407:
	.byte $94, $26, $91, $26, $91, $26, $91, $26, $91, $26, $87, $26, $91, $26, $87, $26, $87, $26, $87, $26, $91
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
@song0ref1437:
	.byte $94
@song0ref1438:
	.byte $26, $87, $26, $87, $26, $87, $26, $87, $26, $87, $26, $87, $26, $87, $26, $87
	.byte $ff, $10
	.word @song0ref1438
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $14
	.word @song0ref1407
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1437
	.byte $ff, $10
	.word @song0ref1438
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $14
	.word @song0ref1407
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1437
	.byte $ff, $10
	.word @song0ref1438
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $14
	.word @song0ref1407
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
	.byte $1c, $91, $92, $26, $91, $26, $91, $26, $91, $26, $a7, $26, $a3, $90
@song0ref1546:
	.byte $1c, $cd, $1c, $cd, $1c, $b9, $1c, $a5, $92, $26, $91, $90, $1c, $a5, $1c, $cd, $1c, $cd, $1c, $b9, $1c, $a5, $92, $26
	.byte $91, $90, $1c, $a5
	.byte $ff, $16
	.word @song0ref1546
	.byte $26, $91, $26, $91
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $14
	.word @song0ref1407
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1437
	.byte $ff, $10
	.word @song0ref1438
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $14
	.word @song0ref1407
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1381
	.byte $ff, $10
	.word @song0ref1437
	.byte $ff, $10
	.word @song0ref1438
	.byte $ff, $10
	.word @song0ref1380
	.byte $ff, $10
	.word @song0ref1437
	.byte $ff, $10
	.word @song0ref1438
	.byte $fd
	.word @song0ch3loop
@song0ch4:
	.byte $cf
@song0ch4loop:
@song0ref1649:
	.byte $19, $91
@song0ref1651:
	.byte $19, $91, $19, $91, $19, $91, $19, $91, $19, $91, $19, $91, $19, $91, $14, $91, $14, $91, $20, $91, $12, $91, $12, $91
	.byte $1e, $91, $12, $91, $1e, $91
	.byte $ff, $10
	.word @song0ref1649
@song0ref1684:
	.byte $10, $91, $10, $91, $1c, $91, $12, $91, $12, $91, $1e, $91, $12, $91, $1e, $91
	.byte $ff, $20
	.word @song0ref1649
	.byte $ff, $10
	.word @song0ref1649
	.byte $ff, $10
	.word @song0ref1684
	.byte $ff, $10
	.word @song0ref1649
	.byte $ff, $10
	.word @song0ref1649
	.byte $ff, $10
	.word @song0ref1649
	.byte $ff, $10
	.word @song0ref1649
	.byte $ff, $10
	.word @song0ref1649
	.byte $ff, $10
	.word @song0ref1649
	.byte $ff, $12
	.word @song0ref1651
	.byte $14, $91, $14, $91, $14, $91, $14, $91, $14, $91, $14, $91, $14
@song0ref1743:
	.byte $91, $19, $91, $19, $91, $19, $91, $25, $91, $19, $91, $25, $91, $19, $91, $19, $91, $17, $91, $23, $91, $17, $91, $17
	.byte $91, $17, $91, $23, $91, $17, $91, $17, $91, $14, $91, $14, $91, $14, $91, $20, $91, $17, $91, $23, $91, $17, $91, $17
	.byte $91, $19, $91, $25, $91, $19, $91, $19, $91, $19, $91, $25, $91, $19, $91, $19
	.byte $ff, $40
	.word @song0ref1743
@song0ref1810:
	.byte $91, $12, $91, $12, $91, $1e, $91, $12, $91, $12, $91, $12, $91, $1e, $91, $12, $91, $14, $91, $14, $91, $20, $91, $14
	.byte $91, $14, $91, $14, $91, $20, $91, $14, $91, $19, $91, $19, $91, $25, $91, $19, $91, $25, $91, $19, $91, $19, $91, $25
@song0ref1858:
	.byte $91, $19, $91, $19, $91, $25, $91, $19, $91, $19, $91, $25, $91, $19, $91, $25
	.byte $ff, $35
	.word @song0ref1810
	.byte $19, $91, $19, $91, $19, $cd, $19, $cd, $19, $cd, $19, $b9, $19, $a5, $19, $91, $25, $91, $19, $91, $17, $cd, $17, $cd
	.byte $17, $b9, $17, $a5, $17, $91, $23, $91, $17, $91, $15, $cd, $15, $cd, $15, $b9, $15, $a5, $15, $91, $23, $91, $15, $91
	.byte $17, $cd, $17, $cd, $17, $b9, $17, $a5, $23, $91, $17, $91, $23
	.byte $ff, $10
	.word @song0ref1858
@song0ref1941:
	.byte $91, $17, $91, $17, $91, $23, $91, $17, $91, $17, $91, $23, $91, $17, $91, $23, $91, $15, $91, $15, $91, $21, $91, $15
	.byte $91, $15, $91, $21, $91, $15, $91, $21
	.byte $ff, $11
	.word @song0ref1941
	.byte $19, $91, $19, $91, $25, $91, $19, $91, $19, $91, $25, $91, $19, $91, $25
	.byte $ff, $20
	.word @song0ref1941
	.byte $ff, $10
	.word @song0ref1858
@song0ref1997:
	.byte $91, $19, $91, $19, $91, $19, $91, $25, $91, $19, $91, $19, $91, $23, $91, $25, $91, $17, $91, $17, $91, $17, $91, $23
	.byte $91, $17, $91, $17, $91, $21, $91, $23, $91, $16, $91, $16, $91, $16, $91, $22, $91, $16, $91, $16, $91, $14, $91, $22
	.byte $91, $15, $91, $15, $91, $15, $91, $21, $91, $15, $91, $15, $91, $1f, $91, $21
	.byte $ff, $40
	.word @song0ref1997
	.byte $ff, $11
	.word @song0ref1997
	.byte $19, $91, $19, $91, $25, $91, $19, $91, $19, $91, $25, $91, $19, $91, $25, $91, $fd
	.word @song0ch4loop