#!/bin/bash

# Prompt the user for the same name they used when creating the environment
read -p "Enter the same name you used to create your reminder directory: " username

# Construct the full directory name
APP_DIR="submission_reminder_$username"

# Confirm the directory exists
if [[ ! -d "$APP_DIR" ]]; then
  echo "❌ Directory '$APP_DIR' does not exist."
  exit 1
fi

# Prompt for new assignment name
read -p "Enter the new assignment name: " new_assignment

# Path to config file
CONFIG_FILE="$APP_DIR/config/config.env"

# Ensure config.env exists
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ config.env not found at $CONFIG_FILE"
  exit 1
fi

# Replace ASSIGNMENT value
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$CONFIG_FILE"

echo "✅ ASSIGNMENT updated to: $new_assignment"
echo "--------------------------------------------"

# Run the startup script
STARTUP_SCRIPT="$APP_DIR/startup.sh"

if [[ ! -f "$STARTUP_SCRIPT" ]]; then
  echo "❌ startup.sh not found at $STARTUP_SCRIPT"
  exit 1
fi

bash "$STARTUP_SCRIPT"
