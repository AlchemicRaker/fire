# Fire NES Template - WIP

A thin NES template that builds against multiple mappers and includes the most fundamental of mapper integrations (eg bank switching and far calling across banks). A demo is included in the "src" and "res" directories to get you started with some bank switching and on-screen graphics.

> THIS PROJECT IS WIP, features may not yet be as described in the README

## Project Goal

This project's goal is to provide a baseline NES template useful to both novice and advanced developers. This affects many aspects of this template:

* **Low opinion** design so that your game is not limited by unnecessary and incorrect constraints about how the template _thinks_ your game should run.
* **Module system** to easily include commonly used tools such as the ~~neslib~~ and ~~nesdoug~~ libraries, and the ~~Famitone5~~ and Famistudio audio engines.
* **Multi-mapper build system** that targets many common mappers used in the homebrew community. Start developing with any of these mappers _today_.
* **Mapper-agnostic banking**. Organize your code and data into banks without having to implement your own bank-switching routines. Easily swap between available PRG banks, including **far calling** between banks.
* **C and ASM** are both supported, though you may choose to disable all **C** elements of the template if desired.
* **Highly commented system** files for advanced developers to modify as they desire.
* **Boilerplate vectors** with unused `_CUSTOM` segments ready for your game's startup, NMI, and IRQ assembly code.

## Project Organization

The central code for your game, as well as this template's demo, are located in "src". Vectors for startup, nmi, and irq, as well as any features provided by this template, are all in "sys". Anything mapper specific is located in a subfolder, e.g. "sys/mmc3" for mmc3-specific code and configuration.

The makefile in the root of the project contains some build configuration. Importantly, you may switch your target mapper in this file.

This project is intended for use with cc65. The makefile expects cc65 binaries to be available on your PATH.

> This project highly recommends using VSCode, paired with Mesen-X and the Alchemy65 VSCode extension for the best NES debugging experience. This project contains a build task and launch configuration for VSCode.

### Getting Started

