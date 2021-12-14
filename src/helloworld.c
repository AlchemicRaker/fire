#include "fire.h" // hardware headers
#include "helloworld.h" // hello world demo functions

void nmi_hook() {
    rainbow_color_nmi();
}

void main() {
    draw_hello_world();

    while (1) {
        // loop indefinitely
    }
}