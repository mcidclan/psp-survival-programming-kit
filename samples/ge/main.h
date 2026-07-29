#ifndef MAIN_H
#define MAIN_H

#include <spkit.h>

static inline void drawLine(void* base, const int stride, const int x,
  const int y, const int len, const unsigned int color) {

  const unsigned int offset = (x + y * stride) * 4 + (unsigned int)base;
  unsigned int* const pixels = (unsigned int*)offset;
  
  for (int i = 0; i < len; ++i) {
    pixels[i] = color;
  }
}

// use memdump 0x08a0000000 (default DEBUG_ADDR value)
static inline void debugByte(const char* msg) {
  
  volatile char *debug = (volatile char*)DEBUG_ADDR;
  
  int i = 0;
  while (msg[i] != '\0') {
    debug[i] = msg[i];
    i++;
  }
}

#endif
