#include "./stdlib/stddef.h"

void kernel_main() {
    byte *video_memory = (byte*) 0xb8000;
    *video_memory = 'K';
    *(video_memory + sizeof(byte)) = 0x0f;
}

