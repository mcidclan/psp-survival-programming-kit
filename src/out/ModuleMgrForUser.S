.set noreorder
.set noat

.section .lib.stub, "a", @progbits
.align 2
__stub_module_ModuleMgrForUser:
  .word   __stub_modulestr_ModuleMgrForUser
  .half   0x0000
  .half   0x4001
  .byte   5
  .byte   0
  .half   1
  .word   __stub_nids_ModuleMgrForUser
  .word   __stub_funcs_ModuleMgrForUser

.section .sceStub.text, "ax", @progbits
.align 3

.global __stub_funcs_ModuleMgrForUser
__stub_funcs_ModuleMgrForUser:

.global sceKernelSelfStopUnloadModule
.type sceKernelSelfStopUnloadModule, @function
sceKernelSelfStopUnloadModule:
  jr      $ra
  nop

.section .rodata.sceNid, "a", @progbits
.align 2
__stub_nids_ModuleMgrForUser:
  .word   0xD675EBB8

.section .rodata.sceResident, "a", @progbits
.align 2
__stub_modulestr_ModuleMgrForUser:
  .asciz  "ModuleMgrForUser"
