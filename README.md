# Fire NES Template - WIP

A thin NES template that builds against multiple mappers and includes the most fundamental of mapper integrations (eg bank switching and far calling across banks). ~~The template includes an extendable, fully commented, community-standard NMI routine (OAM copy, APU update, controller read).~~ Basic graphics loading is included for demo purposes only, as these tend to be rather custom implementations anyway.

**THIS PROJECT IS WIP, features may not yet be as described in the README**

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

## Mappers and Features

For mappers that support PRG banking one or more banks, the first available bank, the "**PRG BANK**", will be used for code banking. If available, the second and third banks will be called the "**DATA BANK**" and "**SAMPLE BANK**" respectively. In actuality, all of these banks are functionally equivalent. However, this template provides extra features for each of these banks, if they are available.

The **PRG BANK** is stored in segments and memory areas named "PRG_BANK_0", "PRG_BANK_1", and so on. For this bank you may utilize the "farcall" (C), and "fjsr" and "fjmp" (ASM) features to easily make calls into or between any code in the **PRG BANK**. The symbol `BANK_SUPPORT` will be defined when **PRG BANK** features are available.

Despite their names, the **DATA BANK** and **SAMPLE BANK** can be used for whatever purposes you like. "select_data_bank", "push_data_bank", and "pop_data_bank" are available for navigating the data bank, and "select_sample_bank" is available for the latter bank as well. The symbols `DATA_SUPPORT` and `SAMPLE_SUPPORT` will be defined when these banks are available.

In all cases, **PRG_FIXED** is used for static code. If **PRG BANK** isn't available, all of those "BANK" segments will be lumped into **PRG_FIXED** memory and won't actually be banked.

### Mapper Configuration Overview

| Mapper | PRG BANK | DATA BANK | SAMPLE BANK | PRG FIXED | Notes |
| ------ | -------- | --------- | ---------- | ------ | ----- |
| NROM | - | - | - | $8000 | |
| UxROM | $8000 | - | - | $C000 | |
| MMC1 | $8000 | - | - | $C000 | |
| MMC3 | $8000 | $A000 | - | $C000 | PRG mode 0 |
| MMC5 | $8000 | $A000 | $C000 | $E000 | PRG mode 3 |
| FME-7 | $8000 | $A000 | $C000 | $E000 | |
| VRC6 | $8000 | $C000 | - | $E000 | (VRC6a) |
| VRC7 | $8000 | $A000 | $C000 | $E000 | |
| N163 | $8000 | $A000 | $C000 | $E000 | |
| ~~GTROM~~ | $8000 | $A000 | $C000 | $E000 | plans below |

> Many of these mappers contain configurable layouts. This template assumes that banked prg rom will use the lower addresses, and static prg rom will use the higher addresses. When possible, the highest number of prg banks has been chosen (see "notes" column).

#### GTROM notes

GTROM and compatible / comparable mappers have 32K PRG banks. With GTROM's max capacity of 512K, that means there are 16 banks of memory that can be swapped in. The plan is to "fake" PRG, DATA, and SAMPLE BANKs, so long as their combined number of combinations is 16 or less. For instance, 1 x PRG, 4x DATA, and 4x SAMPLE BANKs would be a valid configuration.

## C Features

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

## ASM Features

### PRG BANK "farjsr" and "farjmp" (todo)

This is the assembly equivalent of the C "farcall" feature described above. "farjsr" and "farjmp" are provided as a macros, and require a single symbol as a target. For instance:

    do_pause:
        farjsr pause_menu

(readme is a work in progress)
