#!/bin/bash
set -e
SRC_DIR=src
NIDS_DIR=$SRC_DIR/nids
BUILD_DIR=lib
DEPS_DIR=$BUILD_DIR/deps
OBJ_DIR=$BUILD_DIR/obj
LIB_DIR=$BUILD_DIR/lib
INC_DIR=$BUILD_DIR/include
LIB_NAME=libspk.a
OBJS=()

echo "[0/5] Cleaning previous build"
rm -rf "$OBJ_DIR" "$LIB_DIR/$LIB_NAME" "$DEPS_DIR"
mkdir -p "$OBJ_DIR" "$LIB_DIR" "$INC_DIR" "$DEPS_DIR"

echo "[1/5] Generating stub files"
shopt -s nullglob
NIDS_FILES=("$NIDS_DIR"/*.nids)
shopt -u nullglob
if [ ${#NIDS_FILES[@]} -eq 0 ]; then
  echo "  no .nids files found, skipping"
else
  for f in "${NIDS_FILES[@]}"; do
    echo "  -> $f"
    python3 tools/gen_stubs.py "$f" "$DEPS_DIR"
  done
fi

echo "[2/5] Compiling .c files"
for f in "$SRC_DIR"/*.c; do
  name=$(basename "$f" .c)
  echo "  -> $f"
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
    -I"$SRC_DIR/include" \
    -c "$f" \
    -o "$OBJ_DIR/$name.o"
  OBJS+=("$OBJ_DIR/$name.o")
done

echo "[3/5] Assembling .S files from src"
for f in "$SRC_DIR"/*.S; do
  name=$(basename "$f" .S)
  echo "  -> $f"
  mipsel-linux-gnu-as \
    -march=mips2 \
    -mabi=eabi \
    -msoft-float \
    -I"$SRC_DIR" \
    -o "$OBJ_DIR/$name.o" \
    "$f"
  OBJS+=("$OBJ_DIR/$name.o")
done

echo "[4/5] Assembling .S files from lib/deps"
shopt -s nullglob
DEPS_FILES=("$DEPS_DIR"/*.S)
shopt -u nullglob
if [ ${#DEPS_FILES[@]} -eq 0 ]; then
  echo "  no generated .S files found, skipping"
else
  for f in "${DEPS_FILES[@]}"; do
    name=$(basename "$f" .S)
    echo "  -> $f"
    mipsel-linux-gnu-as \
      -march=mips2 \
      -mabi=eabi \
      -msoft-float \
      -I"$DEPS_DIR" \
      -o "$OBJ_DIR/$name.o" \
      "$f"
    OBJS+=("$OBJ_DIR/$name.o")
  done
fi

echo "[5/5] Creating archive $LIB_NAME"
mipsel-linux-gnu-ar rcs "$LIB_DIR/$LIB_NAME" "${OBJS[@]}"
mipsel-linux-gnu-ranlib "$LIB_DIR/$LIB_NAME"

echo "Publishing headers"
cp "$SRC_DIR"/include/*.h "$INC_DIR"/
cp "$SRC_DIR"/include/*.inc "$INC_DIR"/

echo "Lib build done"
echo "  archive : $LIB_DIR/$LIB_NAME"
echo "  headers : $INC_DIR"
