#include "fire.h"
#include "gray.h"
#include "rapidfire.h"

#ifdef FAMISTUDIO
#include "famistudio.h"
#endif

#ifdef IRQ_SCREEN_SCROLL
#ifdef IRQ_SUPPORT
#include "irq_screen_scroll.h"
#endif
#endif

extern char hello_lang[];
extern char demo_map[];
extern char demo_map_bank;
extern char nmi_oam_enable;
#pragma zpsym ("nmi_oam_enable");

typedef struct {
    unsigned char y;
    unsigned char tile_index;
    unsigned char attributes;
    unsigned char x;
} sprite_t;

extern sprite_t oam_shadow[];

extern unsigned int* cptr;
#pragma zpsym ("cptr");

extern unsigned char music_data_journey_to_silius[];
extern unsigned char sounds[];

unsigned char i=127;
unsigned char j=126;
unsigned char k;
unsigned int x, y;
long unsigned int drawto;

const char tiles[] = {1, 2, 3};

extern void sample_c_hook(void);

void draw_demo(void) {
    write_ppu_mask(MASK_HIDE_BG, MASK_HIDE_SPRITE);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_1000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_DISABLE);
#ifdef DATA_SUPPORT
    push_data_bank(demo_map_bank);
#endif
    write_ppu_address(0x2000, 0, 0);
    write_ppu_data_nam(demo_map);
#ifdef DATA_SUPPORT
    pop_data_bank();
#endif
    write_ppu_mask(MASK_SHOW_BG | MASK_SHOW_LEFT_BG, MASK_SHOW_SPRITE | MASK_SHOW_LEFT_SPRITE);
    write_ppu_scroll(0, 0);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_1000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_ENABLE);
}

void draw_char(char c) {
    write_ppu_mask(MASK_HIDE_BG, MASK_HIDE_SPRITE);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_1000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_DISABLE);
    write_ppu_address(0x2000, 0, 0);
    write_ppu_data_fill(c);
    write_ppu_mask(MASK_SHOW_BG | MASK_SHOW_LEFT_BG, MASK_SHOW_SPRITE | MASK_SHOW_LEFT_SPRITE);
    write_ppu_scroll(0, 0);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_1000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_ENABLE);
}

#ifdef C_NMI_HOOK
void nmi_hook() {
    // copy a small area into the nametable
    write_ppu_mask(MASK_HIDE_BG, MASK_HIDE_SPRITE);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_1000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_DISABLE);
    write_ppu_data_copy_area(demo_map, 9, 4, 7, 4, compose_ppu_address(0x2000, x, y));
    write_ppu_mask(MASK_SHOW_BG | MASK_SHOW_LEFT_BG, MASK_SHOW_SPRITE | MASK_SHOW_LEFT_SPRITE);
    write_ppu_scroll(0, 0);
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_1000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_ENABLE);
    write_ppu_scroll(0, 0);
}
#endif

void draw_text() {
    PPU_DATA = 0x02;
    PPU_DATA = 0x01;
    PPU_DATA = 0x07;
    PPU_DATA = 0x03;
    PPU_DATA = 0x01;
}

        unsigned char please;

