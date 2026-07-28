import sys

NAME_SECTION_OFFSET = 0x00000094
DATA_SECTION_OFFSET = 0x000000E8

def name_section(rel_off):
  base_off = NAME_SECTION_OFFSET
  return base_off + rel_off

def data_section(rel_off):
  base_off = DATA_SECTION_OFFSET
  return base_off + rel_off

def main():
  title = sys.argv[1] if len(sys.argv) > 1 else "spkit"
  out_path = sys.argv[2] if len(sys.argv) > 2 else "PARAM.SFO"

  title_bytes = title.encode("utf-8")
  data = bytearray(0x114 + len(title_bytes) + 1)

  def w(off, val):
    if isinstance(val, int):
      data[off:off+4] = val.to_bytes(4, "little")
    elif isinstance(val, (bytes, bytearray)):
      data[off:off+len(val)] = val
    
  w(0x000, b"\x00PSF")
  w(0x004, 0x00000101) # file format version
  w(0x008, NAME_SECTION_OFFSET)
  w(0x00C, DATA_SECTION_OFFSET)
  w(0x010, 0x00000008) # key name count

  # BOOTABLE
  w(0x014, 0x04040000)
  w(0x018, 0x00000004)
  w(0x01C, 0x00000004)
  w(0x020, 0x00000000)
  
  # CATEGORY
  w(0x024, 0x02040009)
  w(0x028, 0x00000002)
  w(0x02C, 0x00000004)
  w(0x030, 0x00000004)

  # DISC_ID
  w(0x034, 0x02040012)
  w(0x038, 0x0000000A)
  w(0x03C, 0x0000000C)
  w(0x040, 0x00000008)

  # 0, DISC_VERSION
  w(0x044, 0x0204001A)
  w(0x048, 0x00000008)
  w(0x04C, 0x00000008)
  w(0x050, 0x00000014)

  # 0, PARENTAL_LEVEL
  w(0x054, 0x04040027)
  w(0x058, 0x00000004)
  w(0x05C, 0x00000004)
  w(0x060, 0x0000001C)

  # 0, PSP_SYSTEM_VER
  w(0x064, 0x02040036)
  w(0x068, 0x00000008)
  w(0x06C, 0x00000008)
  w(0x070, 0x00000020)

  # REGION
  w(0x074, 0x04040045)
  w(0x078, 0x00000004)
  w(0x07C, 0x00000004)
  w(0x080, 0x00000028)
  
  # TITLE
  w(0x084, 0x0204004C)
  w(0x088, 0x00000005) # default title size
  w(0x08C, 0x00000006) # default max size
  w(0x090, 0x0000002C)
  
  w(name_section(0x00), b"BOOTABLE")
  w(name_section(0x09), b"CATEGORY")
  w(name_section(0x12), b"DISC_ID")
  w(name_section(0x1A), b"DISC_VERSION")   # 0
  w(name_section(0x27), b"PARENTAL_LEVEL") # 0
  w(name_section(0x36), b"PSP_SYSTEM_VER") # 0
  w(name_section(0x45), b"REGION")
  w(name_section(0x4C), b"TITLE")
  
  w(data_section(0x00), 0x00000001) # BOOTABLE
  w(data_section(0x04), b"MG")      # CATEGORY
  w(data_section(0x08), b"UCJS")    # DISC_ID
  w(data_section(0x28), 0x00008000) # REGION

  if len(sys.argv) > 1:
    w(0x088, len(title_bytes))
    w(0x08C, len(title_bytes) + 1)
    
    off = data_section(0x2C) # TITLE
    data[off:off + len(title_bytes)] = title_bytes

  with open(out_path, "wb") as f:
    f.write(data)

if __name__ == "__main__":
  main()
  
