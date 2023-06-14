#!/bin/bash

# Define the source and destination file paths
source_file="$HOME/.zshrc"
destination_file="./zshrc"

# Check if the source file exists
if [ -f "$source_file" ]; then
    # Copy the file to the destination
    cp "$source_file" "$destination_file"
    echo "Backedup ~/.zshrc"
else
    echo "$source_file' does not exist."
fi

