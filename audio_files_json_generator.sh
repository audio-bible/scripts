#!/bin/bash

# Base directory
BASE_DIR="./"

# Array to store all subdirectories
all_subdirs=()

# Loop through all level 1 subdirectories
for subdir in "$BASE_DIR"/*/; do
    if [ -d "$subdir" ]; then
        subdir_name=$(basename "$subdir")
        all_subdirs+=("\"$subdir_name\"")
        
        # Array to store directories in this subdirectory
        directories=()
        
        # Loop through all directories in the subdirectory
        for dir in "$subdir"*/; do
            if [ -d "$dir" ]; then
                dir_name=$(basename "$dir")
                directories+=("\"$dir_name\"")
                
                # Create a list of all files in this directory
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
        
        # Create the JSON array for directories in the subdirectory
        subdir_json_array=$(printf "[%s]" "$(IFS=,; echo "${directories[*]}")")
        
        # Write to info.json file in the subdirectory
        echo "$subdir_json_array" > "${subdir}info.json"
        echo "Created ${subdir}info.json with directories: $subdir_json_array"
    fi
done

# Create the JSON array for all subdirectories
all_subdirs_json_array=$(printf "[%s]" "$(IFS=,; echo "${all_subdirs[*]}")")

# Write to info.json file in the root directory
echo "$all_subdirs_json_array" > "${BASE_DIR}info.json"
echo "Created ${BASE_DIR}info.json with all subdirectories: $all_subdirs_json_array"
