#ifndef SCE_CTRL_H
#define SCE_CTRL_H

extern int sceCtrlGetSamplingCycle(int*);
extern int sceCtrlSetSamplingCycle(int);
extern int sceCtrlGetSamplingMode(int*);
extern int sceCtrlSetSamplingMode(int);
extern int sceCtrlPeekBufferNegative(void*, int);
extern int sceCtrlPeekBufferPositive(void*, int);
extern int sceCtrlReadBufferNegative(void*, int);
extern int sceCtrlReadBufferPositive(void*, int);

#endif

