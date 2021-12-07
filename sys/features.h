
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

#ifdef CHR_8K_SUPPORT
void select_chr_8k_0000(char);
#endif

#ifdef CHR_4K_SUPPORT
void select_chr_4k_0000(char);
void select_chr_4k_1000(char);
#endif

#ifdef CHR_2K_SUPPORT
void select_chr_2k_0000(char);
void select_chr_2k_0800(char);
void select_chr_2k_1000(char);
void select_chr_2k_1800(char);
#endif

#ifdef CHR_1K_B_SUPPORT
void select_chr_1k_0000(char);
void select_chr_1k_0400(char);
void select_chr_1k_0800(char);
void select_chr_1k_0C00(char);
#endif

#ifdef CHR_1K_S_SUPPORT
void select_chr_1k_1000(char);
void select_chr_1k_1400(char);
void select_chr_1k_1800(char);
void select_chr_1k_1C00(char);
#endif

#ifdef DYANIC_MIRRORING
void select_mirror_vertical();
void select_mirror_horizontal();
#endif

//PPU direct access
#define PPU_CTRL    (*(volatile char *)0x2000)
#define PPU_MASK    (*(volatile char *)0x2001)
#define PPU_STATUS  (*(volatile char *)0x2002)
#define OAM_ADDR    (*(volatile char *)0x2003)
#define OAM_DATA    (*(volatile char *)0x2004)
#define PPU_SCROLL  (*(volatile char *)0x2005)
#define PPU_ADDR    (*(volatile char *)0x2006)
#define PPU_DATA    (*(volatile char *)0x2007)


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

