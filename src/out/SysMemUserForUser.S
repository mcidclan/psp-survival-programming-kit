.set noreorder
.set noat

.section .lib.stub, "a", @progbits
.align 2
__stub_module_SysMemUserForUser:
  .word   __stub_modulestr_SysMemUserForUser
  .half   0x0000
  .half   0x4001
  .byte   5
  .byte   0
  .half   2
  .word   __stub_nids_SysMemUserForUser
  .word   __stub_funcs_SysMemUserForUser

.section .sceStub.text, "ax", @progbits
.align 3

.global __stub_funcs_SysMemUserForUser
__stub_funcs_SysMemUserForUser:

.global sceKernelAllocPartitionMemory
.type sceKernelAllocPartitionMemory, @function
sceKernelAllocPartitionMemory:
  jr      $ra
  nop

.global sceKernelGetBlockHeadAddr
.type sceKernelGetBlockHeadAddr, @function
sceKernelGetBlockHeadAddr:
  jr      $ra
  nop

.section .rodata.sceNid, "a", @progbits
.align 2
__stub_nids_SysMemUserForUser:
  .word   0x237DBD4F
  .word   0x9D9A5BA1

.section .rodata.sceResident, "a", @progbits
.align 2
__stub_modulestr_SysMemUserForUser:
  .asciz  "SysMemUserForUser"
