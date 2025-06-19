#!/bin/bash

# Ask for user-specific folder suffix
read -p "Enter the name you used to create your folder (e.g., nelly): " user_id

# Assemble full path to environment
env_folder="submission_reminder_$user_id"

# Validate existence
if [[ ! -d "$env_folder" ]]; then
  echo "Error: Folder '$env_folder' doesn't exist."
  exit 1
fi

# Get the new assignment title
read -p "Type the new assignment name: " assignment_name

# Target config file
env_file="$env_folder/configuration/config.env"

# Confirm config file is in place
if [[ ! -f "$env_file" ]]; then
  echo "Missing config file at $env_file"
  exit 1
fi

# Perform replacement
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$assignment_name\"/" "$env_file"

echo "Assignment successfully changed to: $assignment_name"
echo "Launching updated reminder check..."

# Launch app
launch_script="$env_folder/startup.sh"

if [[ ! -f "$launch_script" ]]; then
  echo "Startup script not found at $launch_script"
  exit 1
fi

bash "$launch_script"
