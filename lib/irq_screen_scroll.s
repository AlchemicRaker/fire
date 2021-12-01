; irq types
;   scanline - mmc3, mmc5
;   cpu cycle - fme-7, vrc6, vrc7, n163

.ifdef IRQ_SUPPORT

.segment "ZEROPAGE"
.exportzp irq_ss_scroll_x, irq_ss_scroll_y, irq_ss_save_a
.exportzp _irq_ss_scroll_x = irq_ss_scroll_x, _irq_ss_scroll_y = irq_ss_scroll_y
irq_ss_scroll_x: .res 1
irq_ss_scroll_y: .res 1
irq_ss_save_a: .res 1

.ifdef MAPPER_MMC3
.include "irq_screen_scroll/mmc3.s"
.endif ; .ifdef MAPPER_MMC3

.ifdef MAPPER_MMC5
.include "irq_screen_scroll/mmc5.s"
.endif ; .ifdef MAPPER_MMC5

.ifdef MAPPER_FME7
.include "irq_screen_scroll/fme-7.s"
.endif ; .ifdef MAPPER_FME7

.ifdef MAPPER_VRC6
.include "irq_screen_scroll/vrc6.s"
.endif ; .ifdef MAPPER_VRC6

.ifdef MAPPER_VRC7
.include "irq_screen_scroll/vrc7.s"
.endif ; .ifdef MAPPER_VRC7

.ifdef MAPPER_N163
.include "irq_screen_scroll/n163.s"
.endif ; .ifdef MAPPER_N163

.endif ; .ifdef IRQ_SUPPORT
