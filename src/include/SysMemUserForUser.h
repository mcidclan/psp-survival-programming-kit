#ifndef SYS_MEM_USER_FOR_USER_H
#define SYS_MEM_USER_FOR_USER_H

extern int sceKernelAllocPartitionMemory(int, const char*, int, int, void*);
extern void *sceKernelGetBlockHeadAddr(int);

#endif

