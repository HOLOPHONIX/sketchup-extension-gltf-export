#!/bin/bash
set -euo pipefail

# Builds a distributable RBZ from src/ for Trimble Extension Warehouse submission
# (or the Extension Signing Portal). An RBZ is a ZIP containing exactly the root
# loader and its matching support folder, renamed to .rbz.

EXTENSION_NAME="HOLOPHONIX_gltf_export"

# Resolve paths relative to this script so it works from any working directory.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR/../src"
DIST_DIR="$SCRIPT_DIR/../dist"
RBZ_PATH="$DIST_DIR/$EXTENSION_NAME.rbz"

# Sanity checks
if [ ! -f "$SRC_DIR/$EXTENSION_NAME.rb" ]; then
  echo "Error: root loader '$SRC_DIR/$EXTENSION_NAME.rb' not found."
  exit 1
fi
if [ ! -d "$SRC_DIR/$EXTENSION_NAME" ]; then
  echo "Error: support folder '$SRC_DIR/$EXTENSION_NAME' not found."
  exit 1
fi

mkdir -p "$DIST_DIR"
rm -f "$RBZ_PATH"

# Zip from inside src/ so the archive root contains only the loader + folder.
# Exclude macOS metadata and any stray VCS files.
(
  cd "$SRC_DIR"
  zip -r -X "$RBZ_PATH" \
    "$EXTENSION_NAME.rb" \
    "$EXTENSION_NAME" \
    -x '*.DS_Store' -x '__MACOSX/*'
)

echo "Built: $RBZ_PATH"
echo "Contents:"
unzip -l "$RBZ_PATH"
