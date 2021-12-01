
extern char irq_ss_counter;
#pragma zpsym ("irq_ss_counter");

#define irq_screen_scroll(counter, x, y) { \
    irq_ss_scroll_x = x; \
    irq_ss_scroll_y = y; \
    irq_ss_counter = counter-1; \
}

#define irq_screen_scroll_disable() { \
    irq_ss_counter = 0; \
}
