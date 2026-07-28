#ifndef SCE_GE_USER_H
#define SCE_GE_USER_H

int sceGeBreak(int, void*);
int sceGeContinue(void);
int sceGeDrawSync(int);
void* sceGeEdramGetAddr(void);
unsigned int sceGeEdramGetSize(void);
int sceGeEdramSetAddrTranslation(int);
int sceGeEdramSetSize(int);
unsigned int sceGeGetCmd(int);
int sceGeGetMtx(int, void*);
int sceGeGetStack(int, void*);
int sceGeListDeQueue(int);
int sceGeListEnQueue(const void*, void*, int, void*);
int sceGeListEnQueueHead(const void*, void*, int, void*);
int sceGeListSync(int, int);
int sceGeListUpdateStallAddr(int, void*);
int sceGeRestoreContext(const void*);
int sceGeSaveContext(void*);
int sceGeSetCallback(void*);
int sceGeUnsetCallback(int);

#endif

