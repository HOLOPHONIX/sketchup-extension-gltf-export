#!/bin/bash
set -euo pipefail

# Variables
EXTENSION_NAME="HOLOPHONIX_gltf_export"

# Resolve paths relative to this script so it works from any working directory.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSION_SRC_DIR="$SCRIPT_DIR/../src"

# Determine the SketchUp Plugins directory.
# Priority: explicit override ($1 or $SKETCHUP_PLUGINS_DIR) > auto-detected newest install.
SUPPORT_DIR="$HOME/Library/Application Support"

if [ "${1:-}" != "" ]; then
  SKETCHUP_PLUGINS_DIR="$1"
elif [ "${SKETCHUP_PLUGINS_DIR:-}" != "" ]; then
  : # use the value already in the environment
else
  # Find every "SketchUp <year>" install and pick the highest version.
  SKETCHUP_PLUGINS_DIR=""
  while IFS= read -r dir; do
    SKETCHUP_PLUGINS_DIR="$dir/SketchUp/Plugins"
  done < <(find "$SUPPORT_DIR" -maxdepth 1 -type d -name 'SketchUp *' 2>/dev/null | sort -V)

  if [ -z "$SKETCHUP_PLUGINS_DIR" ]; then
    echo "Error: No SketchUp installation found under '$SUPPORT_DIR'."
    echo "Pass the Plugins directory explicitly, e.g.:"
    echo "  $0 \"\$HOME/Library/Application Support/SketchUp 2026/SketchUp/Plugins\""
    exit 1
  fi
fi

# Check if the source directory exists
if [ ! -d "$EXTENSION_SRC_DIR" ]; then
  echo "Error: Source directory '$EXTENSION_SRC_DIR' not found."
  exit 1
fi

# Check if the SketchUp Plugins directory exists
if [ ! -d "$SKETCHUP_PLUGINS_DIR" ]; then
  echo "Error: SketchUp Plugins directory '$SKETCHUP_PLUGINS_DIR' not found."
  exit 1
fi

# Copy the extension files to the SketchUp Plugins directory
echo "Installing $EXTENSION_NAME to $SKETCHUP_PLUGINS_DIR..."
cp -r "$EXTENSION_SRC_DIR/$EXTENSION_NAME" "$SKETCHUP_PLUGINS_DIR/"
cp "$EXTENSION_SRC_DIR/$EXTENSION_NAME.rb" "$SKETCHUP_PLUGINS_DIR/"

# Set permissions (optional, but recommended)
chmod -R 755 "$SKETCHUP_PLUGINS_DIR/$EXTENSION_NAME"
chmod 755 "$SKETCHUP_PLUGINS_DIR/$EXTENSION_NAME.rb"

echo "Installation complete! Restart SketchUp to load the extension."
