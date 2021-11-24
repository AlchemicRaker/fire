.segment "CHR"
menu_chr:
    .export menu_chr
    .incbin "../res/menu.chr"

.segment "DATA_BANK_2"
_demo_map:
    .export _demo_map
    .incbin "../res/demo.nam"

.ifdef DATA_SUPPORT
.segment "PRG_FIXED"
_demo_map_bank:
    .export _demo_map_bank
    .byte <.bank(_demo_map)
.endif