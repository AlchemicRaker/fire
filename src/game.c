#include "helloworld.h"

void nmi_hook() {
    rainbow_color_nmi();
}

void main() {
    draw_hello_world();

    while (1) {
        // loop indefinitely
    }
}