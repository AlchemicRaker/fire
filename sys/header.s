.segment "HEADER"
.import INES_MAPPER, INES_SRAM, INES_PRG_BANKS, INES_CHR_BANKS

.byte 'N', 'E', 'S', $1A ; ID
.byte <INES_PRG_BANKS ; 16k PRG bank count
.byte <INES_CHR_BANKS ; 8k CHR bank count
.byte <INES_MIRROR | (<INES_SRAM << 1) | ((<INES_MAPPER & $f) << 4)
.byte (<INES_MAPPER & %11110000)
.byte $0, $0, $0, $0, $0, $0, $0, $0 ; padding
