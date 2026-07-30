#include <spkit.h>

struct Vertex {
  
  unsigned int color;
  unsigned short x, y, z;
} __attribute__((aligned(4)));

//#define DEPTH_BUF   0x88000
#define BUF_WIDTH   512
#define SCR_WIDTH   480
#define SCR_HEIGHT  272

#define COMMAND_COUNT 512
unsigned int _list[COMMAND_COUNT] __attribute__((aligned(16)));

void draw() {

  unsigned int* const list = (unsigned int*)(0x40000000 | (unsigned int)_list);
  const struct Vertex vertices[2] __attribute__((aligned(16))) = {
    
    [0] = {
      .color = 0xff00ffff,
      .x = 0,
      .y = 0
    },
    [1] = {
      .color = 0xff00ffff,
      .x = 480,
      .y = 272
    }
  };

  sceKernelDcacheWritebackRange((void*)vertices, sizeof(vertices));

  geStart(list);
  
  geSend(0xd2, 3);                                           // frame pixel format
  geSend(0x9c, 0);                                           // frame buffer base pointer
  geSend(0x9d, 0x200);                                       // frame buffer base width
  //geSend(0x9e, DEPTH_BUF);                                   // Set depth buffer base pointer
  //geSend(0x9f, (DEPTH_BUF >> 8) | 0x200);                    // Set depth buffer base width
  
  geSend(0xd4, (20 << 10) | 0);                              // scissor start
  geSend(0xd5, ((SCR_HEIGHT - 21) << 10) | (SCR_WIDTH - 1)); // scissor end
  geSend(0x15, (0 << 10) | 0);                               // drawing region start
  geSend(0x16, ((SCR_HEIGHT - 1) << 10) | (SCR_WIDTH - 1));  // drawing region end
  
  geSend(0xd3, (0b101 << 8) | 0x01);                         // clear enable
  geSend(0x12, 0x80011c);                                    // vertex type
  geSend(0x10, (((unsigned int)vertices) >> 8) & 0xf0000);   // vertex data base
  geSend(0x01, (unsigned int)vertices);                      // vertex data addr
  geSend(0x04, 0x60000 | 2);                                 // draw sprite
  geSend(0xd3, 0);                                           // clear disable
  
  geSend(0x0f, 0);                                           // finish
  geSend(0x0c, 0);                                           // end
  
  geEnd();
  
  int id = sceGeListEnQueue(list, NULL, NULL, NULL);
  sceGeListSync(id, 0);
}

void main(void) {
  
  const unsigned int vram = 0x44000000;
  sceDisplaySetMode(0, 480, 272);
  sceDisplaySetFrameBuf((void*)vram, 512, 3, 1);
  
  draw();
  
  unsigned short pad[8];
  do {
    sceCtrlPeekBufferPositive((void*)pad, 1);
    sceDisplayWaitVblankStart();
  } while(!(pad[SPKIT_PAD_KEY] & SPKIT_KEY_HOME));
  
  sceKernelExitGame();
}
