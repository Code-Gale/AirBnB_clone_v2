#!/bin/bash

# Set variables
archive_path="versions/web_static_20231210202123.tgz"
timestamp=$(date +"%Y%m%d%H%M%S")
remote_path="/data/web_static/releases/web_static_$timestamp"

# Check if the archive exists
if [ ! -e "$archive_path" ]; then
    echo "Error: Archive not found"
    exit 1
fi

# Upload the archive
scp -i school "$archive_path" ubuntu@34.232.52.121:/tmp/

# Connect to the server and perform deployment steps
ssh -i school ubuntu@34.232.52.121 
    # Create target directory
    sudo mkdir -p "$remote_path"

    # Uncompress the archive and delete .tgz
    sudo tar -xzf "/tmp/archive.tgz" -C "$remote_path"

    # Remove the archive
    sudo rm "/tmp/archive.tgz"

    # Move contents into the host web_static
    sudo mv "$remote_path/web_static/*" "$remote_path/"

    # Remove extraneous web_static directory
    sudo rm -rf "$remote_path/web_static"

    # Delete pre-existing symbolic link
    sudo rm -rf /data/web_static/current

# Re-establish symbolic link
sudo ln -s "$remote_path" /data/web_static/current