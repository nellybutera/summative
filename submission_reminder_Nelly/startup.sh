#!/bin/bash

cd "$(dirname "$0")"

# Load configuration and helper script
source ./configuration/config.env
source ./helpers/functions.sh

submissions_file="./data_store/submissions.txt"

echo "Assignment in focus: $ASSIGNMENT"
echo "Time left: $DAYS_REMAINING days"
echo "--------------------------------"

check_submissions "$submissions_file"
