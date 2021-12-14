#include "gray.h"
#include "blue.h"

#pragma code-name ("PRG_BANK_0")
#pragma rodata-name ("PRG_BANK_0")

extern unsigned char i;
extern unsigned char j;

void gray_line(void) {
    i++;
    blue_line();
    j--;
}