
#define irq_screen_scroll(counter, x, y) { \
    irq_ss_scroll_x = x; \
    irq_ss_scroll_y = y; \
    (*(volatile char *)0x5203) = counter-1; \
    (*(volatile char *)0x5204) = 0xFF; \
}

#define irq_screen_scroll_disable() { \
    (*(volatile char *)0x5204) = 0x00; \
}

