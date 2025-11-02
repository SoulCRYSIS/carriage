#!/bin/bash

# Script to package the Factorio mod and move it to the mods directory

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MOD_NAME="carriage"
MOD_VERSION="0.1.0"
MOD_FOLDER="${MOD_NAME}_${MOD_VERSION}"
ZIP_NAME="${MOD_FOLDER}.zip"
FACTORIO_MODS_DIR="$HOME/Library/Application Support/factorio/mods"
TEMP_DIR="/tmp/${MOD_FOLDER}"

# Change to the script directory
cd "$SCRIPT_DIR"

# Remove old zip if it exists
if [ -f "$ZIP_NAME" ]; then
    echo "Removing existing $ZIP_NAME..."
    rm "$ZIP_NAME"
fi

# Remove old temp directory if it exists
if [ -d "$TEMP_DIR" ]; then
    echo "Removing old temp directory..."
    rm -rf "$TEMP_DIR"
fi

# Create temporary directory with correct structure
echo "Creating temporary directory: $TEMP_DIR"
mkdir -p "$TEMP_DIR"

# Copy mod files to temp directory
echo "Copying mod files..."
cp info.json "$TEMP_DIR/"
cp data.lua "$TEMP_DIR/"
cp control.lua "$TEMP_DIR/"
cp settings.lua "$TEMP_DIR/"

# Copy assets if they exist
if [ -d "graphics" ]; then
    cp -r graphics "$TEMP_DIR/"
fi

# Change to parent directory of temp folder and create zip
echo "Creating $ZIP_NAME..."
cd /tmp
zip -r "$ZIP_NAME" "$MOD_FOLDER"

# Check if zip was created successfully
if [ ! -f "/tmp/$ZIP_NAME" ]; then
    echo "Error: Failed to create $ZIP_NAME"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Create the mods directory if it doesn't exist
if [ ! -d "$FACTORIO_MODS_DIR" ]; then
    echo "Creating mods directory: $FACTORIO_MODS_DIR"
    mkdir -p "$FACTORIO_MODS_DIR"
fi

# Move the zip to the Factorio mods directory
echo "Moving $ZIP_NAME to $FACTORIO_MODS_DIR..."
mv "/tmp/$ZIP_NAME" "$FACTORIO_MODS_DIR/"

# Clean up temp directory
rm -rf "$TEMP_DIR"

if [ -f "$FACTORIO_MODS_DIR/$ZIP_NAME" ]; then
    echo "Success! Mod packaged and moved to Factorio mods directory."
    echo "Location: $FACTORIO_MODS_DIR/$ZIP_NAME"
else
    echo "Error: Failed to move $ZIP_NAME to $FACTORIO_MODS_DIR"
    exit 1
fi

