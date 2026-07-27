.set noreorder
.set noat

.section .lib.stub, "a", @progbits
.align 2
__stub_module_ThreadManForUser:
  .word   __stub_modulestr_ThreadManForUser
  .half   0x0000
  .half   0x4001
  .byte   5
  .byte   0
  .half   7
  .word   __stub_nids_ThreadManForUser
  .word   __stub_funcs_ThreadManForUser

.section .sceStub.text, "ax", @progbits
.align 3

.global __stub_funcs_ThreadManForUser
__stub_funcs_ThreadManForUser:

.global sceKernelCreateThread
.type sceKernelCreateThread, @function
sceKernelCreateThread:
  jr      $ra
  nop

.global sceKernelStartThread
.type sceKernelStartThread, @function
sceKernelStartThread:
  jr      $ra
  nop

.global sceKernelExitDeleteThread
.type sceKernelExitDeleteThread, @function
sceKernelExitDeleteThread:
  jr      $ra
  nop

.global sceKernelGetThreadId
.type sceKernelGetThreadId, @function
sceKernelGetThreadId:
  jr      $ra
  nop

.global sceKernelReferThreadStatus
.type sceKernelReferThreadStatus, @function
sceKernelReferThreadStatus:
  jr      $ra
  nop

.global sceKernelGetThreadStackFreeSize
.type sceKernelGetThreadStackFreeSize, @function
sceKernelGetThreadStackFreeSize:
  jr      $ra
  nop

.global sceKernelDelayThread
.type sceKernelDelayThread, @function
sceKernelDelayThread:
  jr      $ra
  nop

.section .rodata.sceNid, "a", @progbits
.align 2
__stub_nids_ThreadManForUser:
  .word   0x446D8DE6
  .word   0xF475845D
  .word   0x809CE29B
  .word   0x293B45B8
  .word   0x17C1684E
  .word   0x52089CA1
  .word   0xCEADEB47

.section .rodata.sceResident, "a", @progbits
.align 2
__stub_modulestr_ThreadManForUser:
  .asciz  "ThreadManForUser"

