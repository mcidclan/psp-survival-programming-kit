#ifndef UTILS_FOR_USER_H
#define UTILS_FOR_USER_H

extern void sceKernelDcacheWritebackInvalidateAll(void);
extern int sceKernelDcacheWritebackRange(void*, int);
#endif
