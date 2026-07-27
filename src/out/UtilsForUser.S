.set noreorder
.set noat

.section .lib.stub, "a", @progbits
.align 2
__stub_module_UtilsForUser:
  .word   __stub_modulestr_UtilsForUser
  .half   0x0000
  .half   0x4001
  .byte   5
  .byte   0
  .half   1
  .word   __stub_nids_UtilsForUser
  .word   __stub_funcs_UtilsForUser

.section .sceStub.text, "ax", @progbits
.align 3

.global __stub_funcs_UtilsForUser
__stub_funcs_UtilsForUser:

.global sceKernelDcacheWritebackInvalidateAll
.type sceKernelDcacheWritebackInvalidateAll, @function
sceKernelDcacheWritebackInvalidateAll:
  jr      $ra
  nop

.section .rodata.sceNid, "a", @progbits
.align 2
__stub_nids_UtilsForUser:
  .word   0xB435DEC5

.section .rodata.sceResident, "a", @progbits
.align 2
__stub_modulestr_UtilsForUser:
  .asciz  "UtilsForUser"
