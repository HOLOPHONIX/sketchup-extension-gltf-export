#!/bin/bash

# Variables
EXTENSION_NAME="HOLOPHONIX_gltf_export"
SKETCHUP_PLUGINS_DIR="$HOME/Library/Application Support/SketchUp 2023/SketchUp/Plugins"
EXTENSION_SRC_DIR="../src"

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
