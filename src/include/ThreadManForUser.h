#ifndef THREAD_MAN_FOR_USER_H
#define THREAD_MAN_FOR_USER_H

extern int sceKernelCreateThread(const char*, void*, int, int, int, void*);
extern int sceKernelStartThread(int, int, void*);
extern int sceKernelExitDeleteThread(int);
extern int sceKernelReferThreadStatus(int, void*);
extern int sceKernelGetThreadId(void);
extern int sceKernelGetThreadStackFreeSize(int);
extern int sceKernelDelayThread(int);

#endif
