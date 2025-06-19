#!/bin/bash

# Ask user for the name used in folder creation
read -p "Enter your name (as used in the directory name): " user_id

# Reconstruct full folder name
folder="submission_reminder_$user_id"

# Confirm the folder exists
if [[ ! -d "$folder" ]]; then
  echo "Directory '$folder' not found."
  exit 1
fi

# Ask for new assignment title
read -p "Enter new assignment name: " new_task

# Path to config file
config_path="$folder/config/config.env"

# Check if config file is present
if [[ ! -f "$config_path" ]]; then
  echo "config.env not found at $config_path"
  exit 1
fi

# Update ASSIGNMENT value using sed
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_task\"/" "$config_path"

echo "Assignment updated to: $new_task"
echo "Running the updated reminder script..."

# Path to startup script
startup_script="$folder/startup.sh"

if [[ ! -f "$startup_script" ]]; then
  echo "startup.sh not found in $folder"
  exit 1
fi

bash "$startup_script"
