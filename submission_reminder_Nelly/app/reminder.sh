#!/bin/bash

# Load settings and helper functions
source ../config/config.env
source ../modules/functions.sh

submissions_file="../assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days left: $DAYS_REMAINING"
echo "-------------------------"

check_submissions "$submissions_file"
