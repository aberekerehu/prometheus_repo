#!/bin/bash

# URL list file containing tar.gz URLs
url_list_file="tar_urls.txt"

# directory for extracted files
output_directory="extracted_files"

# Create the output directory if it doesn't exist
mkdir -p "$output_directory"

# Check if the URL list file exists
if [ -f "$url_list_file" ]; then
    # Read each URL from the file and process it
    while IFS= read -r tar_url; do
        # Extract the filename from the URL
        tar_filename=$(basename "$tar_url")

        # Download the tar.gz file using wget
        wget "$tar_url" -O "$output_directory/$tar_filename"

        # Check if the download was successful
        if [ $? -eq 0 ]; then
            # Extract the tar.gz file
            tar -xzvf "$output_directory/$tar_filename" -C "$output_directory"

            # Remove the tar file after extraction
            rm "$output_directory/$tar_filename"
        else
            echo "Error: Download failed for $tar_filename"
        fi
    done < "$url_list_file"

    echo "Download, extraction, and cleanup completed successfully."
else
    echo "Error: URL list file ($url_list_file) not found."
fi