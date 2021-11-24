#include "features.h"

#ifdef BANK_SUPPORT
#pragma wrapped-call (push, farcall, bank)
#endif
void blue_line(void);
#ifdef BANK_SUPPORT
#pragma wrapped-call (pop)
#endif
