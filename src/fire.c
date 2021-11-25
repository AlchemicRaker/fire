#include "fire.h"
#include "gray.h"
#include "features.h"

extern char hello_lang[];
extern char demo_map[];
extern char demo_map_bank;

unsigned char i=127;
unsigned char j=126;
unsigned char k;
unsigned int x, y;
long unsigned int drawto;

void draw_demo(void) {
    write_ppu_mask(MASK_HIDE_BG, MASK_HIDE_SPRITE);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_0000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_DISABLE);
#ifdef DATA_SUPPORT
    push_data_bank(demo_map_bank);
#endif
    write_ppu_address(0x2000, 0, 0);
    write_ppu_data_nam(demo_map);
#ifdef DATA_SUPPORT
    pop_data_bank();
#endif
    write_ppu_mask(MASK_SHOW_BG | MASK_SHOW_LEFT_BG, MASK_HIDE_SPRITE | MASK_SHOW_LEFT_SPRITE);
    write_ppu_scroll(0, 0);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_0000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_ENABLE);
}

void draw_char(char c) {
    write_ppu_mask(MASK_HIDE_BG, MASK_HIDE_SPRITE);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_0000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_DISABLE);
    write_ppu_address(0x2000, 0, 0);
    write_ppu_data_fill(c);
    write_ppu_mask(MASK_SHOW_BG | MASK_SHOW_LEFT_BG, MASK_HIDE_SPRITE | MASK_SHOW_LEFT_SPRITE);
    write_ppu_scroll(0, 0);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_0000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_ENABLE);
}

void sample(char *source, char width, char height, long unsigned int nt_start) {

}

void main (void) {

    wait_for_vblank_profile();
    draw_demo();
#ifdef DATA_SUPPORT
    push_data_bank(demo_map_bank);
#endif
    while (1){ 
        // doing stupid math that's slow, calculate it before the vblank
        x = i % 24;
        y = 12 + i % 13;
        drawto = ppu_address(0x2000, x, y);
        wait_for_vblank_profile();
        
        // copy a small area into the nametable
        write_ppu_mask(MASK_HIDE_BG, MASK_HIDE_SPRITE);
        write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_0000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_DISABLE);
        write_ppu_data_copy_area(demo_map, 9, 4, 7, 4, drawto);
        write_ppu_mask(MASK_SHOW_BG | MASK_SHOW_LEFT_BG, MASK_HIDE_SPRITE | MASK_SHOW_LEFT_SPRITE);
        write_ppu_scroll(0, 0);
        write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_0000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_ENABLE);

        write_ppu_scroll(0, 0);

#ifdef DATA_SUPPORT
        push_data_bank(1);
        k = 1;
        push_data_bank(2);
        k = 2;
        select_data_bank(3);
        k = 3;
        pop_data_bank();
        k = 4;
        pop_data_bank();
        k = 5;
#endif

#ifdef SAMPLE_SUPPORT
        select_sample_bank(3);
        select_sample_bank(2);
        select_sample_bank(1);
        select_sample_bank(0);
#endif

        k = i;
        // (*foo)();
        gray_line(); // a far call to gray, which will far call to blue
        k = i;
    }
#ifdef DATA_SUPPORT
    pop_data_bank();
#endif
     
    i+=254;
}

#pragma code-name ("PRG_BANK_0")

