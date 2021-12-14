# Fire NES Template

A thin NES template that builds against multiple mappers and includes the most fundamental of mapper integrations (eg bank switching and far calling across banks). This project enables you to develop in both C and assembly.

## Project Goal

This project's goal is to provide an NES template useful to both novice and advanced developers. This affects many aspects of this template:

* **Low opinion** design so that your game is not limited by unnecessary and incorrect constraints about how the template _thinks_ your game should run.
* **Module system** with ready-to-use Easy Joypad input library, Famistudio and BHOP (wip) audio engines, and the Rapidfire video library.
* **Multi-mapper build system** that targets many common mappers used in the homebrew community. Start developing with any of these mappers _today_.
* **Unified mapper API**. PRG banking, CHR banking, seamless far calling, IRQ-based screen scrolling; all in a unified api.
* **C and ASM** are both supported, though you may choose to disable all **C** elements of the template if you prefer the bare-metal experience.
* **Highly commented system** files for advanced developers to modify as they desire.
* **Ready-to-use segments** reserved for your game's startup, NMI, and IRQ assembly code.

> This project strongly recommends using VSCode, paired with Mesen-X and the Alchemy65 VSCode extension for the best NES debugging experience. This project contains a launch configuration for VSCode, and a build task that will display build errors in your source code.

## Project Organization

The Fire template organizes code into four major sections, that correspond with top-level folders in the project.

* "**sys/**" contains the template's core code and mapper definitions for the unified API.
* "**lib/**" is for modules that you can optionally include in your project. Choose which modules to include by setting **MODULES** in the makefile.
* "**src/**" is for all of your game code, entered via `main()` or `main:`. Assembly files in this folder will be included automatically. If you have enabled **C_SUPPORT**, C files in this folder will be included automatically.
* "**res/**" is for your game resources. Assembly files in this folder will be included automatically.

### Getting Started

