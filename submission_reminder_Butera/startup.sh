#!/bin/bash

# Navigate to script location
cd "$(dirname "$0")"

# Source config and functions
source ./config/config.env
source ./modules/functions.sh

# Define the path to submissions
submissions_file="./assets/submissions.txt"

# Display info
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
