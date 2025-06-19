#!/bin/bash

# Load config and functions
source ../configuration/config.env
source ../helpers/functions.sh

# File location
submissions_file="../data_store/submissions.txt"

echo "Current Assignment: $ASSIGNMENT"
echo "Remaining Days: $DAYS_REMAINING"
echo "--------------------------------"

check_submissions "$submissions_file"
