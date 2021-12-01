
extern unsigned int irq_ss_counter;
#pragma zpsym ("irq_ss_counter");
extern char irq_ss_enable;
#pragma zpsym ("irq_ss_enable");

#define irq_screen_scroll(counter, x, y) { \
    irq_ss_scroll_x = x; \
    irq_ss_scroll_y = y; \
    irq_ss_counter = 0x8000 | (0x7612 - (((counter)/3)*341)); \
}

#define irq_screen_scroll_disable() { \
    irq_ss_counter = 0x0000; \
}
