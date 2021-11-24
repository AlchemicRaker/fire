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

void main (void) {

    wait_for_vblank_profile();
    write_ppu_mask(MASK_HIDE_BG, MASK_HIDE_SPRITE);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_0000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_DISABLE);
    write_ppu_address(0, 0);
    
#ifdef DATA_SUPPORT
    push_data_bank(demo_map_bank);
#endif
    y = 0;
    while(y<30){
        x = 0;
        while(x<32){
            write_ppu_data(demo_map[x+(y*32)]);
            ++x;
        }
        ++y;
    }
#ifdef DATA_SUPPORT
    pop_data_bank();
#endif
    write_ppu_mask(MASK_SHOW_BG | MASK_SHOW_LEFT_BG, MASK_HIDE_SPRITE | MASK_SHOW_LEFT_SPRITE);
    write_ppu_scroll(0, 0);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_0000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_ENABLE);

    while (1){ 
        wait_for_vblank_profile();
        write_ppu_address(i, 5);
        // write_ppu_data(0);
        ++i;
        write_ppu_address(i, 5); // just in case it wraps around
        // write_ppu_data(1);
        --i; //will be incremented later

        if(i < 20) {
        //     write_ppu_mask(MASK_HIDE_BG, MASK_HIDE_SPRITE);
        } else {
        //     write_ppu_mask(MASK_SHOW_BG, MASK_SHOW_SPRITE);
        }
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
     
    i+=254;
}

#pragma code-name ("PRG_BANK_0")

