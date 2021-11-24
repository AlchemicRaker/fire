
#ifdef BANK_SUPPORT
void farcall(void);
#endif

#ifdef DATA_SUPPORT
void select_data_bank(char);
void push_data_bank(char);
void pop_data_bank();
#endif

#ifdef SAMPLE_SUPPORT
void select_sample_bank(char);
#endif

//PPU direct access
void write_ppu_ctrl_raw(char control_flags);
#define write_ppu_ctrl(nametable, increment, sprite_bank, background_bank, sprite_size, nmi) (write_ppu_ctrl_raw(nametable | increment | sprite_bank | background_bank | sprite_size | nmi))

void write_ppu_mask_raw(char mask_flags);
#define write_ppu_mask(background, sprite) (write_ppu_mask_raw(background | sprite))

char read_ppu_status();

void write_oam_addr(long unsigned int address);

void write_ppu_scroll(char x, char y);

void write_ppu_address_raw(long unsigned int address);
#define write_ppu_address(x, y) write_ppu_address_raw(0x2000 | ((y << 5) + x))

void write_ppu_data(char value);
void write_ppu_data_char(char length, char *souce);
// void write_ppu_data_long(unsigned long length, char *souce);

void wait_for_vblank();
void wait_for_vblank_profile();

// constants used as options:

#define CTRL_NAMETABLE_2000   (0x00)
#define CTRL_NAMETABLE_2400   (0x01)
#define CTRL_NAMETABLE_2800   (0x02)
#define CTRL_NAMETABLE_2C00   (0x03)
#define CTRL_INCREMENT_1      (0x00 << 2)
#define CTRL_INCREMENT_32     (0x01 << 2)
#define CTRL_SPRITE_0000      (0x00 << 3)
#define CTRL_SPRITE_1000      (0x01 << 3)
#define CTRL_BG_0000          (0x00 << 4)
#define CTRL_BG_1000          (0x01 << 4)
#define CTRL_SPRITE_8x8       (0x00 << 5)
#define CTRL_SPRITE_8x16      (0x01 << 5)
#define CTRL_NMI_DISABLE      (0x00 << 7)
#define CTRL_NMI_ENABLE       (0x01 << 7)
#define MASK_GRAYSCALE        (0x01)
#define MASK_SHOW_LEFT_BG     (0x01 << 1)
#define MASK_SHOW_LEFT_SPRITE (0x01 << 2)
#define MASK_HIDE_BG          (0x00 << 3)
#define MASK_SHOW_BG          (0x01 << 3)
#define MASK_HIDE_SPRITE      (0x00 << 4)
#define MASK_SHOW_SPRITE      (0x01 << 4)
#define MASK_EMPHASIZE_RED    (0x01 << 5)
#define MASK_EMPHASIZE_GREEN  (0x01 << 6)
#define MASK_EMPHASIZE_BLUE   (0x01 << 7)
#define STATUS_SPRITE_0       (0x01 << 6)
#define STATUS_VBLANK_START   (0x01 << 7)

