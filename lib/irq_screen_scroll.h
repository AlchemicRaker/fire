// irq types
//   scanline - mmc3, mmc5
//   cpu cycle - fme-7, vrc6, vrc7, n163

#ifdef IRQ_SUPPORT

extern char irq_ss_scroll_x;
#pragma zpsym ("irq_ss_scroll_x");
extern char irq_ss_scroll_y;
#pragma zpsym ("irq_ss_scroll_y");

#ifdef MAPPER_MMC3
#include "irq_screen_scroll/mmc3.h"
#endif

#ifdef MAPPER_MMC5
#include "irq_screen_scroll/mmc5.h"
#endif

#ifdef MAPPER_FME7
#include "irq_screen_scroll/fme-7.h"
#endif

#ifdef MAPPER_VRC6
#include "irq_screen_scroll/vrc6.h"
#endif

#ifdef MAPPER_VRC7
#include "irq_screen_scroll/vrc7.h"
#endif

#ifdef MAPPER_N163
#include "irq_screen_scroll/n163.h"
#endif

#endif //#ifdef IRQ_SUPPORT
