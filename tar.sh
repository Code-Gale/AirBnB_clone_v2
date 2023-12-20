#!/bin/bash

# A script that generates an archive of the contents of the web_static folder

# Get the current timestamp
timestamp=$(date "+%Y%m%d%H%M%S")

# Create the versions directory if it doesn't exist
mkdir -p versions

# Create the tar.gz archive
tar -czvf "versions/web_static_${timestamp}.tgz" web_static/

# Print the path to the created archive
echo "versions/web_static_${timestamp}.tgz"
