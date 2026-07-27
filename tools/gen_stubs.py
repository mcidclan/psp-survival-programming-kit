import sys
from pathlib import Path


def parse_nids(path: Path):
  entries = []
  with open(path, "r", encoding="utf-8") as f:
    for raw_line in f:
      line = raw_line.strip()
      if not line or line.startswith("#"):
        continue
      parts = line.split()
      if len(parts) != 2:
        continue
      name, nid = parts
      entries.append((name, nid))
  return entries


def generate_stub(module_name: str, entries: list[tuple[str, str]]) -> str:
  count = len(entries)

  funcs_block = []
  for name, _ in entries:
    funcs_block.append(f"""
.global {name}
.type {name}, @function
{name}:
  jr      $ra
  nop""")
  funcs_block_str = "".join(funcs_block)

  nids_block = "\n".join(f"  .word   {nid}" for _, nid in entries)

  out = f""".set noreorder
.set noat

.section .lib.stub, "a", @progbits
.align 2
__stub_module_{module_name}:
  .word   __stub_modulestr_{module_name}
  .half   0x0000
  .half   0x4001
  .byte   5
  .byte   0
  .half   {count}
  .word   __stub_nids_{module_name}
  .word   __stub_funcs_{module_name}

.section .sceStub.text, "ax", @progbits
.align 3

.global __stub_funcs_{module_name}
__stub_funcs_{module_name}:
{funcs_block_str}

.section .rodata.sceNid, "a", @progbits
.align 2
__stub_nids_{module_name}:
{nids_block}

.section .rodata.sceResident, "a", @progbits
.align 2
__stub_modulestr_{module_name}:
  .asciz  "{module_name}"
"""
  return out


def main():
  if len(sys.argv) != 3:
    sys.exit(1)

  nids_path = Path(sys.argv[1])
  out_dir = Path(sys.argv[2])

  if not nids_path.exists():
    sys.exit(1)

  out_dir.mkdir(parents=True, exist_ok=True)

  module_name = nids_path.stem
  entries = parse_nids(nids_path)

  if not entries:
    sys.exit(1)

  stub_content = generate_stub(module_name, entries)

  out_path = out_dir / f"{module_name}.S"
  with open(out_path, "w", encoding="utf-8") as f:
    f.write(stub_content)


if __name__ == "__main__":
  main()
