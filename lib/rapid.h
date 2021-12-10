#include "features.h"


extern int video_buffer[];
// #pragma zpsym ("video_buffer");
extern char* video_buffer_pointer;
#pragma zpsym ("video_buffer_pointer");
extern char video_buffer_ready;

// not as accurate as wait_for_nmi(), but works while NMI is disabled
void wait_for_vblank();
// waits until NMI has occurred, will freeze if NMI is disabled
void wait_for_nmi();

// 

// write_ppu routines for direct access

#define compose_ppu_address(nt, x, y) (nt | ((y << 5) + x))

#define write_ppu_ctrl(nametable, increment, sprite_bank, background_bank, sprite_size, nmi) { \
    PPU_CTRL = (nametable) | (increment) | (sprite_bank) | (background_bank) | (sprite_size) | (nmi); \
}

#define write_ppu_mask(background, sprite) { \
    PPU_MASK = (background) | (sprite); \
}

#define write_ppu_scroll(x, y) { \
    PPU_SCROLL = (x); \
    PPU_SCROLL = (y); \
}

extern char shadow_scroll_x;
#pragma zpsym ("shadow_scroll_x");
extern char shadow_scroll_y;
#pragma zpsym ("shadow_scroll_y");
#define write_scroll_shadow(x, y) { \
    shadow_scroll_x = (x); \
    shadow_scroll_y = (y); \
}

void write_ppu_address_raw(long unsigned int address);
#define write_ppu_address(nt, x, y) write_ppu_address_raw(compose_ppu_address(nt, x, y))

void write_ppu_data_char(char length, char *souce);
void write_ppu_data_nam(char *souce);
void write_ppu_data_fill(char value);
void write_ppu_data_copy_area_raw(char *source, char width, char height, long unsigned int nt_start);
#define write_ppu_data_copy_area(source, source_x, source_y, width, height, nt_start) write_ppu_data_copy_area_raw((source) + (source_x) + ((source_y)*32), (width), (height), (nt_start))
void write_ppu_data_fill_area(char value, char width, char height, long unsigned int nt_start);

