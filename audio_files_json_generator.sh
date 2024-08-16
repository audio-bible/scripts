#!/bin/bash

# Base directory
BASE_DIR="./"

# Loop through all level 1 subdirectories
for subdir in "$BASE_DIR"/*/; do
    # Get the list of directories inside the subdirectory
    directories=()
    for dir in "$subdir"*/; do
        if [ -d "$dir" ]; then
            directories+=("\"$(basename "$dir")\"")

            # Create a list of all files in this subdirectory
            files=()
            for file in "$dir"*; do
                if [ -f "$file" ]; then
                    files+=("\"$(basename "$file")\"")
                fi
            done

            # Create the JSON array for files
            file_json_array=$(printf "[%s]" "$(IFS=,; echo "${files[*]}")")

            # Write to info.json file in this directory
            echo "$file_json_array" > "${dir}info.json"
            echo "Created ${dir}info.json with files: $file_json_array"
        fi
    done

    # Create the JSON array for directories
    json_array=$(printf "[%s]" "$(IFS=,; echo "${directories[*]}")")

    # Write to info.json file in the subdirectory
    echo "$json_array" > "${subdir}info.json"
    echo "Created ${subdir}info.json with directories: $json_array"
done
