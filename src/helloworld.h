#include "fire.h"

unsigned char frame = 0;

unsigned char color_index = 0; // count from 0 to color_count
unsigned char color_table[] = {0x20, 0x21, 0x24, 0x26, 0x27, 0x29, 0x2C};
unsigned char color_count = 7;

void rainbow_color_nmi() {
    ++frame;
    if(frame > 10) {
        frame = 0;
        ++color_index;
        if(color_index >= color_count) {
            color_index = 0;
        }
        PPU_ADDR = 0x3F; PPU_ADDR = 0x03; // bg palette 1 color 3
        PPU_DATA = color_table[color_index];

        PPU_ADDR = 0x20; PPU_ADDR = 0x00; // reset address to 2000
    }
}


void draw_hello_world() {

    // disable rendering, 
    PPU_MASK = MASK_HIDE_BG | MASK_HIDE_SPRITE;
    PPU_CTRL = CTRL_NAMETABLE_2000 | CTRL_INCREMENT_1 | CTRL_SPRITE_1000 | CTRL_BG_0000 | CTRL_SPRITE_8x8 | CTRL_NMI_DISABLE;
    
    PPU_ADDR = 0x3F; PPU_ADDR = 0x00; // universal bg color
    PPU_DATA = 0x0F; // black

    PPU_ADDR = 0x3F; PPU_ADDR = 0x03; // bg palette 1 color 3
    PPU_DATA = 0x0F; // black

    PPU_ADDR = 0x21; PPU_ADDR = 0xEA;
    PPU_DATA = 1; // H
    PPU_DATA = 2; // E
    PPU_DATA = 3; // L
    PPU_DATA = 3; // L
    PPU_DATA = 4; // O
    PPU_DATA = 0; // 
    PPU_DATA = 5; // W
    PPU_DATA = 4; // O
    PPU_DATA = 6; // R
    PPU_DATA = 3; // L
    PPU_DATA = 7; // D
    PPU_DATA = 8; // !
    
    while(PPU_STATUS & 0x80 == 0) {} // wait for vblank

    // enable rendering
    PPU_MASK = MASK_SHOW_BG | MASK_SHOW_SPRITE;
    PPU_CTRL = CTRL_NAMETABLE_2000 | CTRL_INCREMENT_1 | CTRL_SPRITE_1000 | CTRL_BG_0000 | CTRL_SPRITE_8x8 | CTRL_NMI_ENABLE;
    PPU_SCROLL = 0; PPU_SCROLL = 0;
}
