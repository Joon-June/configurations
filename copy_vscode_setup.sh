#!/bin/bash

# Check if user has provided an argument
if [ $# -eq 0 ]; then
    echo "No destination provided"
    exit 1
fi

destination=$1

# Check if destination is remote
if [[ $destination == *":"* ]]; then
    echo "Copying to remote destination: $destination"
    scp -r ./vscode $destination/.vscode
	scp ./ruff/ruff.toml $destination/ruff.toml
else
    echo "Copying to local destination: $destination"
    cp -r ./.vscode $destination
	cp ./ruff/ruff.toml $destination/ruff.toml
fi

