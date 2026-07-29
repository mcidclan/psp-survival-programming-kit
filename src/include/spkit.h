#ifndef SPKIT_H
#define SPKIT_H

#include <LoadExecForUser.h>
#include <ModuleMgrForUser.h>
#include <sceCtrl.h>
#include <sceDisplay.h>
#include <sceGe_user.h>
#include <SysMemUserForUser.h>
#include <ThreadManForUser.h>
#include <UtilsForUser.h>

extern void main(void);

#define u32         unsigned int
#define hwp         volatile u32*
#define hw(addr)    (*((hwp)(addr)))
#define sync()      asm volatile("sync")
#define DEBUG_ADDR  0x08a00000

#define NULL 0

#define SPKIT_PAD_CTRL       2
#define SPKIT_PAD_KEY        3

#define SPKIT_CTRL_SELECT    0x0001
#define SPKIT_CTRL_START     0x0008
#define SPKIT_CTRL_UP        0x0010
#define SPKIT_CTRL_RIGHT     0x0020
#define SPKIT_CTRL_DOWN      0x0040
#define SPKIT_CTRL_LEFT      0x0080
#define SPKIT_CTRL_LTRIGGER  0x0100
#define SPKIT_CTRL_RTRIGGER  0x0200
#define SPKIT_CTRL_TRIANGLE  0x1000
#define SPKIT_CTRL_CIRCLE    0x2000
#define SPKIT_CTRL_CROSS     0x4000
#define SPKIT_CTRL_SQUARE    0x8000

#define SPKIT_KEY_HOME      0x0001
#define SPKIT_KEY_HOLD      0x0002
#define SPKIT_KEY_NOTE      0x0080
#define SPKIT_KEY_SCREEN    0x0040
#define SPKIT_KEY_VOLUP     0x0010
#define SPKIT_KEY_VOLDOWN   0x0020

#define geStart(list) { \
  unsigned short cursor = 0; \
  unsigned int* const command = list;
#define geEnd() \
}
#define geSend(cmd, val) { \
  command[cursor++] = (((cmd) << 24) | (val & 0xffffff)); \
}

#endif
