#ifndef EASY_JOY_INC
#define EASY_JOY_INC 1

// uncomment if you want to load joy2 as well
// #define READ_JOY_2 1

// these are updated every NMI, if NMI is enabled
extern char JOY1_HELD;
#pragma zpsym ("JOY1_HELD");
extern char JOY1_PRESSED;
#pragma zpsym ("JOY1_PRESSED");
extern char JOY1_RELEASED;
#pragma zpsym ("JOY1_RELEASED");

#ifdef READ_JOY_2
extern char JOY2_HELD;
#pragma zpsym ("JOY2_HELD");
extern char JOY2_PRESSED;
#pragma zpsym ("JOY2_PRESSED");
extern char JOY2_RELEASED;
#pragma zpsym ("JOY2_RELEASED");
#endif

// If NMI is disabled, call this once per frame
void poll_joy(void);

#define BUTTON_A (0x80)
#define BUTTON_B (0x40)
#define BUTTON_SELECT (0x20)
#define BUTTON_START (0x10)
#define BUTTON_UP (0x08)
#define BUTTON_DOWN (0x04)
#define BUTTON_LEFT (0x02)
#define BUTTON_RIGHT (0x01)

#endif // #ifndef EASY_JOY_INC
