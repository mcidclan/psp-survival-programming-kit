.set noreorder
.set noat

.section .lib.stub, "a", @progbits
.align 2
__stub_module_sceDisplay:
  .word   __stub_modulestr_sceDisplay
  .half   0x0000
  .half   0x4001
  .byte   5
  .byte   0
  .half   2
  .word   __stub_nids_sceDisplay
  .word   __stub_funcs_sceDisplay

.section .sceStub.text, "ax", @progbits
.align 3

.global __stub_funcs_sceDisplay
__stub_funcs_sceDisplay:

.global sceDisplaySetFrameBuf
.type sceDisplaySetFrameBuf, @function
sceDisplaySetFrameBuf:
  jr      $ra
  nop

.global sceDisplaySetMode
.type sceDisplaySetMode, @function
sceDisplaySetMode:
  jr      $ra
  nop

.section .rodata.sceNid, "a", @progbits
.align 2
__stub_nids_sceDisplay:
  .word   0x289D82FE
  .word   0x0E20F177

.section .rodata.sceResident, "a", @progbits
.align 2
__stub_modulestr_sceDisplay:
  .asciz  "sceDisplay"
