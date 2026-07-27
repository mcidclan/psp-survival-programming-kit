.set noreorder
.set noat

.section .lib.stub, "a", @progbits
.align 2
__stub_module_LoadExecForUser:
  .word   __stub_modulestr_LoadExecForUser
  .half   0x0000
  .half   0x4001
  .byte   5
  .byte   0
  .half   1
  .word   __stub_nids_LoadExecForUser
  .word   __stub_funcs_LoadExecForUser

.section .sceStub.text, "ax", @progbits
.align 3

.global __stub_funcs_LoadExecForUser
__stub_funcs_LoadExecForUser:

.global sceKernelExitGame
.type sceKernelExitGame, @function
sceKernelExitGame:
  jr      $ra
  nop

.section .rodata.sceNid, "a", @progbits
.align 2
__stub_nids_LoadExecForUser:
  .word   0x05572A5F

.section .rodata.sceResident, "a", @progbits
.align 2
__stub_modulestr_LoadExecForUser:
  .asciz  "LoadExecForUser"