Before you get started, install [make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm) (or `sudo apt-get install build-essential` for ubuntu) and [cc65](https://cc65.github.io/getting-started.html) and add them to your environment PATH.

    git clone git@github.com:AlchemicRaker/fire.git
    cd fire
    make

Now you should have a `fire.nes` rom you can open in an emulator of your choice.

> If you have set up make, Mesen-X (add them to your PATH!), VSCode, and installed the Alchemy65 extension, you may use `ctrl+shift+b` to build the project, and `F5` to run it with debugging.

## Unified Mapper API

### PRG Configuration Overview

| Mapper | PRG BANK | DATA BANK | SAMPLE BANK | PRG FIXED | IRQ | Notes |
| ------ | -------- | --------- | ----------- | --------- | --- | ----- |
| [NROM](https://wiki.nesdev.org/w/index.php?title=NROM) | - | - | - | $8000 | No | |
| [UxROM](https://wiki.nesdev.org/w/index.php?title=UxROM) | $8000 | - | - | $C000 | No | |
| [MMC1](https://wiki.nesdev.org/w/index.php?title=MMC1) | $8000 | - | - | $C000 | No | |
| [MMC3](https://wiki.nesdev.org/w/index.php?title=MMC3) | $8000 | $A000 | - | $C000 | Yes | PRG mode 0 |
| [MMC5](https://wiki.nesdev.org/w/index.php?title=MMC5) | $8000 | $A000 | $C000 | $E000 | Yes | PRG mode 3 |
| [FME-7](https://wiki.nesdev.org/w/index.php?title=Sunsoft_FME-7) | $8000 | $A000 | $C000 | $E000 | Yes | |
| [VRC6](https://wiki.nesdev.org/w/index.php?title=VRC6) | $8000 | $C000 | - | $E000 | Yes | (VRC6a) |
| [VRC7](https://wiki.nesdev.org/w/index.php?title=VRC7) | $8000 | $A000 | $C000 | $E000 | Yes | |
| [N163](https://wiki.nesdev.org/w/index.php?title=INES_Mapper_019) | $8000 | $A000 | $C000 | $E000 | Yes | |
| ~~[GTROM](https://wiki.nesdev.org/w/index.php?title=GTROM)~~ | $8000 | $A000 | $C000 | $E000 | No | plans below |

> Many of these mappers have configurable layouts. This template assumes that banked prg rom will use the lower addresses, and static prg rom will use the higher addresses. When possible, modes with the highest number of prg banks have been used (see "notes" column).

> GTROM and compatible / comparable mappers have 32K PRG banks. With GTROM's max capacity of 512K, that means there are 16 banks of memory that can be swapped in. The plan is to "fake" PRG, DATA, and SAMPLE BANKs, so long as their combined number of combinations is 16 or less. For instance, 1 x PRG, 4x DATA, and 4x SAMPLE BANKs would be a valid configuration.

### PRG API Reference

The availability of PRG features corresponds with the overview table above. Your game's code is entered at `main()` or `main:`, which must be located in "PRG_FIXED" (or another non-banked segment).

The PRG BANK is specially designed to be easy for a developer to navigate with code. In C you can use the "**farcall**" wrapper that will automatically handle bank switching when calling wrapped functions.

    // wrap one or more functions with the "farcall" wrapper in your headers.
    // these functions _must_ be void and take zero arguments.
    #pragma wrapped-call (push, farcall, bank)
    void pause_menu(void);
    #pragma wrapped-call (pop)

    // bank switching now happens automatically when calling those functions.
    if(PAUSE) {
        pause_menu();
    }

For assembly, the "**farjsr**" and "**farjmp**" macros are provided (via "fire.inc") that take a label as a target, and will switch to the label's bank before jumping to the address.

    .include "fire.inc" ; to get access to the macros

    .segment "PRG_BANK_0"
    loop:
        farjsr work
        jmp loop

    back:
        farjmp forth
    
    .segment "PRG_BANK_1"
    work:
        lda #$42
        rts

    forth:
        farjmp back

The following functions are available for DATA BANK and SAMPLE BANK. The DATA BANK has optional C functions to push and pop banks, that may help manage which data page is currently selected.

    void push_data_bank(char bank); //#ifdef DATA_SUPPORT
    void pop_data_bank();
    void select_data_bank(char bank);

    void select_sample_bank(char bank); //#ifdef SAMPLE_SUPPORT

Bank selection is available with assembly subroutines of the same names:

    lda #bank
    jsr select_sample_bank

    lda #bank
    jsr select_data_bank

### CHR Configuration Overview

| Mapper | 8K Select | 4K Select | 2K Select | 1K Select | Mirroring | CHR Windows |
| ------ | --------- | --------- | --------- | --------- | --------- | ----------- |
| [NROM](https://wiki.nesdev.org/w/index.php?title=NROM) | - | - | - | - | Fixed | None |
| [UxROM](https://wiki.nesdev.org/w/index.php?title=UxROM) | - | - | - | - | Fixed | None |
| [MMC1](https://wiki.nesdev.org/w/index.php?title=MMC1) | Yes | Yes | - | - | Dynamic | 4K+4K or 8K |
| [MMC3](https://wiki.nesdev.org/w/index.php?title=MMC3) | Yes | Yes | Yes | Sprite _or_ Background | Dynamic | 2Kx2 + 1Kx4 |
| [MMC5](https://wiki.nesdev.org/w/index.php?title=MMC5) | Yes | Yes | Yes | Yes | Dynamic | 1Kx8 (and more) |
| [FME-7](https://wiki.nesdev.org/w/index.php?title=Sunsoft_FME-7) | Yes | Yes | Yes | Yes | Dynamic | 1Kx8 |
| [VRC6](https://wiki.nesdev.org/w/index.php?title=VRC6) | Yes | Yes | Yes | Yes | Dynamic | 1Kx8 |
| [VRC7](https://wiki.nesdev.org/w/index.php?title=VRC7) | Yes | Yes | Yes | Yes | Dynamic | 1Kx8 |
| [N163](https://wiki.nesdev.org/w/index.php?title=INES_Mapper_019) | Yes | Yes | Yes | Yes | Dynamic | 1Kx8 + 1Kx4(NT) |
| ~~[GTROM](https://wiki.nesdev.org/w/index.php?title=GTROM)~~ | Yes | - | - | - | N/A | 8K |

> MMC3 includes two modes, the more commonly used "1K sprites", and the less commonly used "1K backgrounds". You must include `MMC3_1K_SPRITES` (for `select_chr_1k_1xxx`) or `MMC3_1K_BACKGROUNDS` (for `select_chr_1k_0xxx`) in the makefile OPTIONS in order to build MMC3.

### CHR API Reference

These functions are available based on the overview table above.
Banks are always 0-indexed, and counted in multiples according to the function's name.
As an example, `select_chr_2k_1800(2)` selects `$1000-$17FF` from CHR ROM to map into `$1800-$1FFF` of PPU memory. This is equivalent to calling `select_chr_1k_1800(4);` and `select_chr_1k_1C00(5);`.

    void select_mirror_vertical(); //#ifdef DYANIC_MIRRORING
    void select_mirror_horizontal();

    void select_chr_8k_0000(char bank) //#ifdef CHR_8K_SUPPORT
    
    void select_chr_4k_0000(char bank) //#ifdef CHR_4K_SUPPORT
    void select_chr_4k_1000(char bank)
    
    void select_chr_2k_0000(char bank) //#ifdef CHR_2K_SUPPORT
    void select_chr_2k_0800(char bank)
    void select_chr_2k_1000(char bank)
    void select_chr_2k_1800(char bank)

    void select_chr_1k_0000(char bank) //#ifdef CHR_1K_B_SUPPORT
    void select_chr_1k_0400(char bank)
    void select_chr_1k_0800(char bank)
    void select_chr_1k_0C00(char bank)
    void select_chr_1k_1000(char bank) //#ifdef CHR_1K_S_SUPPORT
    void select_chr_1k_1400(char bank)
    void select_chr_1k_1800(char bank)
    void select_chr_1k_1C00(char bank)

All of these C functions are available as assembly subroutines with the same names, and use the accumulator register as the bank argument. The above example may be written in assembly as:

    lda #$02
    jsr select_chr_2k_1800

## Vector Design

Startup, NMI, and IRQ vectors contain very common bits of code, but also contain code that is highly game-specific. We understand how critical timing is in these places, so we have provided that common code (as described below) and left the rest open for you.

### Startup Vector Implementation

1. `STARTUP_FIRE_1`
    * Boilerplate initialization of NES state, including zeroing out the ZP
    * If C is enabled, sp and the necessary BSS and DATA ranges will be initialized
    * Waits through two vblanks, using the time to zero out the nametable and load some default palettes
    * Initializes OAM shadow by setting all y values to off-screen
1. `STARTUP_MAP` is used to initialize any mapper-specific state.
1. `STARTUP_LIB` is reserved to initialize any modules you choose to include, or is empty by default.
1. `STARTUP_GAME` is an empty segment reserved for your game-specific startup code.
1. `STARTUP_FIRE_2` wraps up initialization and jumps to your game's `main()` or `main:`.

### NMI Vector Implementation

1. `NMI_FIRE_1` saves the CPU registers.
1. `NMI_TIMING` is both for you and for modules to set up precisely timed things using NMI, and is empty by default. Be sure that any code in here runs at constant speed (no branching, that may throw off other timing sensitive code). For instance, IRQ may use CPU Cycle Counting that needs a predictable starting point.
1. `NMI_FIRE_2` runs **OAMDMA**. The source is determined by the value in `nmi_oam_enable` (which becomes the high byte, and is then cleared). For instance, `nmi_oam_enable = 0x02;` would flag **OAMDMA** to run during the next NMI, copying the comonly used OAM Shadow range of `$0200` through `$02FF`.
1. `NMI_LIB` is reserved for use by any modules you choose to include, or is empty by default.
1. `NMI_GAME` is an empty segment reserved for your game-specific vblank code.
1. `NMI_FIRE_3` calls `nmi_hook()` in C, again for your own game-specific vblank code. (requires the `C_NMI_HOOK` option)
1. `NMI_AUDIO_LIB` is reserved for use by any modules you choose to include, or is empty by default.
1. `NMI_FIRE_4` restores the CPU registers and exits NMI.

The limited vertical blank time is valuable. Therefore, the only code included by default is a very standard and flexible **OAMDMA**. By setting a value (probably `$02`) to `nmi_oam_enable`, **OAMDMA** will run on that page during the next NMI.

> We know NMI cycles are valuable. Any modules that put code into NMI will prioritize doing work and calculations _prior_ to NMI.

### IRQ Vector Implementation

1. `IRQ_FIRE_1` is used to track the address of the IRQ vector, and is otherwise empty.
1. `IRQ_LIB` is reserved for use by any modules you choose to include, or is empty by default.
1. `IRQ_GAME` is an empty segment for your game-specific irq code.
1. `IRQ_FIRE_2` calls `rti`.

> We know IRQ cycles are valuable. The baseline IRQ is empty, containing only the required `rti`.

> The most common use for IRQ is for creating a single horizontal scroll split. We provide a mapper-generic way of achieving this with the "IRQ_SCREEN_SCROLL" module.

## Available Modules

### Easy Joypad Module (EASY_JOY)

Reading player input via the "standard controllers" is pretty common, but because different types of controllers are available this hasn't been baked into the base fire template. This module reads one or both controllers, and reports which keys are held, which keys have been newly pressed this frame, and which keys have released. If NMI is disabled and you need to poll for input, you may call `poll_joy();` once per frame. However while NMI is enabled, **inputs are _automatically_ polled once per NMI**.

    // include "easy_Joy.h"
    char JOY1_HELD;
    char JOY1_PRESSED;
    char JOY1_RELEASED;
    
    char JOY2_HELD; // #ifdef READ_JOY_2
    char JOY2_PRESSED;
    char JOY2_RELEASED;

    poll_joy(); // usually not needed

    // constants:
    BUTTON_A
    BUTTON_B
    BUTTON_SELECT
    BUTTON_START
    BUTTON_UP
    BUTTON_DOWN
    BUTTON_LEFT
    BUTTON_RIGHT

> This module uses the common double-read technique for DPCM safety.

### IRQ Screen Scroll Module (IRQ_SCREEN_SCROLL)

IRQs may work by counting cpu cycles or scanlines, and techniques exist for triggering multiple IRQs per frame. IRQs can be used for many things, and can require incredible precision and tuning. For this reason, we have left the IRQ segment empty, and you may include the "IRQ_SCREEN_SCROLL" module for the most common use case of IRQ: a horizontal scroll split.

    // Calls available through IRQ_SCREEN_SCROLL

    irq_screen_scroll(scanline, x, y);
    // schedules a screen scroll at the scanline
    // this will persist across frames until disabled

    irq_screen_scroll_disable();
    // disables the screen scroll

### Rapidfire Video Module (RAPIDFIRE)

Rapidfire is a video library for NES. It provides buffered NMI video updates for both asm and C, inspired by the high performance "popslide" technique.

C developers may include the library and use the `rapidfire_push_` functions to add things to the Rapidfire buffer. Once all the changes are buffered, end it with `rapidfire_ready()`.

    rapidfire_push_ppu_addr(unsigned int address);
    rapidfire_push_ppu_data(char data);
    rapidfire_push_ppu_ctrl(char ctrl);
    rapidfire_push_function(void* function);
    // (more coming later)

    rapidfire_ready();

Implement your own functions to run in nmi, using `rapidfire_push_function`:

    #include "rapidfire.h"

    void foo() { // quickly writes some tiles into the nametable
        PPU_ADDR = 0x20; PPU_ADDR = 0x03;
        PPU_DATA = 0xA0; PPU_DATA = 0xA1;
        PPU_DATA = 0xA2; PPU_DATA = 0xA3;
    }

    // once per frame queue up what you want to draw
    rapidfire_push_function(foo);
    rapidfire_ready();

Assembly developers may utilize macros to buffer updates:

    rapidfire_push_ppu_addr newaddress
    rapidfire_push_ppu_ctrl ctrl
    rapidfire_push_ppu_data data
    rapidfire_push_subroutine subroutine, arg1, arg2, ...

    jsr rapidfire_ready ; once all changes have been buffered

When implementing your own subroutine, arguments will be placed in the buffer as well. You may access each of these arguments, in order, using `pla`. After all arguments have been read from the buffer, call `rts` to move on to the next buffered item.

### FamiStudio Module (FAMISTUDIO)

This includes the NES Sound Engine for the [FamiStudio NES Music Editor](https://famistudio.org/).

Please see "lib/famistudio.s" for the extensive configuration options available for this engine.

### BHOP Module (BHOP)

This includes the WIP [BHOP](https://github.com/zeta0134/bhop) sound engine, which aims to be a drop-in replacement for FamiTracker projects.

> This is partly implemented, but should eventually support automatic sample banking on compatible mappers.