void main (void) {

#ifdef CHR_4K_SUPPORT
    select_chr_4k_1000(0);
#endif
#ifdef CHR_2K_SUPPORT
    select_chr_2k_0800(0);
    select_chr_2k_1800(0);
#endif
#ifdef CHR_1K_B_SUPPORT
    select_chr_1k_0400(0);
    select_chr_1k_0C00(0);
#endif
#ifdef CHR_1K_S_SUPPORT
    select_chr_1k_1400(0);
    select_chr_1k_1C00(0);
#endif

#ifdef DYANIC_MIRRORING
    select_mirror_vertical();
    select_mirror_horizontal();
#endif

    wait_for_vblank();
    
    draw_demo();
#ifdef DATA_SUPPORT
    push_data_bank(demo_map_bank);
#endif
    i=0;
    // cptr = (unsigned int *) &oam_shadow[i];
    // ((sprite_t *)0x0200)->y = 16;
    // ((sprite_t *)cptr)->y = 16;
    // ((sprite_t *)cptr)->tile_index = 0x11;
    // ((sprite_t *)cptr)->x = i;
    oam_shadow[0].y = 16;
    oam_shadow[0].tile_index = 0x11;
    oam_shadow[1].y = 17;
    oam_shadow[1].tile_index = 0x11;
    oam_shadow[2].y = 18;
    oam_shadow[2].tile_index = 0x11;
    write_ppu_ctrl(CTRL_NAMETABLE_2000,CTRL_INCREMENT_1,CTRL_SPRITE_1000,CTRL_BG_0000,CTRL_SPRITE_8x8,CTRL_NMI_ENABLE);


#ifdef FAMISTUDIO
    // music!
    // famistudio_sfx_init(&sounds);
    famistudio_init(FAMISTUDIO_PLATFORM_NTSC, &music_data_journey_to_silius);
    famistudio_music_play(0);
#endif
    
    write_scroll_shadow(4,0);

    while (1){ 
        // doing stupid math that's slow, calculate it before the vblank
        x = i % 24;
        y = 12 + i % 13;
        drawto = compose_ppu_address(0x2000, x, y);
        // wait_for_vblank_profile();
        // nmi_oam_enable = 0x02;
        // while(nmi_oam_enable == 0x02) {
        //     i = i;
        // }
        wait_for_nmi();
        // wait_for_vblank();
        // write_ppu_scroll(0, 0);

        rapidfire_push_ppu_addr(0x2001);
        rapidfire_push_ppu_ctrl(CTRL_NAMETABLE_2000 + CTRL_INCREMENT_32 + CTRL_SPRITE_1000 + CTRL_BG_0000 + CTRL_SPRITE_8x8 + CTRL_NMI_ENABLE);
        rapidfire_push_function(draw_text);
        rapidfire_push_ppu_data(0x0A);
        rapidfire_push_ppu_ctrl(CTRL_NAMETABLE_2000 + CTRL_INCREMENT_1 + CTRL_SPRITE_1000 + CTRL_BG_0000 + CTRL_SPRITE_8x8 + CTRL_NMI_ENABLE);

        rapidfire_ready();

#ifdef IRQ_SCREEN_SCROLL
#ifdef IRQ_SUPPORT
        k = i & 3;
        if(k == 0) {
            irq_screen_scroll(8, 16, 16);
            // irq_screen_scroll((8*15)+4, 8, 0); // 4 scanlines into the 15th tile, set scroll to 1,0
        }
        if(k == 1){
            irq_screen_scroll((8*3)+4, 16, 16);
            // irq_screen_scroll((8*15)+4, 8, 0); // 4 scanlines into the 15th tile, set scroll to 1,0
        }
        if(k == 2){
            irq_screen_scroll((8*15)+4, 16, 16); // 4 scanlines into the 15th tile, set scroll to 1,0
        }
        if(k == 3){
            irq_screen_scroll((8*22)+4, 16, 16);
        }
        // irq_screen_scroll((8*22)+4, 8, 0);
#endif
#endif
        
        //updates to OAM during game logic

        // write_oam_shadow(1, 0x11, i, 16, 0, 0);
        // write_oam_shadow(2, 0x11, i+16, 16, 0, 0);
        // write_oam_shadow(3, 0x11, i+32, 16, 0, 0);
        oam_shadow[0].x = i;
        oam_shadow[1].x = i+16;
        oam_shadow[2].x = i+32;
        // famistudio_update();

// #ifdef DATA_SUPPORT
//         push_data_bank(1);
//         k = 1;
//         push_data_bank(2);
//         k = 2;
//         select_data_bank(3);
//         k = 3;
//         pop_data_bank();
//         k = 4;
//         pop_data_bank();
//         k = 5;
// #endif

// #ifdef SAMPLE_SUPPORT
//         select_sample_bank(3);
//         select_sample_bank(2);
//         select_sample_bank(1);
//         select_sample_bank(0);
// #endif

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

