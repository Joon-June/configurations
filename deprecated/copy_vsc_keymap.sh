#!/bin/bash

# Set the source file path
source_file="$1"

# Determine the destination file path based on the operating system
case "$OSTYPE" in
  darwin*)  # macOS
    destination_file="$HOME/Library/Application Support/Code/User/keybindings.json"
    ;;
  linux*)   # Linux
    destination_file="$HOME/.config/Code/User/keybindings.json"
    ;;
  cygwin* | msys*)  # Windows (Cygwin or MSYS)
    destination_file="$APPDATA/Code/User/keybindings.json"
    ;;
  *)
    echo "Unsupported operating system: $OSTYPE"
    exit 1
    ;;
esac

# Check if the source file exists
if [ ! -f "$source_file" ]; then
  echo "Custom keybindings.json file not found at $source_file"
  exit 1
fi

# Check if the destination directory exists
destination_dir=$(dirname "$destination_file")
if [ ! -d "$destination_dir" ]; then
  echo "Destination directory does not exist: $destination_dir"
  exit 1
fi

# Backup existing keybindings.json file if it exists
if [ -f "$destination_file" ]; then
  backup_file="$destination_file.$(date +%Y%m%d%H%M%S).bak"
  echo "Backing up existing keybindings.json to $backup_file"
  cp "$destination_file" "$backup_file"
fi

# Copy the custom keybindings.json file to the destination
echo "Copying custom keybindings.json to $destination_file"
cp "$source_file" "$destination_file"

echo "Custom keybindings.json file has been successfully copied."