Before you get started, install [cc65](https://cc65.github.io/getting-started.html) and add it to your environment PATH.

    git clone git@github.com:AlchemicRaker/fire.git
    cd fire
    make

Now you should have a `fire.nes` rom you can open in an emulator of your choice.

> If you have set up VSCode, Mesen-X (add it to your PATH!), and installed the Alchemy65 extension, you may use `ctrl+shift+b` to build the project, and `F5` to run it.

## Cross-Mapper Design

For mappers that support PRG banking one or more banks, the first available bank, the "**PRG BANK**", will be used for code banking. If available, the second and third banks will be called the "**DATA BANK**" and "**SAMPLE BANK**" respectively. In actuality, all of these banks are functionally equivalent. However, this template provides extra features for each of these banks, if they are available.

The **PRG BANK** is stored in segments and memory areas named "PRG_BANK_0", "PRG_BANK_1", and so on. For this bank you may utilize the "farcall" (C), and "fjsr" and "fjmp" (ASM) features to easily make calls into or between any code in the **PRG BANK**. The symbol `BANK_SUPPORT` will be defined when **PRG BANK** features are available.

Despite their names, the **DATA BANK** and **SAMPLE BANK** can be used for whatever purposes you like. "select_data_bank", "push_data_bank", and "pop_data_bank" are available for navigating the data bank, and "select_sample_bank" is available for the latter bank as well. The symbols `DATA_SUPPORT` and `SAMPLE_SUPPORT` will be defined when these banks are available.

In all cases, **PRG_FIXED** is used for static code. If **PRG BANK** isn't available, all of those "BANK" segments will be lumped into **PRG_FIXED** memory and won't actually be banked.

### Mapper Configuration Overview

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

> Many of these mappers contain configurable layouts. This template assumes that banked prg rom will use the lower addresses, and static prg rom will use the higher addresses. When possible, the highest number of prg banks has been chosen (see "notes" column).

#### GTROM notes

GTROM and compatible / comparable mappers have 32K PRG banks. With GTROM's max capacity of 512K, that means there are 16 banks of memory that can be swapped in. The plan is to "fake" PRG, DATA, and SAMPLE BANKs, so long as their combined number of combinations is 16 or less. For instance, 1 x PRG, 4x DATA, and 4x SAMPLE BANKs would be a valid configuration.

### CHR Configuration Overview

| Mapper | 8K Select | 4K Select | 2K Select | 1K Select | CHR Windows |
| ------ | --------- | --------- | --------- | --------- | ----------- |
| [NROM](https://wiki.nesdev.org/w/index.php?title=NROM) | - | - | - | - | N/A |
| [UxROM](https://wiki.nesdev.org/w/index.php?title=UxROM) | - | - | - | - | N/A |
| [MMC1](https://wiki.nesdev.org/w/index.php?title=MMC1) | Yes | Yes | - | - | 4K+4K or 8K |
| [MMC3](https://wiki.nesdev.org/w/index.php?title=MMC3) | Yes | Yes | Yes | Sprite _or_ Background | 2Kx2 + 1Kx4 |
| [MMC5](https://wiki.nesdev.org/w/index.php?title=MMC5) | Yes | Yes | Yes | Yes | 1Kx8 (and more) |
| [FME-7](https://wiki.nesdev.org/w/index.php?title=Sunsoft_FME-7) | Yes | Yes | Yes | Yes | 1Kx8 |
| [VRC6](https://wiki.nesdev.org/w/index.php?title=VRC6) | Yes | Yes | Yes | Yes | 1Kx8 |
| [VRC7](https://wiki.nesdev.org/w/index.php?title=VRC7) | Yes | Yes | Yes | Yes | 1Kx8 |
| [N163](https://wiki.nesdev.org/w/index.php?title=INES_Mapper_019) | Yes | Yes | Yes | Yes | 1Kx8 + 1Kx4(NT) |
| ~~[GTROM](https://wiki.nesdev.org/w/index.php?title=GTROM)~~ | Yes | - | - | - | 8K |

> MMC3 includes two modes, the more commonly used "1K sprites", and the less commonly used "1K backgrounds". The `MMC3_1K_SPRITES` (for `select_chr_1k_1xxx`) and `MMC3_1K_BACKGROUNDS` (for `select_chr_1k_0xxx`) options are available for this, you may define _one_ of these in the OPTIONS in the makefile.

These functions are available based on the table above. The availability of these are cumulative, so calling `select_chr_4k_1000(bank);` will work as expected for MMC1, and will be equivalent to calling `select_chr_1k_1000(bank); select_chr_1k_1400(bank+1); select_chr_1k_1800(bank+2); select_chr_1k_1C00(bank+3);` for FME-7.

    select_chr_8k_0000(bank)
    
    select_chr_4k_0000(bank)
    select_chr_4k_1000(bank)
    
    select_chr_2k_0000(bank)
    select_chr_2k_0800(bank)
    select_chr_2k_1000(bank)
    select_chr_2k_1800(bank)

    select_chr_1k_0000(bank)
    select_chr_1k_0400(bank)
    select_chr_1k_0800(bank)
    select_chr_1k_0C00(bank)
    select_chr_1k_1000(bank)
    select_chr_1k_1400(bank)
    select_chr_1k_1800(bank)
    select_chr_1k_1C00(bank)

## Vector Design

Startup, NMI, and IRQ vectors contain very common bits of code, but also contain code that is highly game-specific. We understand how critical timing is in these places, so we have provided that common code (as described below) and left the rest open for you.

### Startup Vector Implementation

1. `PRG_INIT_1`
    * Boilerplate initialization of NES state, including zeroing out the ZP
    * If C is enabled, sp and the necessary BSS and DATA ranges will be initialized
    * Waits through two vblanks and ~~initializes the PPU~~ (_currently zeroes the nametable and loads sample palettes_)
    * ~~Initializes OAM~~ (_currently sets all sprites in OAM shadow to an off-screen y value_)
1. `PRG_INIT_MAP` is used to initialize any mapper-specific state.
1. `PRG_INIT_LIB` is reserved to initialize any modules you choose to include, or is empty by default.
1. `PRG_INIT_CUSTOM` is an empty segment where your game-specific startup code can go.
1. `PRG_INIT_2` wraps up initialization and jumps to your game's `main()` or `main:`.

### NMI Vector Implementation

1. `NMI_HANDLE_1` saves the CPU registers.
1. `NMI_HANDLE_TIMING` is both for you and for modules to set up precisely timed things using NMI, and is empty by default. Be sure that any code in here runs at constant speed (no branching, that may throw off other timing sensitive code). For instance, IRQ may use CPU Cycle Counting that needs a predictable starting point.
1. `NMI_HANDLE_2` runs OAMDMA. The source is determined by the value in `nmi_oam_enable` (which becomes the high byte, and is then cleared). For instance, `nmi_oam_enable = 0x02;` would flag OAMDMA to run during the next NMI, copying the comonly used OAM Shadow range of `$0200` through `$02FF`.
1. `NMI_HANDLE_LIB` is reserved for use by any modules you choose to include, or is empty by default.
1. `NMI_HANDLE_CUSTOM` is an empty segment where your game-specific vblank code can go.
1. `nmi_hook()` is called in C, again for your own game-specific vblank code. (requires the `C_NMI_HOOK` option)
1. `NMI_HANDLE_3` restores the CPU registers and exits NMI.

The limited vertical blank time is valuable. Therefore, the only code included by default is a very standard and flexible OAMDMA. By setting a value (probably `$02`) to `nmi_oam_enable`, OAMDMA will run on that page during the next NMI.

> We know NMI cycles are valuable. Any modules that put code into NMI will prioritize doing work and calculations _prior_ to NMI.

### IRQ Vector Implementation

1. `IRQ_HANDLE_1` is used to track the address of the IRQ vector, and is otherwise empty.
1. `IRQ_HANDLE_LIB` is reserved for use by any modules you choose to include, or is empty by default.
1. `IRQ_HANDLE_CUSTOM` is an empty segment where your game-specific irq code.
1. `IRQ_HANDLE_2` calls `rti`.

> We know IRQ cycles are valuable. The baseline IRQ is empty, containing only the required `rti`.

> The most common use for IRQ is for creating a single horizontal scroll split. We provide a mapper-generic way of achieving this with the "IRQ_SCREEN_SCROLL" module.

## C Environment Features

### PRG BANK "farcall"

When functions that are in the PRG BANK need to be called from anywhere outside their own bank, there is no guarantee that bank will actually be available. This farcall feature addresses that by allowing you to mark those functions that need to be "farcall"ed. Use the `#pragma wrapped-call (push, farcall, bank)` syntax as shown here, to "wrap" (annotate) those functions that need to be farcallable. **The function must take no arguments (void) and return void.**

An example `pause_menu.h`:

    #pragma wrapped-call (push, farcall, bank)
    void pause_menu(void);
    #pragma wrapped-call (pop)

In this example code, the `pause_menu()` function is being marked as farcallable. That means, any of your other code may call it, and it will automatically handle swapping in that bank.

    #include "pause_menu.h"
    ...
    if(PAUSE) {
        pause_menu();
    }

Know that the bank will swap every time the function is called. Consider putting loops and the functions they need to call within the same bank, in order to reduce the overhead of bank switching.

In our example, if you wish to be able to call `pause_menu()` directly without triggering bank switching, then do not include the annotated definition. A second header may be useful for this purpose.

An example `pause_menu_local.h`:

    void pause_menu(void);

If you were to include this "local" header and make a call to `pause_menu()`, it would assume the bank is already available and jump directly to it. This sidesteps the bank switching, and its overhead, entirely.

### DATA BANK controls

Three functions are available for contolling the DATA BANK.

You may choose to utilize it as a stack, which will allow multiple parts of your code to coordinate access to the DATA BANK. For instance, when you load a stage, you may wish to keep the stage data available in the bank. In the meantime, you may have a routine to load enemy data from a different bank (push), and then restore it back to the stage data when you're done (pop).

    void push_data_bank(char);
    void pop_data_bank();

If a data stack is not necessary, you may directly switch the selected banks.

    void select_data_bank(char);

### SAMPLE BANK controls

You may directly switch the selected sample banks.

    void select_sample_bank(char);

## ASM Environment Features

### PRG BANK ~~"farjsr" and "farjmp"~~ (_todo_)

This is the assembly equivalent of the C "farcall" feature described above. "farjsr" and "farjmp" are provided as a macros, and require a single symbol as a target. For instance:

    do_pause:
        farjsr pause_menu

## Available Modules

### IRQ Screen Scroll Module (IRQ_SCREEN_SCROLL)

IRQs may work by counting cpu cycles or scanlines, and techniques exist for triggering multiple IRQs per frame. IRQs can be used for many things, and can require incredible precision and tuning. For this reason, we have left the IRQ segment empty, and you may include the "IRQ_SCREEN_SCROLL" module for the most common use case of IRQ: a horizontal scroll split.

    // Calls available through IRQ_SCREEN_SCROLL

    irq_screen_scroll(scanline, x, y);
    // schedules a screen scroll at the scanline
    // this will persist across frames until disabled

    irq_screen_scroll_disable();
    // disables the screen scroll

### ~~FamiTone5 Module (FAMITONE5)~~

(_todo_)

### FamiStudio Module (FAMISTUDIO)

This includes the NES Sound Engine for the [FamiStudio NES Music Editor](https://famistudio.org/).

Please see "lib/famistudio.s" for the extensive configuration options available for this engine.
