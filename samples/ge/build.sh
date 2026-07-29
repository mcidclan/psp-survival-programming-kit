#!/bin/bash
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" \
APP_NAME="spkit" \
MODULE_NAME="spkit-ge" \
DISPLAY_NAME="spkit, Ge" \
LIBS="spk" \
CFLAGS="-Os" \
"$SPKIT_ROOT/tools/build_eboot.sh"
