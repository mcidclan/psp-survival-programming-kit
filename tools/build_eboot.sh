#!/bin/bash
set -e

APP_DIR="${APP_DIR:?APP_DIR must be set (path to the folder containing .c/.S files)}"
APP_NAME="${APP_NAME:-poc}"
MODULE_NAME="${MODULE_NAME:-$APP_NAME}"
DISPLAY_NAME="${DISPLAY_NAME:-${APP_NAME^^}}"
LIBS="${LIBS:-spk}"
CFLAGS="${CFLAGS:-}"

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
APP_DIR=$(cd "$APP_DIR" && pwd)
BUILD_DIR=$APP_DIR/build
LIB_DIR=$ROOT_DIR/lib/lib
INC_DIR=$ROOT_DIR/lib/include
LINKER=$ROOT_DIR/src/linker.ld

OBJS=()

echo "[0/5] Cleaning previous build"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo "[1/5] Compiling .c files"
if [ -n "$CFLAGS" ]; then
  echo "  CFLAGS: $CFLAGS"
fi
for f in "$APP_DIR"/*.c; do
  name=$(basename "$f" .c)
  echo "  -> $(realpath --relative-to="$ROOT_DIR" "$f")"
  mipsel-linux-gnu-gcc \
    -march=mips2 \
    -mabi=eabi \
    -mno-mips16 \
    -msoft-float \
    -mno-abicalls \
    -fno-pic \
    -G0 \
    -ffreestanding \
    -nostdlib \
    -I"$INC_DIR" \
    $CFLAGS \
    -c "$f" \
    -o "$BUILD_DIR/$name.o"
  OBJS+=("$BUILD_DIR/$name.o")
done

echo "[2/5] Assembling .S files"
shopt -s nullglob
for f in "$APP_DIR"/*.S; do
  name=$(basename "$f" .S)
  echo "  -> $(realpath --relative-to="$ROOT_DIR" "$f")"
  mipsel-linux-gnu-as \
    -march=mips2 \
    -mabi=eabi \
    -msoft-float \
    -I"$INC_DIR" \
    -o "$BUILD_DIR/$name.o" \
    "$f"
  OBJS+=("$BUILD_DIR/$name.o")
done
shopt -u nullglob

echo "[3/5] Link ELF against libs: $LIBS"
LIB_FLAGS=()
for lib in $LIBS; do
  LIB_FLAGS+=("-l$lib")
done

mipsel-linux-gnu-ld \
  -q \
  -T "$LINKER" \
  -zmax-page-size=128 \
  -u module_start \
  -o "$BUILD_DIR/$APP_NAME.elf" \
  --emit-relocs \
  "${OBJS[@]}" \
  -L"$LIB_DIR" "${LIB_FLAGS[@]}"
echo "  -> $(realpath --relative-to="$ROOT_DIR" "$BUILD_DIR/$APP_NAME.elf")"

echo "Patching module name"
python3 "$ROOT_DIR/tools/modname.py" "$BUILD_DIR/$APP_NAME.elf" "$MODULE_NAME"

#psp-fixup-imports "$BUILD_DIR/$APP_NAME.elf"
#echo "fixup done"

psp-prxgen "$BUILD_DIR/$APP_NAME.elf" "$BUILD_DIR/$APP_NAME.prx"
echo "  -> $(realpath --relative-to="$ROOT_DIR" "$BUILD_DIR/$APP_NAME.prx")"

echo "[4/5] Packaging EBOOT.PBP"
#mksfo "$DISPLAY_NAME" "$BUILD_DIR/PARAM.SFO" > /dev/null
python3 "$ROOT_DIR/tools/min_sfo.py" "$DISPLAY_NAME" "$BUILD_DIR/PARAM.SFO"

pack-pbp "$BUILD_DIR/EBOOT.PBP" \
  "$BUILD_DIR/PARAM.SFO" \
  NULL \
  NULL \
  NULL \
  NULL \
  NULL \
  "$BUILD_DIR/$APP_NAME.prx" \
  NULL > /dev/null
echo "  -> $(realpath --relative-to="$ROOT_DIR" "$BUILD_DIR/EBOOT.PBP")"

echo "[5/5] eboot done"
