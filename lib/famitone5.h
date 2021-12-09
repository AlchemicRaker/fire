
#define FAMITONE5_PLATFORM_PAL 0
#define FAMITONE5_PLATFORM_NTSC 1

void FamiToneInit(unsigned char platform, void* music_data);
void FamiToneMusicPlay(char subsong);
